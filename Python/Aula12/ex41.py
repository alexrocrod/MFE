import matplotlib.pyplot as plt
import numpy as np

# LISTA COM CONDICOES FRONTEIRA PERIODICAS
def lista_vizinhos_2D_Peri(nmax):
    listav=-np.ones((nmax**2,4)) #indices dos vizinhos de cada estado 
                                 #comeca a -1 para nao confundir com o de indice 0
    nv=np.zeros(nmax**2) #numero de vizinhos de cada estado

    for i in range(nmax**2):
        nx= i % nmax
        ny= i // nmax
        # vizinho 1
        nx1=nx+1
        ny1=ny 
        if nx1 >= nmax:
            nx1=0
        iv = nx1+nmax*ny1
        listav[i,int(nv[i])]=iv
        nv[i]+=1
        # vizinho 2
        nx1=nx
        ny1=ny+1 
        if ny1 >= nmax:
            ny1=0
        iv = nx1+nmax*ny1
        listav[i,int(nv[i])]=iv
        nv[i]+=1
        # vizinho 3
        nx1=nx-1
        ny1=ny 
        if nx1 < 0:
            nx1=nmax-1
        iv = nx1+nmax*ny1
        listav[i,int(nv[i])]=iv
        nv[i]+=1
        # vizinho 4
        nx1=nx
        ny1=ny-1
        if ny1 < 0:
            ny1=nmax-1
        iv = nx1+nmax*ny1
        listav[i,int(nv[i])]=iv
        nv[i]+=1

    return (listav,nv)

# Metropolis:
# x = (s1,s2,..)
# x' = (...,-si,...)

# 1) escolher variavel i ao acaso
# 2) inverter spin si
# 3) aceitar com a probablidade pA
# 4) repetir ...

def metropolis(npassos,nequi,T,L):
    N=L**2
    # definir estado inicial
    u = np.random.rand(N)
    s=np.ones(N)
    # s[np.where(u<=0.5)]=-1
    s[np.nonzero(u<=0.5)]=-1
    # print(u)
    # print(s)
    listav,nv=lista_vizinhos_2D_Peri(L)
    E=0
    M=0
    for i in range(N):
        M+=s[i]
        for j in range(int(nv[i])):
            iv = int(listav[i,j])
            E -= s[i] * s[iv]
    E/=2 # contamos 2x cada aresta no ciclo anterior

    Emed=0
    E2med=0
    Mmed=0
    M2med=0
    for t in range(npassos):
        for act in range(N):
            i=np.random.randint(N) # i ao acaso
            # soma dos spins vizinhos:
            sv=0
            for j in range(int(nv[i])):
                iv = int(listav[i,j])
                sv+=s[iv]
            sli=-s[i]  # spin si invertido
            # dE = -sli*sv-(-s[i]*sv)  # variacao de energia
            dE = sv*(s[i]-sli) # variacao de energia
            pA = np.minimum(1,np.exp(-dE/T))
            if np.random.rand() < pA:
                E += dE
                M += -s[i]+sli
                s[i]=sli
        
        if t>nequi:
            Mmed+=abs(M) # queremos saber a ordem
            Emed+=E
            E2med+=E**2
            M2med+=M**2
    nmedidas=npassos-nequi
    Mmed/=nmedidas
    M2med/=nmedidas
    Emed/=nmedidas
    E2med/=nmedidas

    # slides da aula 7 -> Cv
    Cv = (E2med-Emed**2)/T**2

    # slides da aula 13 -> suscetibilidade, Susc
    Susc = (M2med-Mmed**2)/T


    return Emed,Mmed,Cv,Susc


Tc=2.269

L = 8 # 8, 16, 32, 64 (já é lento para 8)
N = L**2
npassos = int(5e3) #int(1e5)
nequi = int(5e2) #int(1e4)

Ts=[1.5, 1.7, 1.9, 2.1, Tc, 2.3, 2.5, 2.7]
# iTc = np.nonzero(Ts==Tc)[0]
iTc = 4
Emed=np.zeros(len(Ts))
Mmed=np.zeros(len(Ts))
Cv=np.zeros(len(Ts))
Susc=np.zeros(len(Ts))


i=0
for T in Ts:
    print("Simulação a T: ",T,", L:",L)
    Emed[i],Mmed[i],Cv[i],Susc[i] = metropolis(npassos,nequi,T,L)
    i+=1

plt.figure(1)
plt.plot(Ts,Emed/N,'x')
plt.vlines(Tc,Emed[iTc]/N*0.9,Emed[iTc]/N*1.1,'r')
plt.xlabel('Ts')
plt.ylabel('<E>/N')

plt.figure(2)
plt.plot(Ts,Cv/N,'x')
plt.vlines(Tc,Cv[iTc]/N*0.9,Cv[iTc]/N*1.1,'r')
plt.xlabel('Ts')
plt.ylabel('Cv/N')

plt.figure(3)
plt.plot(Ts,Mmed/N,'x')
plt.vlines(Tc,Mmed[iTc]/N*0.9,Mmed[iTc]/N*1.1,'r')
plt.xlabel('Ts')
plt.ylabel('<M>/N')

plt.figure(4)
plt.plot(Ts,Susc/N,'x')
plt.vlines(Tc,Susc[iTc]/N*0.9,Susc[iTc]/N*1.1,'r')
plt.xlabel('Ts')
plt.ylabel('Susc/N')


# L = 16 # 8, 16, 32, 64 (já é lento para 8)
L = 16 # 8, 16, 32, 64 (já é lento para 8)
N = L**2

Emed=np.zeros(len(Ts))
Mmed=np.zeros(len(Ts))
Cv=np.zeros(len(Ts))
Susc=np.zeros(len(Ts))


i=0
for T in Ts:
    print("Simulação a T: ",T,", L:",L)
    Emed[i],Mmed[i],Cv[i],Susc[i] = metropolis(npassos,nequi,T,L)
    i+=1

plt.figure(1)
plt.plot(Ts,Emed/N,'x')
plt.vlines(Tc,Emed[iTc]/N*0.9,Emed[iTc]/N*1.1,'r')
# plt.xlabel('Ts')
# plt.ylabel('<E>/N')

plt.figure(2)
plt.plot(Ts,Cv/N,'x')
plt.vlines(Tc,Cv[iTc]/N*0.9,Cv[iTc]/N*1.1,'r')
# plt.xlabel('Ts')
# plt.ylabel('Cv/N')

plt.figure(3)
plt.plot(Ts,Mmed/N,'x')
plt.vlines(Tc,Mmed[iTc]/N*0.9,Mmed[iTc]/N*1.1,'r')
# plt.xlabel('Ts')
# plt.ylabel('<M>/N')

plt.figure(4)
plt.plot(Ts,Susc/N,'x')
plt.vlines(Tc,Susc[iTc]/N*0.9,Susc[iTc]/N*1.1,'r')
# plt.xlabel('Ts')
# plt.ylabel('Susc/N')


plt.show()