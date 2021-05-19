import matplotlib.pyplot as plt
import numpy as np

def lista_vizinhos(nmax):
    listav=-np.ones((nmax**2,4)) #indices dos vizinhos de cada estado 
                                 #comeca a -1 para nao confundir com o de indice 0
    nv=np.zeros(nmax**2) #numero de vizinhos de cada estado

    for i in range(nmax**2):
        nx= i % nmax
        ny= i // nmax
        # vizinho 1
        nx1=nx+1
        ny1=ny 
        if nx1 < nmax:
            iv = nx1+nmax*ny1
            listav[i,int(nv[i])]=iv
            nv[i]+=1
        # vizinho 2
        nx1=nx
        ny1=ny+1 
        if ny1 < nmax:
            iv = nx1+nmax*ny1
            listav[i,int(nv[i])]=iv
            nv[i]+=1
        # vizinho 3
        nx1=nx-1
        ny1=ny 
        if nx1 >= 0:
            iv = nx1+nmax*ny1
            listav[i,int(nv[i])]=iv
            nv[i]+=1
        # vizinho 4
        nx1=nx
        ny1=ny-1
        if ny1 >= 0:
            iv = nx1+nmax*ny1
            listav[i,int(nv[i])]=iv
            nv[i]+=1

    return (listav,nv)

def metropolis(T,nequi,nmedidas,N,nmax):

    #(1)
    nk=np.zeros(nmax**2)
    nk[0]=N     # todas no 1o estado
    E=2*N
    estado_particula=np.ones(nmax**2)

    #(2)
    Emedio=0
    E2medio=0
    nkmed=np.zeros(nmax**2)

    lista_viz,nvs = lista_vizinhos(nmax)
    npassos=nequi+nmedidas
    for t in range(npassos):
        for act in range(N):
            # escolher uma particula
            ip = np.random.randint(N)
            ik = int(estado_particula[ip])
            # escolha do vizinho
            iv = np.random.randint(nvs[ik])
            ikv = int(lista_viz[ik,iv])
            #calculo da variacao da energia
            nx= ik % nmax
            ny= ik // nmax
            nxv= ikv % nmax
            nyv= ikv // nmax
            dE = (nxv**2+nyv**2) - (nx**2+ny**2)
            # prob de aceitacao
            pA=np.minimum(1,nvs[ik]*(nk[ikv]+1)/(nvs[ikv]*nk[ik])*np.exp(-dE/T)) ## preciso alterar com +2 e +1 nos nks???
            if np.random.rand() <=pA:
                E += dE
                nk[ik] -= 1
                nk[ikv] += 1
            

        if t>nequi:
            Emedio +=E
            E2medio +=E**2
            nkmed += nk
    Emedio /= nmedidas
    E2medio /= nmedidas
    nkmed /= nmedidas


    return (Emedio,E2medio,nkmed)

nmax=50
N=100
nmedidas=5000#20000
nequi=5000

nTs=30 #30
Ts= np.linspace(3,300,nTs)
Emeds=np.zeros(nTs)
E2meds=np.zeros(nTs)
Cv=np.zeros(nTs)
nkmed=np.zeros(nmax**2)


for i in range(nTs):
    print("Simulação",i+1,"T",Ts[i])
    Emeds[i],E2meds[i],nkmed = metropolis(Ts[i],nequi,nmedidas,N,nmax)
    Cv[i]=(E2meds[i]-Emeds[i]**2)/(Ts[i]**2)
    Emeds[i] -=2*N
    print(Emeds[i],E2meds[i],Cv[i])
    # plt.figure(1)
    # plt.pcolormesh([Ts[:i],nkmed])
    # plt.figure(2)
    # plt.plot(Ts[:i+1],Emeds[:i+1],'kx')
    # plt.figure(3)
    # plt.plot(Ts[:i+1],Cv[:i+1],'kx')
    # plt.show()

plt.figure(2)
plt.plot(Ts,Emeds,'kx')
plt.figure(3)
plt.plot(Ts,Cv,'kx')
plt.show()
