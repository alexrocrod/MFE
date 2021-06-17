import numpy as np

def lista_vizinhos_3D(nmax):
    listav = -np.ones((nmax**3, 6), dtype=int)    #indices dos vizinhos de cada estado 
    nv = np.zeros(nmax**3, dtype=int)             #numero de vizinhos de cada estado

    for i in range(nmax**3):
        nz = i // (nmax**2)
        nx = (i % (nmax**2)) % nmax
        # ny = (i % (nmax**2)) // (nx+1)
        ny = (i % (nmax**2)) // nmax

        # vizinho 1
        nx1 = nx + 1
        ny1 = ny 
        nz1 = nz
        if nx1 < nmax:
            iv = nx1 + nmax * ny1 + nz1 * nmax**2
            listav[i,nv[i]] = iv
            nv[i] += 1

        # vizinho 2
        nx1 = nx
        ny1 = ny + 1
        nz1 = nz
        if ny1 < nmax:
            iv = nx1 + nmax * ny1 + nz1 * nmax**2
            listav[i,nv[i]] = iv
            nv[i] += 1

        # vizinho 3
        nx1 = nx-1
        nz1 = nz
        ny1 = ny 
        if nx1 >= 0:
            iv = nx1 + nmax * ny1 + nz1 * nmax**2
            listav[i,nv[i]]= iv
            nv[i] += 1

        # vizinho 4
        nx1 = nx
        nz1 = nz
        ny1 = ny - 1
        if ny1 >= 0:
            iv = nx1 + nmax * ny1 + nz1 * nmax**2
            listav[i,nv[i]]= iv
            nv[i] += 1

        # vizinho 5
        nx1 = nx
        nz1 = nz + 1
        ny1 = ny 
        if nz1 < nmax:
            iv = nx1 + nmax * ny1 + nz1 * nmax**2
            listav[i,int(nv[i])]= iv
            nv[i] += 1

        # vizinho 6
        nx1 = nx
        ny1 = ny
        nz1 = nz - 1
        if nz1 >= 0:
            iv = nx1 + nmax * ny1 + nz1 * nmax**2
            listav[i,int(nv[i])]= iv
            nv[i] += 1

    return (listav,nv)


def lista_vizinhos_2D(nmax):
    listav=-np.ones((nmax**2,4), dtype=int) #indices dos vizinhos de cada estado 
    nv=np.zeros(nmax**2, dtype=int) #numero de vizinhos de cada estado

    for i in range(nmax**2):
        nx = i % nmax
        ny = i // nmax

        # vizinho 1
        nx1 = nx + 1
        ny1 = ny 
        if nx1 < nmax:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] = iv
            nv[i] += 1

        # vizinho 2
        nx1 = nx
        ny1 = ny + 1 
        if ny1 < nmax:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] =iv
            nv[i] += 1

        # vizinho 3
        nx1 = nx - 1
        ny1 = ny 
        if nx1 >= 0:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] = iv
            nv[i] += 1

        # vizinho 4
        nx1 = nx
        ny1 = ny - 1
        if ny1 >= 0:
            iv = nx1 + nmax * ny1
            listav[i,nv[i]] = iv
            nv[i] += 1

    return (listav,nv)
