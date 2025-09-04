import gurobipy as gb
from gurobipy import GRB


hb_benefit = [40, 38, 30, 26, 20, 18]
hb_cost = [70, 60, 50, 40, 30, 25]

m = gb.Model(name='task_1')

x = m.addVars(6, vtype=GRB.BINARY)


m.addConstr(gb.quicksum(x[i] * hb_cost[i] for i in range(6)) <= 200)
m.addConstr(gb.quicksum(x[i] for i in range(6)) <= 4)
m.addConstr(gb.quicksum(x[i] for i in [0, 1, 3, 4, 5]) >= 2)
m.addConstr(gb.quicksum(x[i] for i in [1, 2, 4]) >= 2)
m.addConstr(gb.quicksum(x[i] for i in range(5)) >= 2)


m.setObjective(gb.quicksum(x[i] * hb_benefit[i] for i in range(6)), GRB.MAXIMIZE)

m.optimize()
print(m.getAttr('X', x))
