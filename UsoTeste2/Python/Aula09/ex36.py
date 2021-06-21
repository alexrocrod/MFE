import matplotlib.pyplot as plt
import numpy as np

def metropolisGC(N,V,bmu,npassos,nequi): #metropolis para Grande Canonico
    nmedidas = npassos-nequi
    ni = np.zeros(V) #existe ou nao particula naquele sitio
    part_sitio=np.zeros(V)
    Nt=np.zeros(nmedidas)

    # colocacao inicial das particulas na rede
    n=0
    while n<N:
        isit = np.random.randint(V)
        if ni[isit]==0:
            ni[isit]=1
            part_sitio[n]=isit
            n+=1

    for t in range(npassos):
        for act in range(V):
            if np.random.rand()<=0.5:
                # adicionamos
                # escolher sitio ao acaso
                isit = np.random.randint(V)
                if ni[isit]==0:
                    pA = np.minimum(1,V/(N+1)*np.exp(bmu))
                    if np.random.rand()<=pA:
                        ni[isit]=1
                        N+=1
                        part_sitio[N]=isit
            else:
                # removemos
                ip = np.random.randint(N) #escolher uma particula
                pA = np.minimum(1,N/V*np.exp(-bmu))
                if np.random.rand()<=pA:
                    isit = int(part_sitio[ip])
                    ni[isit] = 0
                    part_sitio[ip]=part_sitio[N]
                    N=N-1
            # print(N)

        if t>nequi:
            Nt[t-nequi]=N
                
    return Nt

N=10
L=10
V=L*L
bmu=1
npassos=int(5e4)
nequi=int(1e3)
nmedidas = npassos-nequi
for bmu in [0.5,1,1.5,2]:
# for bmu in [1]:
    Nt= metropolisGC(N,V,bmu,npassos,nequi)

    Nmed=np.sum(Nt)/nmedidas
    print("beta*mu:",bmu,", <N>= ",Nmed)

    rhot=Nt/V
    nbins=50
    rhomax=np.max(rhot)
    rhomin=np.min(rhot)+1e-10
    # rhomin=0.45
    drho=(rhomax-rhomin)/nbins
    bins=np.arange(rhomin+drho/2,rhomax-drho/2,drho)
    h,bins=np.histogram(rhot,bins=bins)
    h=h/sum(h)/drho

    plt.figure(1)
    x=np.arange(rhomin,rhomax,0.0001)
    xm=np.exp(bmu)/(np.exp(bmu)+1)
    sigmaN= np.sqrt(V*x/(np.exp(bmu)+1))
    proht=np.exp(-V**2*(x-xm)**2/(2*sigmaN**2))*(V/np.sqrt(2*np.pi*sigmaN**2))
    plt.plot(bins[:-1],h,'x',x,proht,'-')




plt.show()

