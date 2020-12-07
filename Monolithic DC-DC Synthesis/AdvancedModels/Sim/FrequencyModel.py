import numpy as np
import csv
from scipy.fftpack import fft, ifft,fftfreq
from scipy import interpolate
import matplotlib.pyplot as plt
from scipy import signal

def alias (wave, T_S):
    N = wave.size
    new = np.zeros(N)
    for i in range(0,N):
        if (i % T_S < T_S/2):
            new[i%(T_S/2)] += wave[i]

        else:
            new[(T_S/2) - i%(T_S/2)] += wave[i]
    return new

def harmonics (wave, F_S):
    N = wave.size
    new = np.zeros(N,dtype=complex)
    #Normalize F_S around number of data points
    for i in range(0,N):
        if (i % F_S < F_S/2):
            new[i] = wave[(i % F_S)]
        else:
            new[i] = -wave[(F_S - i % F_S)]
    return new

R = 0.5
C = 1e-9
B = 0.02
T = 0.02
f_SW = 5e6

num = [1]
den = [(R*C*(2+(B+T)/2)), 1]

with open('100kHz.csv') as file:
    data = list(csv.reader(file))

#Cut first line of text from text file and convert to ndarray
ltSim = np.asarray(data[1::])

f_Data = np.char.replace(ltSim[::,0],',','')
f_Data = f_Data.astype(float)
N = f_Data.size

V_fr = ltSim[::,1].astype(float)
V_fi = ltSim[::,2].astype(float)* 1j
I_fr = ltSim[::,3].astype(float)
I_fi = ltSim[::,4].astype(float)*1j
V = V_fr + V_fi



# Application of different functions
TF = signal.TransferFunction(num, den)
[f_tf,TF_f] = signal.freqresp(TF,f_Data*2*3.14)
V_C = V*TF_f

X = harmonics(V_C,int(f_SW/f_Data[1]))
print(X[np.where(f_Data==100e3)])
print(X[np.where(f_Data==5100e3)])
H = X*TF_f

#K normalizes the data
K = (I_fi[20])/(V_fi[20])

SigPow=(np.power(np.sum(I_fi),2)+np.power(np.sum(I_fr),2),0.5)
error = (np.power((K*H.real - I_fr.real),2) + np.power((I_fi - K*H.imag),2))

plt.figure(1)
plt.semilogx(f_Data, np.power(np.power(K*H.real,2) + np.power(K*H.imag,2),0.5))
plt.figure(2)
plt.semilogx((f_Data), np.power(np.power(I_fr.real,2) + np.power(I_fi.imag,2),0.5))
plt.figure(3)



#plt.figure(2)
#plt.plot(V_t)
plt.show()
