import csv
import numpy as np
import matplotlib.pyplot as plt

N = 8.0
convData = np.zeros((0,0))
M = 8.0
with open('Cont Ratio Data - VIn.csv') as data:
    data_row = csv.reader(data, delimiter = ',')
    for row in data_row:
        convData = np.append(convData,(row[0],row[1],row[2],row[3],row[4],row[5]))

convData = convData.reshape((-1,6))
#Cut first line of text from text file and convert to float
convData = convData[1::,:].astype(np.float)
#Time steps are not evenly spaced, must use interpolation
IOut_S = convData[:,4]
VOut = convData[:,5]
VIn = convData[:,3]
IIn_S = convData[:,2]
A = 1 - np.exp(-1/(250e6*convData[:,0]*1e-9*convData[:,1]))
print(A)
VIn_C = np.arange(1.75, 3.5, 0.005)
IIn_C = 1e-9*250e9*(N*A[0]*VOut[0] + (2 - A[0])*VIn_C)/(A[0]*(N-1) + 2)
IOut_C = 1e-9*250e9*((2-A[0])*(VIn_C - VOut[0])/(A[0]*(N-1) + 2) + M*A[0]*VOut[0]/(A[0]*(M-1) + 2) + VIn_C - VOut[0])

#plt.figure(1)
#plt.plot(VIn, IIn_C, label='Calculated')
#plt.plot(VIn, IIn_S, label='Simulated')
#plt.legend()

#plt.figure(2)
#plt.plot(VIn, IOut_S, label='Simulated')
#plt.plot(VIn, IOut_C, label='Calculated')
#plt.legend()

plt.figure(3)
plt.plot(VIn, 100*IOut_S*VOut/(IIn_S*VIn), 'x', markersize=8, label='Simulated')
plt.plot(VIn_C, 100*IOut_C*VOut[0]/(IIn_C*VIn_C), label='Calculated')
plt.ylabel("Efficiency (%)")
plt.xlabel("Input Voltage (V)")
plt.legend()

N = 8.0
convData = np.zeros((0,0))
M = 8.0
with open('Cont Ratio Data - A.csv') as data:
    data_row = csv.reader(data, delimiter = ',')
    for row in data_row:
        convData = np.append(convData,(row[0],row[1],row[2],row[3],row[4],row[5]))

convData = convData.reshape((-1,6))
#Cut first line of text from text file and convert to float
convData = convData[1::,:].astype(np.float)
#Time steps are not evenly spaced, must use interpolation
IOut_S = convData[:,4]
VOut = convData[:,5]
VIn = convData[:,3]
IIn_S = convData[:,2]
A = 1 - np.exp(-1/(250e6*convData[:,0]*1e-9*convData[:,1]))
A_C = np.arange(0.6,1, 0.002)
IIn_C = 1e-9*250e9*(N*A_C*VOut[0] + (2 - A_C)*VIn[0])/(A_C*(N-1) + 2)
IOut_C = 1e-9*250e9*((2-A_C)*(VIn[0] - VOut[0])/(A_C*(N-1) + 2) + M*A_C*VOut[0]/(A_C*(M-1) + 2) + VIn[0] - VOut[0])
plt.figure(4)
plt.plot(A, 100*IOut_S*VOut/(IIn_S*VIn), 'x', markersize=8, label='Simulated')
plt.plot(A_C, 100*IOut_C*VOut[0]/(IIn_C*VIn[0]), label='Calculated')
plt.ylabel("Efficiency (%)",fontsize=10)
plt.xlabel("A")
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
