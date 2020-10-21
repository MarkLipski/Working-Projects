import csv
import numpy as np
import matplotlib.pyplot as plt


VIn = np.arange(2,3,0.01)
VOut = 1

eta_1 = 2*VOut/(VIn)
plt.plot(VOut/VIn, eta_1, 'k', label='One Stage Dickson')

N = 4.0
M = 4.0

PIn2 = VIn*(M*VOut+VIn)/(M+1)
POut2 = VOut*((VIn-VOut)/(M+1)+N*VOut/(N+1) + VIn - VOut)

eta_2 = POut2/PIn2

plt.plot(VOut/VIn, eta_2, label='N=M=4, Continuous')

N = 8.0
M = 8.0



PIn2 = VIn*(M*VOut+VIn)/(M+1)
POut2 = VOut*((VIn-VOut)/(M+1)+N*VOut/(N+1) + VIn - VOut)

eta_2 = POut2/PIn2

plt.plot(VOut/VIn, eta_2, label='N=M=8, Continuous')

N = 12.0
M = 12.0

PIn2 = VIn*(M*VOut+VIn)/(M+1)
POut2 = VOut*((VIn-VOut)/(M+1)+N*VOut/(N+1) + VIn - VOut)

eta_2 = POut2/PIn2
plt.plot(VOut/VIn, eta_2, label='N=M=12, Continuous')

N = 16.0
M = 16.0

PIn2 = VIn*(M*VOut+VIn)/(M+1)
POut2 = VOut*((VIn-VOut)/(M+1)+N*VOut/(N+1) + VIn - VOut)

eta_2 = POut2/PIn2
plt.plot(VOut/VIn, eta_2, label='N=M=16, Continuous')

plt.ylabel('Power Conversion Efficiency (P$_{OUT}$/P$_{IN}$)')
plt.xlabel('Buck Conversion Ratio (V$_{OUT}$/V$_{IN}$)')

plt.legend()
plt.show()
