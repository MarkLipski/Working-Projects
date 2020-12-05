from sympy import *
from sympy import Poly
from sympy.solvers import solve


A = Symbol("A")
VT1 = Symbol("VT1")
VT2 = Symbol("VT2")
VB1 = Symbol("VB1")
VB2 = Symbol("VB2")
VTP1_f = Symbol("VTP1_f")
VTP2_f = Symbol("VTP2_f")
VBP1_f = Symbol("VBP1_f")
VBP2_f = Symbol("VBP2_f")
B = Symbol("B")
T = Symbol("T")
T = 0

VTP2_f = VT1 - VTP1_f + VT2
VBP2_f = VB1 + VB2 - VBP1_f
X = A*(VTP2_f*(1+T) + VT1*(1+B) + VB1 - VBP2_f)/(2+(B+T)/2) + (1-A)*VT1
VTP1_f = simplify(solve(VTP1_f - X, VTP1_f)[0])
VTP2_f = VT1 - VTP1_f + VT2
VBP2_f = VB1 + VB2 - VBP1_f
X = A*(VBP2_f*(1+B) + VB1*(1+T) + VT1 - VTP2_f)/(2+(B+T)/2) + (1-A)*VB1
VBP1_f = simplify(solve(VBP1_f - X, VBP1_f)[0])
num,den = (VBP1_f-VB1).as_numer_denom()


VTP1_f = Symbol("VTP1_f")
VTP2_f = Symbol("VTP2_f")
VBP1_f = Symbol("VBP1_f")
VBP2_f = Symbol("VBP2_f")
VBF = Symbol("VBF")
VTP2_f = VT1 + VBF - VTP1_f + VT2
VBP2_f = VB1 + VB2 - VBP1_f
X = A*(VTP2_f + VT1 + VB1 - VBP2_f + VBF)/(2) + (1-A)*(VT1+VBF)
VTP1_f = simplify(solve(VTP1_f - X, VTP1_f)[0])
VTP2_f = VT1 + VBF - VTP1_f + VT2
VBP2_f = VB1 + VB2 - VBP1_f
X = A*(VBP2_f + VB1 + VT1 - VTP2_f + VBF)/(2) + (1-A)*VB1
VBP1_f = simplify(solve(VBP1_f - X, VBP1_f)[0])
num,den = (VBP1_f-VB1).as_numer_denom()

print(VBP1_f)

#Nodal equations for (VC) are roughly
# (1) s*C*(Vt - Vb - Vti + Vbi) + s*C*T*(Vt-Vti) + (Vt-V1)/R = 0
# (2) s*C*(Vb - Vt - Vbi + Vti) + s*C*B*(Vb-Vbi) + (Vb-V2)/R = 0
#Rearranging (2)
# (2) sC(1+B)Vb + Vb/R = V2/R + sC(Vbi(1+B) + (Vt - Vti))
