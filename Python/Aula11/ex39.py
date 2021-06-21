import matplotlib.pyplot as plt
import numpy as np


def componentes(listav,nv):
    n,kmax=np.shape(listav)
    comp = np.zeros(n)
    ver=np.zeros(n,dtype=np.int64)
    aver=np.zeros(n,dtype=np.int64)
    n_aver=0
    rot=0
    for i in range(n):
        if ver[i]==0:
            ver[i]==1
            aver[n_aver]=i
            n_aver+=1
            comp[i]=rot
            rot+=1
        while n_aver>0:
            n_aver-=1
            j=aver[n_aver]
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
    # c = numero medio de vizinhos ou grau medio
    p = c/(n-1) # probabilide de uma aresta existir
    kmax=int(np.floor(10*c)) # numero maximo de vizinhos admitido

    listav=np.zeros((n,kmax+1)) # ou kmax?
    nv=np.zeros(n,dtype=np.int64)
    S=np.zeros(n)

    for i in range(n):
        for j in range(i+1,n):
            if np.random.rand()<=p:
                listav[i,nv[i]]=j
                listav[j,nv[j]]=i
                nv[i]+=1
                nv[j]+=1

    comp=componentes(listav,nv)
    scomp=np.zeros(n)
    ncomps=int(np.max(comp))
    for rotulo in range(ncomps):
        scomp[rotulo]=(comp==rotulo).sum() 

    S = np.max(scomp)
    print(np.argmax(scomp))
    return listav,nv,S/n,comp
    
def roleta(nr,pr):
    u = np.random.rand()
    pacum = 0
    for i in range(nr):
        pacum = pacum+pr[i]
        if u <= pacum:
            return i
    return 0

def constroi_classe(N,e,listav,nv,kmax):
    classes = np.zeros((N,kmax+1),dtype=np.int64)
    n_classe = np.zeros(kmax+1,dtype=np.int64)
    for i in range(N):
        if e[i]==0: # suscetivel
            # calcular nº de vizinhos infetados
            ni=-1
            for j in range(int(nv[i])):
                if e[int(listav[i,j])]==1:
                    ni+=1
            if ni>=0:
                classes[n_classe[ni],ni]=i
                n_classe[ni]+=1
        elif e[i]==1:
            classes[n_classe[kmax],kmax]=i
            n_classe[kmax]+=1
    return(classes,n_classe)

def MC_t_continuo(N, beta, gama, listav, nv, e, kmax, n_classe, classe, ntransicoes):
    ns = np.zeros(ntransicoes)
    ni = np.zeros(ntransicoes)
    nr = np.zeros(ntransicoes)
    t = np.zeros(ntransicoes)
    pr = np.zeros(kmax+1)
    ns[0] = (e==0).sum()
    ni[0] = (e==1).sum()
    nr[0] = N - ns[0] - ni[0]
    print(ns[0],ni[0],nr[0])

    for tr in range(ntransicoes-1):
        # copiar info da transicao anterior:
        ns[tr+1]=ns[tr]
        ni[tr+1]=ni[tr]
        nr[tr+1]=nr[tr]

        # taxa total de transicao:
        vec = np.array(range(kmax))
        lamb = np.sum(vec * beta * n_classe[:kmax])
        lamb += gama * n_classe[kmax]

        if lamb==0:
            print("Epidemia Terminou, Nº de transições:", tr)
            return (t,ns,ni,nr)
        
        tau= -np.log(1 - np.random.rand()) / lamb # tempo espera ate transicao
        t[tr+1] = t[tr] + tau # instante em q se da a transicao
        # fazer a transiacao:
        pr = np.zeros(kmax+1)
        pr[:kmax] = vec * n_classe[:kmax] * beta/ lamb
        pr[kmax] = gama * n_classe[kmax] /lamb
        
        caso = int(roleta(kmax+1,pr))

        i = np.random.randint(n_classe[caso])

        if caso != kmax:
            # um suscetivel infetou-se
            # escolher um dos suscetiveis:
            e[int(classe[i,caso])] = 1
            ns[tr+1] -= 1
            ni[tr+1] += 1
        else:
            e[int(classe[i,caso])] = 2 # recuperou
            ni[tr+1] -= 1
            nr[tr+1] += 1

        classe,n_classe=constroi_classe(N,e,listav,nv,kmax)

    return (t,ns,ni,nr)


N = int(1e3)
c = 4 # nº medio de arestas em cada vertice
listav,nv,S,comp=rede_aleatoria(N,c)

e=np.zeros(N) # estado do sistema
# colocar um infecioso num sitio de componente gigante ao acaso

nc=int(np.max(comp)) # numero de componentes
sz=np.zeros(nc)
# determinar componente gigante
for i in range(nc):
    sz[i]=(comp==i).sum()

S=np.max(sz) # tamanho da CG
cg=np.argmax(sz) # label da CG

verticesCG=np.nonzero(comp==cg)[0]

i=np.random.randint(S) # escolher um ao acasao

e[verticesCG[i]]=1  # coloca lo como infetado <<<<< esta algo mal

kk,kmax=np.shape(listav) # n colunas da listav

classes, n_classe = constroi_classe(N,e,listav,nv,kmax)

beta = 1/5
gama = 1/15
ntransicoes = int(1e4)
t,ns,ni,nr = MC_t_continuo(N, beta, gama, listav, nv, e, kmax, n_classe, classes, ntransicoes)

plt.figure(1)
plt.plot(t,ns,'rx')
plt.plot(t,ni,'bo')
plt.plot(t,nr,'g.')
plt.show()

