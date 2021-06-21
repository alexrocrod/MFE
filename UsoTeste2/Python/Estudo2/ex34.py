import matplotlib.pyplot as plt
import numpy as np
from scipy.special import spence

from metropolis import metropolis_Fermioes_2D

# da overflow logo nas 1as iteracoes 

# algo mal, usar matlab
# ERROS:
# z da basicamente 0 
# ...


if __name__ == '__main__':

    nmax = 60 #60
    N = 100 #100
    nmedidas = 20000 #20000
    nequi = 5000 #5000


    Ts = np.linspace(3 , 300, 30)
    nTs = len(Ts)

    Emeds = np.zeros(nTs)
    E2meds = np.zeros(nTs)
    z = np.zeros(nTs)
    nkmed = np.zeros((nmax**2,nTs))

    for i,T in enumerate(Ts):
        print("Simulação",i+1,"T",T)
        Emeds[i], E2meds[i], nkmed[:,i] = metropolis_Fermioes_2D(T,nequi,nmedidas,N,nmax)
        z[i]=nkmed[0,i] / (1-nkmed[0,i] )
        print(f'T={T}, <E>={Emeds[i]-2*N},  z={z[i]}')

    print(z)

    Cv = (E2meds - Emeds**2) / (Ts**2)

    Tt = np.linspace(3 , 300, 300)

    Zt = np.exp(4*N/(np.pi*Tt))-1

    Emt = - np.pi/4 * Tt**2 * spence(1+Zt)
    Emt2 = N*Ts

    Cvt1 = N * np.ones(300)

    plt.figure(1)
    plt.plot(Ts, Emeds-2*N, 'kx')
    plt.plot(Tt, Emt, 'r-')
    plt.plot(Ts, Emt2, 'r--')

    plt.figure(2)
    plt.plot(Ts, Cv, 'kx', Tt, Cvt1, 'r-')

    plt.figure(3)
    plt.semilogy(Ts, z, 'kx', Tt[1:], Zt[1:], 'r-')
    plt.show()


