import matplotlib.pyplot as plt
import numpy as np
from numpy.core.shape_base import block

def energia(x):
    b=-1; a=0.2; c=2
    return a*x+b*x**2 + c*x**4


def mc(npassos,nequi,T):
    x=-1
    dx=0.5
    E=energia(x)
    nm=0 
    nac=0

    xt=np.zeros(npassos-nequi)
    Et=np.zeros(npassos-nequi)
    for t in range(npassos):
        xn=x+ dx*(np.random.rand()-0.5)
        En=energia(xn)
        dE=En-E

        if np.random.rand() < np.minimum(1,np.exp(-dE/T)):
            x=xn
            E=En
            nac += 1

        if t> nequi:
            xt[nm]=x
            Et[nm]=E
            nm+=1

        if t==nequi:
           nac=0

    print(f'T={T}, delta={dx}, Probabilidade Aceitar={nac/nm}')
    xh = np.arange(-2 ,2,0.05)
    h,xh=np.histogram(xt,bins=xh)
    xh=xh[:-1]
    h=h/(sum(h)*(xh[1]-xh[0]))
    return h,xh,xt,Et


npassos=int(1e6)
nequi=int(1e4)
it=0
Tv=np.arange(0.01,2,0.05)

Em=np.zeros(len(Tv))

for T in Tv:
    h,xh,xt,Et=mc(npassos,nequi,T)
    Em[it]=np.mean(Et)
    it+=1

x=np.linspace(xh[0],xh[-1],len(xh)*10)
Pst=np.exp(-energia(x)/T); 
Pst=Pst/(sum(Pst)*(x[1]-x[0]))
plt.figure(1)
plt.plot(xh,h,'k.',x,Pst,'r-'); 
plt.xlabel('x'); plt.ylabel('p(x)')
plt.figure(2)
plt.plot(Tv,Em,'k.')
plt.xlabel('T'); plt.ylabel('Em')
plt.show()
