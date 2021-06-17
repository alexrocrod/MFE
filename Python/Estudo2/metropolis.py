import numpy as np
from vizinhos import *

# Bosoes 3D
def metropolis_Bosoes_3D(T,nequi,nmedidas,N,nmax):

    #(1)
    nk = np.zeros(nmax**3, dtype=int)
    nk[0] = N     # todas no 1o estado
    E = 3*N
    estado_particula = np.zeros(N, dtype=int)

    #(2)
    Emedio = 0
    E2medio = 0
    nkmed = np.zeros(nmax**3, dtype=int)

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
            # ny= (ik % (nmax**2)) // (nx+1)
            ny= (ik % (nmax**2)) // nmax + 1 

            nzv= ikv // (nmax**2) + 1 
            nxv= (ikv % (nmax**2)) % nmax + 1
            # nyv= (ikv % (nmax**2))//(nxv+1)
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
    nk = np.zeros( nmax**2, dtype=int)
    nk[0] = N     # todas no 1o estado
    E = 2*N
    estado_particula = np.zeros(nmax**2, dtype=int)

    #(2)
    Emedio = 0
    E2medio = 0
    nkmed = np.zeros(nmax**2, dtype=int)

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
            # nx= ik % nmax
            nx = ik % nmax +1
            # ny= ik // nmax
            ny = ik // nmax +1
            # nxv= ikv % nmax
            nxv = ikv % nmax +1
            # nyv= ikv // nmax
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

    #(1)
    # nk = np.zeros( nmax**2, dtype=int)
    # nk[0] = N     # todas no 1o estado
    # E = 2*N
    # estado_particula = np.zeros(nmax**2, dtype=int)

    # #(2)
    # Emedio = 0
    # E2medio = 0
    # nkmed = np.zeros(nmax**2, dtype=int)

    # lista_viz,nvs = lista_vizinhos_2D(nmax)

    # npassos = nequi + nmedidas

    # for t in range(npassos):
    #     for act in range(N):
    #         # escolher uma particula
    #         ip = np.random.randint(N)
    #         ik = estado_particula[ip]
    #         # escolha do vizinho
    #         iv = np.random.randint(nvs[ik])
    #         ikv = lista_viz[ik,iv]
    #         #calculo da variacao da energia
    #         # nx= ik % nmax
    #         nx = ik % nmax +1
    #         # ny= ik // nmax
    #         ny = ik // nmax +1
    #         # nxv= ikv % nmax
    #         nxv = ikv % nmax +1
    #         # nyv= ikv // nmax
    #         nyv = ikv // nmax +1

    #         dE = (nxv**2+nyv**2) - (nx**2+ny**2)
    #         # prob de aceitacao
    #         pA=np.minimum( 1, nvs[ik] * (nk[ikv] + 1) / (nvs[ikv] * nk[ik]) * np.exp(-dE/T))
    #         if np.random.rand() <= pA:
    #             E += dE
    #             nk[ik] -= 1
    #             nk[ikv] += 1
    #             estado_particula[ip] = ikv
            

    #     if t > nequi:
    #         Emedio += E
    #         E2medio += E**2
    #         nkmed += nk

    # return (Emedio/nmedidas,E2medio/nmedidas,nkmed/nmedidas)
