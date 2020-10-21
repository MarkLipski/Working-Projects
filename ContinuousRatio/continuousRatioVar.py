import csv
import numpy as np
import matplotlib.pyplot as plt

def plotData(data):
    IOut_S = data[:,5]
    VOut = data[:,0]
    VIn = data[:,4]
    IIn_S = data[:,3]
    A = 1 - np.exp(-1/(data[:,2]*1e-9*data[:,1]))

    A_C = np.arange(0.6,1, 0.002)
    IIn_C = 1e-9*250e9*(N*A_C*VOut[0] + (2 - A_C)*VIn[0])/(A_C*(N-1) + 2)
    IOut_C = 1e-9*250e9*((2-A_C)*(VIn[0] - VOut[0])/(A_C*(N-1) + 2) + M*A_C*VOut[0]/(A_C*(M-1) + 2) + VIn[0] - VOut[0])
    return A, 100*IOut_S*VOut/(IIn_S*VIn), A_C, 100*IOut_C*VOut[0]/(IIn_C*VIn[0])


N = 8.0
convData = np.zeros((0,0))
M = 8.0
with open('Data/Cont Ratio Data - A.csv') as data:
    data_row = csv.reader(data, delimiter = ',')
    for row in data_row:
        convData = np.append(convData,(row[0],row[1],row[2],row[3],row[4],row[5]))


convData = convData.reshape((-1,6))
#Cut first line of text from text file and convert to float
#convData = convData[1::,:].astype(np.float)
#Time steps are not evenly spaced, must use interpolation
plt.figure(4)
val = np.where(convData[:,4] == '3')
[A,eff,A_C,eff_C] = plotData(convData[val].astype(np.float))
plt.plot(A, eff, 'x', markersize=8, label='VIn=3V,Sim')
plt.plot(A_C, eff_C, 'k-.', label='VIn=3V,Calc')

val = np.where(convData[:,4] == '2.5')
[A,eff,A_C,eff_C] = plotData(convData[val].astype(np.float))
plt.plot(A, eff, 'v', markersize=8, label='VIn=2.5V,Sim')
plt.plot(A_C, eff_C, 'k--', label='VIn=2.5V,Calc')

val = np.where(convData[:,4] == '2')
[A,eff,A_C,eff_C] = plotData(convData[val].astype(np.float))
plt.plot(A, eff, '^', markersize=8, label='VIn=2V,Sim')
plt.plot(A_C, eff_C, 'k', label='VIn=2V,Calc')


plt.ylabel("Efficiency (%)",fontsize=10)
plt.legend()
plt.xlabel("A")


#plt.figure(1)
#plt.plot(A, IIn_S, '*', label='Simulated')
#plt.plot(A, IIn_C, label='Calculated')
#plt.legend()

#plt.figure(2)
#plt.plot(A, IOut_S, label='Simulated')
#plt.plot(A, IOut_C, label='Calculated')
#plt.legend()

plt.show()
