import matplotlib.pyplot as plt
import numpy as np
from numpy.core.shape_base import block

def pfixo(c):
    St=1
    dS=1
    lamb=0.1
    while dS>1e-7:
        Sto=St
        St=Sto-lamb*(Sto-1+np.exp(-c*Sto))
        dS=abs(St-Sto); 
    return St

def rg(N, c):
    # c=<k> numero medio de vizinhos de um vertice
    kmax=int(np.floor(c+10))
    p=c/(N-1)
    # percorrer todos os edges possiveis
    listv=np.zeros((N,kmax),dtype=int)
    nv=np.zeros(N,dtype=int)
    for i in range(N-1):
        for j in range(i,N):
            if np.random.rand()<=p:
                #edge existe
                listv[i,nv[i]]=j
                listv[j,nv[j]]=i
                nv[i]+=1
                nv[j]+=1

    #calculo <k>
    km=np.sum(nv)/N
    print(f'Valor desejado={c} Valor obtido <k>={km}')
    lista_sitios=componentes(N,listv, nv)

    return listv,nv,lista_sitios


# def componentes(N,listav, nv):
#     lista_sitios=np.zeros(N)
#     ip=0 # ultimo analisado
#     label=0 # label das componentes
#     while ip<N:
#         if lista_sitios[ip]==0: # ainda nao foi analisado
#             lista_sitios[ip]=label; #atribui label
#             # cria lista de vizinhos que necessariamente ainda nao tem label
#             la=list(listav[ip,:nv[ip]])
#             lista_sitios[la]=label  # da o mesmo label aos vizinhos
#             na=len(la)
#             ip+=1
#             label+=1; #aumenta label
#             #analisa a lista enquanto ela tiver sitios  
#             while na>0:
#                 i=la[0]  
#                 la=la[1:]  #comeca pelo primeiro e remove-o da lista
#                 la.append(listav[i,lista_sitios[listav[i,:nv[i]]==0]]) # adiciona a lista os vizinhos  
#                 #que ainda nao foram colocados na lista
                
#                 #atribui o mesmo label aos novos membros
#                 lista_sitios[listav[i,lista_sitios[listav[i,:nv[i]]==0]]]=label
                
#                 na=len(la) #determina o novo tamanho da lista
#     return lista_sitios

def componentes(n,listav,nv):
    comp = np.zeros(n)
    ver=np.zeros(n,dtype=np.int64)
    aver=np.zeros(n,dtype=np.int64)
    n_aver=0
    rot=0

    for i in range(n):
        if ver[i]==0:
            ver[i]=1
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

Nv=[1e3, 5e3, 1e4]
strplot=['k.','gx','b+']


for i in range(len(Nv)):
    N=int(Nv[i])
    ic=0
    cv=np.arange(0.5,2.1,0.1)

    S=np.zeros(len(cv))
    St=np.zeros(len(cv))
    susc=np.zeros(len(cv))

    for c in cv:
        listv,nv,lista_sitios=rg(N, c)
        lsitios_set=list(set(lista_sitios))
        ncomp=len(lsitios_set)
        print('numero de componentes=',ncomp)

        tamanho_comp=np.zeros(ncomp)
        for j in range(ncomp):
            tamanho_comp[j]=(lista_sitios==lsitios_set[j]).sum()
        
        S[ic]=np.max(tamanho_comp)/N
        tamanho_comp = -np.sort(-tamanho_comp) # reverse sort

        susc[ic]=np.sum(tamanho_comp[1:ncomp]**2)/np.sum(tamanho_comp[1:ncomp])

        St[ic]=pfixo(c)
        print(f'S={S[ic]} Valor teorico={St[ic]}')
        ic+=1


    plt.figure(1)
    plt.plot(cv,S,strplot[i],cv, St,'r-')
    plt.xlabel('c'); plt.ylabel('S')

    plt.figure(2)
    plt.plot(cv,susc,strplot[i])
    plt.xlabel('c'); plt.ylabel('Susc')

plt.show()
