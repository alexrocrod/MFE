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
    p=c/(n-1) # probabilide de uma aresta existir
    kmax=int(np.floor(10*c)) # numero maximo de vizinhos admitido

    listav=-np.ones((n,kmax))
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
    
def roleta(nr,pr):
    u = np.random.rand()
    pacum = 0
    for i in range(nr):
        pacum = pacum+pr[i]
        if u <= pacum:
            return i
    return 0 # pq precisa disto??

def constroi_classe(N,e,listav,nv,kmax):
    classes= np.zeros((N,kmax+1))
    n_classe= np.zeros(kmax+1)
    for i in range(N):
        if e[i]==0: # suscetivel
            # calcular nº de vizinhos infetados
            ni=0
            for j in range(int(nv[i])):
                if e[int(listav[i,j])]==1:
                    ni+=1
            if ni>0:
                classes[int(n_classe[ni]),ni]=i
                n_classe[ni]+=1
        elif e[i]==1:
            classes[int(n_classe[kmax]),kmax]=i
            n_classe[kmax]+=1
    return(classes,n_classe)

def MC_t_continuo(N, beta, gama, e, kmax, n_classe, classe, ntransicoes):
    ns=np.zeros(ntransicoes)
    ni=ns
    nr=ns
    t=ns
    pr=np.zeros(kmax+1)
    ns[0]=np.sum(e[e==0])
    ni[0]=np.sum(e[e==1])
    nr[0]=N-ns[0]-ni[0]

    for tr in range(ntransicoes-1):
        print("transicao ",tr+1)
        # taxa total de transicao:
        vec=np.array(range(kmax))
        lamb = np.sum(vec*beta*n_classe[:kmax])
        lamb+=gama*n_classe[kmax]
        
        tau=-np.log(1-np.random.rand())/lamb # tempo espera ate transicao
        t[tr+1]=t[tr]+tau # instante em q se da a transicao
        # fazer a transiacao:
        pr=np.zeros(kmax+1)
        pr[:kmax]=vec*n_classe[:kmax]*beta/lamb
        pr[kmax]=gama*n_classe[kmax]/lamb
        if np.sum(pr)==0:
            break

        caso=int(roleta(kmax+1,pr))
        # i = np.random.randint(n_classe[caso])
        i = np.random.randint(n_classe[caso]+1) # pq??

        if caso != kmax:
            # um suscetivel infetou-se
            # escolher um dos suscetiveis:
            e[int(classe[i,caso])]=1
            ns[tr+1]=ns[tr]-1
            ni[tr+1]=ns[tr]+1
        else:
            e[int(classe[i,caso])]=2 # recuperou
            ni[tr+1]=ns[tr]-1
            nr[tr+1]=ns[tr]+1


        classe,n_classe=constroi_classe(N,e,listav,nv,kmax)


    return (t,ns,ni,nr)


# ex39 da v3
N = int(1e2)
c = 1 # nº medio de arestas em cada vertice
listav,nv,S,comp=rede_aleatoria(N,c)

e=np.zeros(N) # estado do sistema
# colocar um infecioso num sitio de componente gigante ao acaso

nc=int(np.max(comp)) # numero de componentes
sz=np.zeros(nc)
# determinar componente gigante
for i in range(nc):
    sz[i]=np.sum(comp[comp==i])

S=np.max(sz) # tamanho da CG
cg=np.argmax(sz) # label da CG

verticesCG=np.where(comp==cg)
print(S)
print(verticesCG)

i=np.random.randint(S) # escolher um ao acasao
e[verticesCG[verticesCG==i]]==1  # coloca lo como infetado <<<<< esta algo mal
# print(e)
print(listav)

kk,kmax=np.shape(listav) # n colunas da listav

classes,n_classe=constroi_classe(N,e,listav,nv,kmax)

beta=1
gama=1
ntransicoes=100
t,ns,ni,nr= MC_t_continuo(N, beta, gama, e, kmax, n_classe, classes, ntransicoes)

plt.figure(1)
plt.plot(t,ns,'rx')
plt.plot(t,ni,'bo')
plt.plot(t,nr,'g.')
plt.show()



# print(e)
# print(kmax)
# print(n_classe)

#  esta a dar so 0s nas classes pq???

