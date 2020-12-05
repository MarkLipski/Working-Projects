import csv
import numpy as np
import matplotlib.pyplot as plt

data = np.zeros((0,0))
with open('4TerminalModel.csv') as data:
    data_row = csv.reader(data, delimiter = ',')
    l = []
    for row in data_row:
        l.append([row[0],row[1],row[2],row[3],row[4],row[5],row[6]])

data = np.asarray(l).transpose()
data = data[:,1:]
data = data.astype(np.float)


[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.01) & (data[5] == 0.01))]
plt.figure(4)
plt.plot(f/1e6, Iout, label =r'$\alpha_B = \alpha_T = 0.01$, Model')
plt.figure(5)
plt.plot(f/1e6, -Iin, label =r'$\alpha_B = \alpha_T = 0.01$, Model')
[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.05) & (data[5] == 0.05))]
plt.figure(4)
plt.plot(f/1e6, Iout, label =r'$\alpha_B = \alpha_T = 0.05$, Model')
plt.figure(5)
plt.plot(f/1e6, -Iin, label =r'$\alpha_B = \alpha_T = 0.05$, Model')

[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0) & (data[5] == 0.01))]
plt.figure(6)
plt.plot(f/1e6, Iout, label =r'$\alpha_B = 0$, $\alpha_T = 0.01$, Model')
plt.figure(7)
plt.plot(f/1e6, -Iin, label =r'$\alpha_B = 0$, $\alpha_T = 0.01$, Model')
[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0) & (data[5] == 0.05))]
plt.figure(6)
plt.plot(f/1e6, Iout, label =r'$\alpha_B = 0$, $\alpha_T = 0.05$, Model')
plt.figure(7)
plt.plot(f/1e6, -Iin, label =r'$\alpha_B = 0$, $\alpha_T = 0.05$, Model')

[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.01) & (data[5] == 0))]
plt.figure(8)
plt.plot(f/1e6, Iout, label =r'$\alpha_B = 0.01$, $\alpha_T = 0$, Model')
plt.figure(9)
plt.plot(f/1e6, -Iin, label =r'$\alpha_B = 0.01$, $\alpha_T = 0$, Model')
[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.05) & (data[5] == 0))]
plt.figure(8)
plt.plot(f/1e6, Iout, label =r'$\alpha_B = 0.05$, $\alpha_T = 0$, Model')
plt.figure(9)
plt.plot(f/1e6, -Iin, label =r'$\alpha_B = 0.05$, $\alpha_T = 0$, Model')

data = np.zeros((0,0))
with open('SCcore_TB.csv') as data:
    data_row = csv.reader(data, delimiter = ',')
    l = []
    for row in data_row:
        l.append([row[0],row[1],row[2],row[3],row[4],row[5],row[6]])

data = np.asarray(l).transpose()
data = data[:,1:]
data = data.astype(np.float)


[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.01) & (data[5] == 0.01))]
plt.figure(4)
plt.plot(f, Iout, 'x' , label =r'$\alpha_B = \alpha_T = 0.01$')
plt.figure(5)
plt.plot(f, -Iin, 'x', label =r'$\alpha_B = \alpha_T = 0.01$')
[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.05) & (data[5] == 0.05))]
plt.figure(4)
plt.plot(f, Iout, 'o', label =r'$\alpha_B = \alpha_T = 0.05$')
plt.figure(5)
plt.plot(f, -Iin, 'o',label =r'$\alpha_B = \alpha_T = 0.05$')

[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0) & (data[5] == 0.01))]
plt.figure(6)
plt.plot(f, Iout, 'x', label =r'$\alpha_B = 0$, $\alpha_T = 0.01$')
plt.figure(7)
plt.plot(f, -Iin, 'x',label =r'$\alpha_B = 0$, $\alpha_T = 0.01$')
[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0) & (data[5] == 0.05))]
plt.figure(6)
plt.plot(f, Iout, 'o',label =r'$\alpha_B = 0$, $\alpha_T = 0.05$')
plt.figure(7)
plt.plot(f, -Iin, 'o',label =r'$\alpha_B = 0$, $\alpha_T = 0.05$')

[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.01) & (data[5] == 0))]
plt.figure(8)
plt.plot(f, Iout, 'x',label =r'$\alpha_B = 0.01$, $\alpha_T = 0$')
plt.figure(9)
plt.plot(f, -Iin, 'x',label =r'$\alpha_B = 0.01$, $\alpha_T = 0$')
[f,Iin,Iout,Vout,Vin,A_t,A_b] = data[:,((data[6] == 0.05) & (data[5] == 0))]
plt.figure(8)
plt.plot(f, Iout, 'o',label =r'$\alpha_B = 0.05$, $\alpha_T = 0$')
plt.figure(9)
plt.plot(f, -Iin, 'o',label =r'$\alpha_B = 0.05$, $\alpha_T = 0$')



plt.figure(4)

plt.ylabel("IOut (mA)",fontsize=15)
plt.xlabel("$f_{SW}$ (MHz)",fontsize=14)
plt.legend()

plt.figure(5)

plt.ylabel("IIn (mA)",fontsize=15)
plt.xlabel("$f_{SW}$ (MHz)",fontsize=14)
plt.legend()

plt.figure(6)

plt.ylabel("IOut (mA)",fontsize=15)
plt.xlabel("$f_{SW}$ (MHz)",fontsize=14)
plt.legend()

plt.figure(7)

plt.ylabel("IIn (mA)",fontsize=15)
plt.xlabel("$f_{SW}$ (MHz)",fontsize=14)
plt.legend()

plt.figure(8)

plt.ylabel("IOut (mA)",fontsize=15)
plt.xlabel("$f_{SW}$ (MHz)",fontsize=14)
plt.legend()

plt.figure(9)

plt.ylabel("IIn (mA)",fontsize=15)
plt.xlabel("$f_{SW}$ (MHz)",fontsize=14)
plt.legend()

#plt.figure(1)
#plt.plot(A, IIn_S, '*', label='Simulated')
#plt.plot(A, IIn_C, label='Calculated')
#plt.legend()

#plt.figure(2)
#plt.plot(A, IOut_S, label='Simulated')
#plt.plot(A, IOut_C, label='Calculated')
#plt.legend()

plt.show()
