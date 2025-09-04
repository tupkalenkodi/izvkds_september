import gurobipy as gb
from gurobipy import GRB


hb_benefit = [40, 38, 30, 26, 20, 18]
hb_cost = [70, 60, 50, 40, 30, 25]

m = gb.Model(name='task_1')

x = m.addVars(6, vtype=GRB.BINARY)


m.addConstr(gb.quicksum(x[i] * hb_cost[i] for i in range(6)) <= 200)
x_sum = gb.quicksum(x[i] for i in range(len(hb_cost)))
m.addConstr(x_sum >= 2)
m.addConstr(x_sum <= 4)


m.setObjective(gb.quicksum(x[i] * hb_benefit[i] for i in range(6)), GRB.MAXIMIZE)

m.optimize()
print(m.getAttr('X', x))
