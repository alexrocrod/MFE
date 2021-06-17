import matplotlib.pyplot as plt
import numpy as np

# igual ao 32 mas a 3D

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

if __name__ == '__main__':

    nmax = 60 #60
    N = 200 #200
    nmedidas = 2000 #20000
    nequi = 2000

    Tc= 0.671253 * N**(2/3)
    print("Tc:",Tc)

    # Ts = np.arange(Tc/10 , 2*Tc , Tc/20)
    Ts = np.arange(Tc/10 , 2*Tc , Tc/5)
    nTs = len(Ts)

    Emeds = np.zeros(nTs)
    E2meds = np.zeros(nTs)
    nkmed = np.zeros((nmax**3,nTs))

    for i,T in enumerate(Ts):
        print("Simulação",i+1,"T/Tc",T/Tc)
        Emeds[i], E2meds[i], nkmed[:,i] = metropolis_Bosoes_3D(T,nequi,nmedidas,N,nmax)


    Cv = (E2meds - Emeds**2) / (Ts**2)
    z = np.exp(0/Ts) * nkmed[0,:] / (nkmed[0,:] + 1)

    Tt = np.linspace(Tc/10, 2*Tc, 100)

    Emt = np.zeros(100)
    for i,x in enumerate(Tt):
            if x <= Tc:
                Emt[i] = Tc * 0.7701 * (x/Tc)**(5/2)
            else:
                Emt[i] = 3 * x / 2

    Cvt1 = 1.925 * (Tt / Tc) ** (3/2) ## a T baixas
    # Cvt2 = 3/2  * np.ones(100) ## a T altas

    Zt = np.ones(100) ## a T baixas
    for i,x in enumerate(Tt):
            if x <= Tc:
                Zt[i] = 1
            else:
                Zt[i] = 2.612 * (Tc/x)**(3/2)

    f0 = nkmed[0,:] / N
    f0t = 1 - (Tt/Tc)**(3/2)

    plt.figure(1)
    plt.plot(Ts/Tc, Emeds/N, 'kx')
    plt.plot(Tt/Tc, Emt, 'r-')
    plt.figure(2)
    # plt.plot(Ts/Tc, Cv/N, 'kx', Tt/Tc, Cvt1, 'r-', Tt/Tc, Cvt2, 'b-')
    plt.plot(Ts/Tc, Cv/N, 'kx', Tt/Tc, Cvt1, 'r-')
    plt.figure(3)
    plt.plot(Ts/Tc, z, 'kx', Tt/Tc, Zt, 'r-')
    plt.figure(4)
    plt.plot(Ts/Tc, f0, 'kx', Tt/Tc, f0t, 'b-')


    plt.show()

