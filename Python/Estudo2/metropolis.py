import numpy as np
from vizinhos import *

# Bosoes 3D
def metropolis_Bosoes_3D(T,nequi,nmedidas,N,nmax):

    #(1)
    nk = np.zeros(nmax**3, dtype=np.int64)
    nk[0] = N     # todas no 1o estado
    E = 3*N
    estado_particula = np.zeros(N, dtype=np.int64)

    #(2)
    Emedio = 0
    E2medio = 0
    nkmed = np.zeros(nmax**3, dtype=np.int64)

    lista_viz,nvs = lista_vizinhos_3D(nmax)

    npassos=nequi+nmedidas
    for t in range(npassos):
        for act in range(N):
            # escolher uma particula
            ip = np.random.randint(N)
            ik = estado_particula[ip]
            # escolha do vizinho
            iv = np.random.randint(nvs[ik])
            ikv = lista_viz[ik,iv]
            #calculo da variacao da energia

            nz= ik // (nmax**2) + 1
            nx= (ik % (nmax**2)) % nmax + 1
            ny= (ik % (nmax**2)) // nmax + 1 

            nzv= ikv // (nmax**2) + 1 
            nxv= (ikv % (nmax**2)) % nmax + 1
            nyv= (ikv % (nmax**2))// nmax + 1

            dE = (nxv**2 + nyv**2 + nzv**2) - (nx**2 + ny**2 + nz**2)

            pA=np.minimum(1, nvs[ik] * (nk[ikv]+1) / (nvs[ikv] * nk[ik]) * np.exp(-dE/T))
            
            if np.random.rand() <= pA:
                E += dE
                nk[ik] -= 1
                nk[ikv] += 1
                estado_particula[ip] = ikv
            
        if t > nequi:
            Emedio += E
            E2medio += E**2
            nkmed += nk

    return (Emedio/nmedidas,E2medio/nmedidas,nkmed/nmedidas)

# Metropolis para bosoes 2D
def metropolis_Bosoes_2D(T,nequi,nmedidas,N,nmax):

    #(1)
    nk = np.zeros( nmax**2, dtype=np.int64)
    nk[0] = N     # todas no 1o estado
    E = 2*N
    estado_particula = np.zeros(nmax**2, dtype=np.int64)

    #(2)
    Emedio = 0
    E2medio = 0
    nkmed = np.zeros(nmax**2, dtype=np.int64)

    lista_viz,nvs = lista_vizinhos_2D(nmax)

    npassos = nequi + nmedidas

    for t in range(npassos):
        for act in range(N):
            # escolher uma particula
            ip = np.random.randint(N)
            ik = estado_particula[ip]
            # escolha do vizinho
            iv = np.random.randint(nvs[ik])
            ikv = lista_viz[ik,iv]
            #calculo da variacao da energia
            nx = ik % nmax +1
            ny = ik // nmax +1
            nxv = ikv % nmax +1
            nyv = ikv // nmax +1

            dE = (nxv**2+nyv**2) - (nx**2+ny**2)
            # prob de aceitacao
            pA=np.minimum( 1, nvs[ik] * (nk[ikv] + 1) / (nvs[ikv] * nk[ik]) * np.exp(-dE/T))
            if np.random.rand() <= pA:
                E += dE
                nk[ik] -= 1
                nk[ikv] += 1
                estado_particula[ip] = ikv
            

        if t > nequi:
            Emedio += E
            E2medio += E**2
            nkmed += nk

    return (Emedio/nmedidas,E2medio/nmedidas,nkmed/nmedidas)


# Metropolis para fermioes 2D
def metropolis_Fermioes_2D(T,nequi,nmedidas,N,nmax):

    # PASSO 1
    lv,nv=lista_vizinhos_2D(nmax)

    nk=np.zeros(nmax**2,dtype=np.int64)
    nkmedio=nk

    # calcular a energia de cada estado
    estado_particula = np.zeros(N,dtype=np.int64)
    Eestado = np.zeros(nmax**2,dtype=np.int64)

    for nx in range(nmax):
        for ny in range(nmax):
            ik = nx + nmax * ny
            Eestado[ik] = nx**2 + ny**2

    # Eestado_ordenado, ik_ordem = np.sort(Eestado, 'ascend') # ordem crescente
    Eestado_ordenado = np.sort(Eestado) # ordem crescente
    ik_ordem = np.argsort(Eestado) # ordem crescente

    # colocar N particulas nos respectivos estados de forma crescente em
    # energia
    E = 0
    for i in range(N):
        estado_particula[i] = ik_ordem[i]
        nk[ik_ordem[i]] = 1
        E += Eestado_ordenado[i]

    npassos = nequi + nmedidas
    Emedio = 0
    E2medio = 0

    # PASSOS 2
    for t in range(npassos):
        for act in range(N):
            # PASSO 2A
            ip=np.random.randint(N)
            ik=estado_particula[ip]
            # PASSO 2B
            # estado vizinho de ik escolhido ao acso de entre nv(ik)
            ikv=lv[ik,np.random.randint(nv[ik])]
            
            # so se fazem os calculos se o estado que se esta a considerar nao
            # tiver ja uma particula
            if nk[ikv] == 0:
                # as energias ja estao calculadas por isso basta seleccionar o
                # valor correspondente a particula escolhida aleatoriamente
                Epi = Eestado[ik]
                Epf = Eestado[ikv]
                # variacao de energia
                dE=Epf-Epi
                
                # PASSOS 2C
                # probabilidade de aceitacao
                pA=np.minimum(1, nv[ik] * (nk[ikv]+1) / (nv[ikv] * nk[ik]) * np.exp(-dE/T))
                
                if np.random.rand()<pA:
                    # PASSO 2D
                    estado_particula[ip] = ikv
                    nk[ik] -= 1
                    nk[ikv] += 1
                    E += dE
        # PASSO 2E
        if t > nequi:
            Emedio += E
            E2medio += E**2
            nkmedio += nk

    return Emedio/nmedidas,E2medio/nmedidas,nkmedio/nmedidas

# Metropolis para fermioes 3D (ex35)
def metropolis_Fermioes_3D(T,nequi,nmedidas,N,nmax):

    # PASSO 1
    lv,nv=lista_vizinhos_3D(nmax)

    nk=np.zeros(nmax**3,dtype=np.int64)
    nkmedio=nk

    # calcular a energia de cada estado
    estado_particula = np.zeros(N,dtype=np.int64)
    Eestado = np.zeros(nmax**3,dtype=np.int64)

    for nx in range(nmax):
        for ny in range(nmax):
            for nz in range(nmax):
                ik = nx + nmax * ny + nmax**2*nz
                Eestado[ik] = (nx**2 + ny**2 + nz**2)/4

    # Eestado_ordenado, ik_ordem = np.sort(Eestado, 'ascend') # ordem crescente
    Eestado_ordenado = np.sort(Eestado) # ordem crescente
    ik_ordem = np.argsort(Eestado) # ordem crescente

    # colocar N particulas nos respectivos estados de forma crescente em
    # energia
    E = 0
    for i in range(N):
        estado_particula[i] = ik_ordem[i]
        nk[ik_ordem[i]] = 1
        E += Eestado_ordenado[i]

    npassos = nequi + nmedidas
    Emedio = 0
    E2medio = 0

    # Energia Fermi

    Ef2 = Eestado_ordenado[-1]

    # PASSOS 2
    for t in range(npassos):
        for act in range(N):
            # PASSO 2A
            ip=np.random.randint(N)
            ik=estado_particula[ip]
            # PASSO 2B
            # estado vizinho de ik escolhido ao acso de entre nv(ik)
            ikv=lv[ik,np.random.randint(nv[ik])]
            
            # so se fazem os calculos se o estado que se esta a considerar nao
            # tiver ja uma particula
            if nk[ikv] == 0:
                nz= ik // (nmax**2) + 1
                nx= (ik % (nmax**2)) % nmax + 1
                ny= (ik % (nmax**2)) // nmax + 1 

                nzv= ikv // (nmax**2) + 1 
                nxv= (ikv % (nmax**2)) % nmax + 1
                nyv= (ikv % (nmax**2))// nmax + 1

                Epi=(nx**2+ny**2+nz**2)/4
                
                Epf=(nxv**2+nyv**2+nzv**2)/4

                dE=Epf-Epi
                
                # PASSOS 2C
                # probabilidade de aceitacao
                pA=np.minimum(1, nv[ik] * (nk[ikv]+1) / (nv[ikv] * nk[ik]) * np.exp(-dE/T))
                
                if np.random.rand()<pA:
                    # PASSO 2D
                    estado_particula[ip] = ikv
                    nk[ik] -= 1
                    nk[ikv] += 1
                    E += dE
        # PASSO 2E
        if t > nequi:
            Emedio += E
            E2medio += E**2
            nkmedio += nk

    return Emedio/nmedidas,E2medio/nmedidas,nkmedio/nmedidas,Ef2