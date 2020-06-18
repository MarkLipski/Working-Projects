from sympy import *
from sympy import Poly
from sympy.solvers import solve

def get_tf(expr, var):
    k0 = expr.subs(var,0)
    expr = expr/k0
    num,den = expr.as_numer_denom()
    zeros = roots(num)
    zz = [(1-var/z) for z in zeros]
    poles = roots(den)
    pp = [1/(1-var/p) for p in poles]

    return Mul(k0,(zz+pp))

def roots(a, b, c):
    A = (-b+sqrt(b^2 - 4*a*c))/(2*a)

#Nodal equations are roughly
# (1) s*C*(Vt - Vb + VC) + s*C*T*Vt + (Vt)/R = 0
# (2) s*C*(Vb - Vt - VC) + s*C*B*Vb + (Vb)/R = 0
s = Symbol("s")
C = Symbol("C")
V1 = Symbol("V1")
V2 = Symbol("V2")
VC = Symbol("VC")

Vt = Symbol("Vt")
Vb = Symbol("Vb")

R = Symbol("R")
B = Symbol("B")
T = Symbol("T")



#Rearranging (2)
Vb = ((VC+Vt)*s*C)/(s*C*(1+B) + 1/R)
#Rearranging (1)
G = ((Vb-VC)*s*C)/(s*C*(1+B) + 1/R)

Vt = solve(Vt-G, Vt)[0]

num,den = Vt.as_numer_denom()



#print(simplify(Y))
print("Vt = ", factor(Vt))
