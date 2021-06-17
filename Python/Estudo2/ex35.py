import matplotlib.pyplot as plt
import numpy as np
from scipy.special import spence

from metropolis import metropolis_Fermioes_3D

# desprezei as cenas de EF2 

if __name__ == '__main__':

    nmax = 30 # 60
    N = 100 # 200
    nmedidas = 2000 # 18000
    nequi = 2000 # 2000

    Tf = ((3*N)/(4*np.pi))**(2/3)
    Ef = ((3*N)/(4*np.pi))**(2/3)

    # Ts = np.arange(Tf/20 , 2*Tf, Tf/20)
    Ts = np.arange(2*Tf/5 , 2*Tf, Tf/5)
    nTs = len(Ts)

    Emeds = np.zeros(nTs)
    E2meds = np.zeros(nTs)
    nkmed = np.zeros((nmax**3,nTs))
    Ef2s = np.zeros(nTs)
    mu = np.zeros(nTs)

    for i,T in enumerate(Ts):
        print("Simulação",i+1,"T",T)
        Emeds[i], E2meds[i], nkmed[:,i], Ef2s[i] = metropolis_Fermioes_3D(T,nequi,nmedidas,N,nmax)
        mu[i]=3/4+T*np.log(nkmed[0,i]/(1-nkmed[0,i]))
        print(f'T={T}, <E>={Emeds[i]-3/4},  mu={mu[i]}')
    # mu=3/4+Ts*np.log(nkmed[0,:]/(1-nkmed[0,:]))
    print(mu)

    Ef2=Ef2s[-1] # perceber pq?

    Cv = (E2meds - Emeds**2) / (Ts**2)

    # Temperaturas
    Tt = np.linspace(Tf/100 , 2*Tf, 100)
    Tt1 = Tt[:25]
    Tt2 = Tt[75:]
    Tf2 = Ef2

    # Valores teoricos para T<Tf
    Et = N*3*Ef/5*(1+5*np.pi**2/12*(Tt1/Tf)**(5/2))
    mut = Ef*(1-np.pi**2/12*(Tt1/Tf)**2)
    Cvt = N*(np.pi**2/2)*(Tt1/Tf)

    # Valores teoricos para Gas ideal classico
    EGI=3*N*Tt2/2
    muGI=Tt2*np.log(4/(np.sqrt(np.pi)*3)*(Tf/Tt2)**(3/2))
    CvGI=3*N*np.ones(len(Tt2))/2

    plt.figure(1)
    plt.plot(Ts/(Tf2-3/4),(Emeds-3*N/4)/(N*Ef2),'kx')
    plt.plot(Tt1/Tf,Et/(N*Ef),'r-',Tt2/Tf,EGI/(N*Tf),'g-')

    plt.figure(2)
    plt.plot(Ts/(Tf2-3/4),mu/(Ef2-3/4),'kx')
    plt.plot(Tt1/Tf,mut/Ef,'r-', Tt2/Tf,muGI/Ef,'g-')

    plt.figure(3)
    plt.plot(Ts/(Tf2-3/4),Cv/N,'k.',Tt1/Tf,Cvt/N, 'r-')
    plt.plot(Tt2/Tf,CvGI/N,'g-')

    plt.show()


