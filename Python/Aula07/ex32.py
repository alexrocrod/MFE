import matplotlib.pyplot as plt
import numpy as np
from scipy.special import spence


def lista_vizinhos(nmax):
    listav=-np.ones((nmax**2,4), dtype=int) #indices dos vizinhos de cada estado 
                                         #comeca a -1 para nao confundir com o de indice 0
    nv=np.zeros(nmax**2, dtype=int) #numero de vizinhos de cada estado

    for i in range(nmax**2):
        nx = i % nmax
        ny = i // nmax

        # vizinho 1
        nx1 = nx + 1
        ny1 = ny 
        if nx1 < nmax:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] = iv
            nv[i] += 1

        # vizinho 2
        nx1 = nx
        ny1 = ny + 1 
        if ny1 < nmax:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] =iv
            nv[i] += 1

        # vizinho 3
        nx1 = nx - 1
        ny1 = ny 
        if nx1 >= 0:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] = iv
            nv[i] += 1

        # vizinho 4
        nx1 = nx
        ny1 = ny - 1
        if ny1 >= 0:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] = iv
            nv[i] += 1

    return (listav,nv)

# Metropolis para bosoes 2D
def metropolis(T,nequi,nmedidas,N,nmax):

    #(1)
    nk = np.zeros( nmax**2, dtype=int)
    nk[0] = N     # todas no 1o estado
    E = 2*N
    estado_particula = np.zeros(nmax**2, dtype=int)

    #(2)
    Emedio = 0
    E2medio = 0
    nkmed = np.zeros(nmax**2, dtype=int)

    lista_viz,nvs = lista_vizinhos(nmax)

    npassos = nequi + nmedidas

    for t in range(npassos):
        for act in range(N):
            # escolher uma particula
            ip = np.random.randint(N)
            ik = estado_particula[ip]
            # escolha do vizinho
            iv = np.random.randint(nvs[ik])
            ikv = lista_viz[ik,iv]
            #calculo da variacao da energia
            # nx= ik % nmax
            nx = ik % nmax +1
            # ny= ik // nmax
            ny = ik // nmax +1
            # nxv= ikv % nmax
            nxv = ikv % nmax +1
            # nyv= ikv // nmax
            nyv = ikv // nmax +1

            dE = (nxv**2+nyv**2) - (nx**2+ny**2)
            # prob de aceitacao
            pA=np.minimum( 1, nvs[ik] * (nk[ikv] + 1) / (nvs[ikv] * nk[ik]) * np.exp(-dE/T))
            if np.random.rand() <= pA:
                E += dE
                nk[ik] -= 1
                nk[ikv] += 1
                estado_particula[ip] = ikv
            

        if t > nequi:
            Emedio += E
            E2medio += E**2
            nkmed += nk

    return (Emedio/nmedidas,E2medio/nmedidas,nkmed/nmedidas)

nmax=50
N=100
nmedidas = 2000 #20000
nequi = 5000 #5000

nTs = 30 #30
Ts = np.linspace(3,300,nTs)
Emeds = np.zeros(nTs)
E2meds = np.zeros(nTs)
Cv = np.zeros(nTs)
nkmed = np.zeros(nmax**2)


for i,T in enumerate(Ts):
    print("Simulação",i+1,"T",T)
    Emeds[i],E2meds[i],nkmed = metropolis(T,nequi,nmedidas,N,nmax)


Cv = (E2meds - Emeds**2) / (Ts**2)

Tt = np.linspace(3,300,100)
Emeds_exact = np.pi * Tt**2 * spence(np.exp(- 4*N / (np.pi*Tt))) / 4


plt.figure(1)
plt.plot(Ts,Cv,'-or')

plt.figure(2)
plt.plot(Ts, Emeds - 2*N,'rx')
plt.plot(Tt, Emeds_exact,'-b')


plt.show()
