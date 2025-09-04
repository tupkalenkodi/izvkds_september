function predator_prey(sigma, beta, delta, n)
    % Define the domain for vector field
    [x, y] = meshgrid(0:1:n, -0:1:n);


    % Define the system
    xdot = x .* (1 - x) - x .* exp(-sigma .* x) .* y;
    ydot = beta .* x .* exp(-sigma .* x) .* y - delta .* y;

    % Create figure
    clf
    quiver(x, y, xdot, ydot);
    hold on


    % Solution Curves
    f = @(t, xy) [xy(1)*(1 - xy(1)) - xy(1)*exp(-sigma*xy(1))*xy(2); 
                  beta*xy(1)*exp(-sigma*xy(1))*xy(2) - delta*xy(2)];
    
    % Initial Conditions
    prey_init = linspace(0.1, 10, 10);
    predator_init = linspace(0.1, 10, 10);
    
    % Randomize the order
    prey_init = prey_init(randperm(length(prey_init)));
    predator_init = predator_init(randperm(length(predator_init)));

    for x0 = prey_init
        for y0 = predator_init
            [~, ys] = ode45(f, 0:0.01:40, [x0, y0]);
            plot(ys(:,1), ys(:,2), "");
        end
    end


    % Plot nullclines
    fimplicit(@(x,y) (1 - x) .* exp(sigma*x) - y, [0 n 0 n], '--b', 'LineWidth', 1.5);
    fimplicit(@(x,y) beta .* x .* exp(-sigma*x) - delta, [0 n 0 n], '--r', 'LineWidth', 1.5);


    % Mark equilibria
    plot(0, 0, '.', 'MarkerSize', 30, 'Color', 'g');  % E1 = (0,0)
    plot(1, 0, '.', 'MarkerSize', 30, 'Color', 'g');  % E2 = (1,0)
    

    % Find Coexistence Equilibria
    root_func = @(x) beta*x.*exp(-sigma*x) - delta;

    % Find the Roots of the Second Nullcline
    roots_found = [];

    % Since there are at most two of them, we divide the interval
    try
        roots_found = [roots_found; fzero(root_func, [0, 1/sigma])]; % Left of peak
    catch
    end
    try
        roots_found = [roots_found; fzero(root_func, [1/sigma, n])]; % Right of peak
    catch
    end
    
    % Mark the Coexistence Exquilibria
    for x_eq = roots_found'
        y_eq = (1-x_eq)*exp(sigma*x_eq);
        if y_eq > 0
            plot(x_eq, y_eq, '.', 'MarkerSize', 30, 'Color', 'r');
        end
    end


    % Formatting
    xlabel('Prey (x)');
    ylabel('Predator (y)');
    title(sprintf('Predator-Prey Model (σ=%.2f, β=%.2f, δ=%.2f)', ...
        sigma, beta, delta))
    grid on;
    hold off;
end


% No coexistence equilibria (σ > β/(δe))
% (E_2 - stable node)
% predator_prey(3, 2 * exp(1), 1, 10)


% 1 coexistence equilibria(σ = β/(δe))
% E_2 - stable node
% predator_prey(2, 2 * exp(1), 1, 10)


% 2 coexistence equilibria(σ < β/(δe))

% E_2 - stable node,  E_4 - center, E_5 - saddle
% predator_prey(1.8, 2 * exp(1), 1, 10)
 
% E_2 - saddle,  E_4 - stable focus, E_5 - Biologically Unmeaningfull
% predator_prey(0.5, 2 * exp(1), 1, 10)
