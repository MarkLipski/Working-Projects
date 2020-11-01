import csv
import numpy as np
import matplotlib.pyplot as plt

def plotData(data):
    f = data[:,0]
    Iout = data[:,1]
    Iin = data[:,2]
    Vout = data[:,3]
    Vin = data[:,4]
    return f,Iout,Iin,Vout,Vin


convData = np.zeros((0,0))
with open('Data/Dickson_Real_N=3.csv') as data:
    data_row = csv.reader(data, delimiter = ',')
    for row in data_row:
        convData = np.append(convData,(row[0],row[1],row[2],row[3],row[4],row[5]))



convData = convData.reshape((-1,6))


#Cut first line of text from text file and convert to float
#convData = convData[1::,:].astype(np.float)
#Time steps are not evenly spaced, must use interpolation


val = np.where(convData[:,5] == '0')
[f,Iout,Iin,Vout, Vin] = plotData(convData[val].astype(np.float))
plt.figure(4)
plt.plot(f, Iout, 'x', markersize=8, label=r'$\alpha_B$ = 0')
plt.figure(5)
plt.plot(f, Iin, 'x', markersize=8, label=r'$\alpha_B$ = 0')

val = np.where(convData[:,5] == '0.01')
[f,Iout,Iin,Vout, Vin] = plotData(convData[val].astype(np.float))
plt.figure(4)
plt.plot(f, Iout, '^', markersize=8, label=r'$\alpha_B$ = 0.01')
plt.figure(5)
plt.plot(f, Iin, '^', markersize=8, label=r'$\alpha_B$ = 0.01')

val = np.where(convData[:,5] == '0.05')
[f,Iout,Iin,Vout, Vin] = plotData(convData[val].astype(np.float))
plt.figure(4)
plt.plot(f, Iout, 'v', markersize=8, label=r'$\alpha_B$ = 0.05')
plt.figure(5)
plt.plot(f, Iin, 'v', markersize=8, label=r'$\alpha_B$ = 0.05')

convData = np.zeros((0,0))
with open('Data/Dickson_Model_N3.csv') as data:
    data_row = csv.reader(data, delimiter = ',')
    for row in data_row:
        convData = np.append(convData,(row[0],row[1],row[2],row[3],row[4],row[5]))



convData = convData.reshape((-1,6))

val = np.where(convData[:,5] == '0')
[f,Iout,Iin,Vout, Vin] = plotData(convData[val].astype(np.float))
plt.figure(4)
plt.plot(f, Iout, markersize=8, label=r'$\alpha_B$ = 0, model')
plt.figure(5)
plt.plot(f, Iin, markersize=8, label=r'$\alpha_B$ = 0, model')

val = np.where(convData[:,5] == '0.01')
[f,Iout,Iin,Vout, Vin] = plotData(convData[val].astype(np.float))
plt.figure(4)
plt.plot(f, Iout, markersize=8, label=r'$\alpha_B$ = 0.01, model')
plt.figure(5)
plt.plot(f, Iin, markersize=8, label=r'$\alpha_B$ = 0.01, model')

val = np.where(convData[:,5] == '0.05')
[f,Iout,Iin,Vout, Vin] = plotData(convData[val].astype(np.float))
plt.figure(4)
plt.plot(f, Iout, markersize=8, label=r'$\alpha_B$ = 0.05, model')
plt.figure(5)
plt.plot(f, Iin,  markersize=8, label=r'$\alpha_B$ = 0.05, model')

plt.figure(4)
plt.ylabel("$I_{Out}$ (mA)",fontsize=15)
plt.legend()
plt.xlabel("$f_{SW}$ (MHz)")

plt.figure(5)
plt.ylabel("$I_{In}$ (mA)",fontsize=15)
plt.legend()
plt.xlabel("$f_{SW}$ (MHz)")

#plt.figure(1)
#plt.plot(A, IIn_S, '*', label='Simulated')
#plt.plot(A, IIn_C, label='Calculated')
#plt.legend()

#plt.figure(2)
#plt.plot(A, IOut_S, label='Simulated')
#plt.plot(A, IOut_C, label='Calculated')
#plt.legend()

plt.show()
