import matplotlib.pyplot as plt
import numpy as np

from metropolis import metropolisGC

# 37 da carlota

N = 20 # 200
L = 5
V = L**3
bmu = 1
npassos = int(2e3)
nequi = int(1e3)
nmedidas = npassos - nequi

for bmu in [0.5, 1, 1.5, 2]:
# for bmu in [1]:
    Nt = metropolisGC(N,V,bmu,npassos,nequi)

    Nmed = np.sum(Nt) / nmedidas
    print("beta*mu:", bmu, ", <N>= ", Nmed)
    z1=bmu-3

    rhot = Nt / V
    nbins = 50
    rhomax = np.max(rhot)
    rhomin = np.min(rhot) + 1e-10
    # rhomin=0.45

    drho = (rhomax - rhomin) / nbins
    bins = np.arange(rhomin + drho/2, rhomax - drho/2, drho)
    h,bins = np.histogram(rhot, bins=bins)
    h= h / sum(h) / drho

    plt.figure(1)
    x = np.arange(rhomin, rhomax, 0.0001)
    xm = np.exp(bmu) / (np.exp(bmu) + 1)
    sigmaN = np.sqrt(V * x / (np.exp(bmu) + 1))
    proht = np.exp(-V**2 *(x - xm)**2 / (2 * sigmaN**2)) * (V / np.sqrt(2 * np.pi * sigmaN**2))
    plt.plot(bins[:-1], h, 'x', x, proht, '-')
    plt.show()


# plt.show()

