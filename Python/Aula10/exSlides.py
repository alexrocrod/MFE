import matplotlib.pyplot as plt
import numpy as np

def componentes(listav,nv):
    n,kmax=np.shape(listav)
    comp = np.zeros(n)
    ver=np.zeros(n)
    aver=np.zeros(n)
    n_aver=0
    rot=0

    for i in range(n):
        if ver[i]==0:
            ver[i]==1
            aver[n_aver]=i
            n_aver+=1
            rot+=1
            comp[i]=rot
        while n_aver>0:
            j=int(aver[n_aver])
            n_aver-=1
            for jv in range(int(nv[j])):
                comp[int(listav[j,jv])]=rot
                if ver[int(listav[j,jv])]==0:
                    aver[n_aver]=listav[j,jv]
                    n_aver+=1
                    ver[int(listav[j,jv])]=1


    return comp

def rede_aleatoria(n,c):
    # criar a rede aleatoria
    # n = numero total de nodos
    # c=numero medio de vizinhos ou grau medio
    p=c/(n-1) #probabilide de uma aresta existir
    kmax=int(np.floor(10*c)) #numero maximo de vizinhos admitido

    listav=np.zeros((n,kmax))
    nv=np.zeros(n)
    S=np.zeros(n)

    for i in range(n-1):
        for j in range(i+1,n):
            if np.random.rand()<=p:
                listav[i,int(nv[i])]=j
                listav[j,int(nv[j])]=i
                nv[i]+=1
                nv[j]+=1

    comp=componentes(listav,nv)
    scomp=np.zeros(n)
    ncomps=int(np.max(comp))
    for rotulo in range(ncomps):
        scomp[int(rotulo)]=np.sum(comp[comp==rotulo]) 

    S = np.max(scomp)
    S=S/n

    return listav,nv,S,comp
    

n=int(1E3)
i=0
cv=np.arange(0.5,3,0.1)
S=np.zeros((len(cv),n))
R=np.zeros((len(cv),n))
smed=np.zeros((len(cv),n))
for c in cv:
    listav,nv,S[i],comp=rede_aleatoria(n,c)
    scomp=np.zeros(n)
    ncomps=int(np.max(comp))
    for rot in range(ncomps):
        rotulo=int(rot)
        scomp[rotulo]=np.sum(comp[comp==rotulo])

    S[i]=np.max(scomp)
    rS=np.argmax(scomp)
    S[i]=S[i]/n
    ns=np.zeros(n)
    for rot in range(ncomps):
        rotulo=int(rot)
        if c>1:
            if rotulo != rS:
                ns[int(scomp[rotulo])] +=1
        else:
            ns[int(scomp[rotulo])] +=1


    s=np.arange(n)
    R[i]=np.sum(s*ns)/np.sum(ns)
    # smed[i]=np.sum(s**2*ns)/(n*(1-S[i]))
    smed[i]=np.sum(s**2*ns)/np.sum(s*ns)
    i+=1


plt.plot(cv,S,'rx')
plt.xlabel('c')
plt.ylabel('S')



plt.show()

