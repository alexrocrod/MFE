import matplotlib.pyplot as plt
import numpy as np
from scipy.special import  factorial 


N = 30 # 10 particulas

# 0 <= N1 <= N sao N+1 estados
# a matrix Pi de probs é N+1 x N+1
# Pi(i,j) prob de transitar de i para j


Pi = np.zeros((N+1,N+1))

# Precorrer todos os estados
for N1 in range(N + 1):
    # Número de partículas no estado j
    # estados finais possíveis
    i1 = N1 + 1
    i2 = N1 - 1
    
    if i1 < N + 1:
        Pi[i1, N1] = 1 - N1 / N
    
    if i2 >= 0:
        Pi[i2, N1] = N1 / N

print("Pi",Pi,"\n")


####################################
# b)

D, V = np.linalg.eig(Pi)

idx_vp1 = np.where(D == max(D))[0][0]

ps1 = V[:, idx_vp1] / np.sum(V[:, idx_vp1])

n1 = np.arange(0, N + 1)
pst = factorial(N) / (factorial(N - n1) * factorial(n1)) * 2**(-N)

plt.figure(1)
plt.plot(n1, ps1, 'or', n1, pst, '-b')

####################################

npassos=1000
N1=np.zeros(npassos+1)
N1_med=np.zeros(npassos+1)
N1[0]=N

for t in range(npassos):
    w1=1-N1[t]/N # prob subir
    # w2 = N1/N # prob diminuir
    if np.random.rand(1) <= w1:
        N1[t+1]= N1[t]+1
    else:
        N1[t+1]= N1[t]-1

    N1_med+=N1

N1_med/=npassos


plt.figure(2)
plt.plot(np.arange(0, npassos + 1), N1)

t_st = 100
h, xh = np.histogram(N1[t_st:], np.arange(0, N + 1))
h = h / np.sum(h)

plt.figure(3)
plt.plot(n1, ps1, 'or', n1, pst, '-b')
plt.bar(xh[:-1], h)

####################################
N=30
npassos=200
nreal=100
N1_med=np.zeros(npassos+1)

for real in range(nreal):
    N1=np.zeros(npassos+1)
    N1[0]=N

    for t in range(npassos):
        w1=1-N1[t]/N # prob subir
        # w2 = N1/N # prob diminuir
        if np.random.rand(1) <= w1:
            N1[t+1]= N1[t]+1
        else:
            N1[t+1]= N1[t]-1

    N1_med+=N1

N1_med/=nreal

plt.figure(4)
plt.plot(np.arange(0, npassos + 1), N1)

t_st = 100
h, xh = np.histogram(N1[t_st:], np.arange(0, N + 1))
h = h / np.sum(h)

plt.figure(5)
plt.plot(n1, ps1, 'or', n1, pst, '-b')
plt.bar(xh[:-1], h)

plt.figure(6)
t=np.arange(0, npassos + 1)
N1_med_teorico=N/2+(N1[0]-N/2)*np.exp(-t*np.log(1/(1-2/N)))

plt.plot(t, N1_med, 'k-',t, N1_med_teorico, 'r-')
plt.xlim([0,npassos])
plt.ylim([0,N])


####################################

plt.show()