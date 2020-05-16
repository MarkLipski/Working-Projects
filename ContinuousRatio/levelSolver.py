from sympy import *

A = Symbol("A", positive=True)

m1 = Matrix([
    [A, 0, 0],
    [A*(1-A), A, 0],
    [A*pow((1-A),2), A*(1-A), A]
])
n1 = Matrix([2*A+1,A + 1,1])/(A*2 + 2)
f1 = Matrix([1-A, pow(1-A,2),pow(1-A,3)
])
m14 = Matrix([
    [A, 0, 0,0],
    [A*(1-A), A, 0,0],
    [A*pow((1-A),2), A*(1-A), A,0],
    [A*pow((1-A),3),A*pow((1-A),2), A*(1-A), A],
])
n14 = Matrix([3*A+1,2*A+1,A + 1,1])/(A*3 + 2)
f14 = Matrix([1-A, pow(1-A,2),pow(1-A,3),pow(1-A,4)])

m3 = Matrix([
    [A, 0, 0],
    [A*(1-A), A, 0],
    [A*pow((1-A),2), A*(1-A), A]
])
n3 = Matrix([1,A + 1,2*A+1])
print(simplify(m1*n1+f1))
print(simplify(m14*n14+f14))
print(simplify(m3*n3))

VOut = Symbol("VOut", positive=True)
VIn = Symbol("VIn", positive=True)
N = Symbol("N",positive=True)
M = Symbol("M",positive=True)
X = (2 - A)*(VIn - VOut)/(A *(N-1) + 2)
Y = M*A*VOut/(A*(M-1) + 2)
Z = X + Y + VIn - VOut

IIn = (N*A*VOut + (2 - A)*VIn)/(A*(N-1) + 1)
IOut = ((2 - A)*(VIn - VOut)/(A*(N-1) + 2) + M*A*VOut/(A*(M-1) + 2) + VIn - VOut)
eta = IOut*VOut/(IIn*VIn)

print(simplify(eta))
print(Z)
print(simplify(Z))
