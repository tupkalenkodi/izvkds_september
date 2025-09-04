% Define a range for x, (-1, 5) was chosen to cover negative values and to 
% depict the behaviour around the maximum.
x = linspace(-1, 5, 1000);

figure;
hold on;

% Plot f(x) for each sigma.
plot(x, x .* exp(-0.5 * x), 'Color', 'r', 'LineWidth', 1.5, ...
         'DisplayName', '\sigma = 0.5');

plot(x, x .* exp(-1 * x), 'Color', 'g', 'LineWidth', 1.5, ...
         'DisplayName', '\sigma = 1');

plot(x, x .* exp(-2 * x), 'Color', 'b', 'LineWidth', 1.5, ...
         'DisplayName', '\sigma = 2');

% Add labels, title, legend and grid.
xlabel('x');
ylabel('f(x) = x e^{-\sigma x}');
title('f(x) for Different \sigma Values');
legend show;
grid on;

% Limit the y-axis for better depictability.
ylim([-1, 1]);

hold off;
