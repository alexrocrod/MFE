import matplotlib.pyplot as plt
import numpy as np
from scipy.special import zeta

## a)

# E0=10
# nmax=int(np.ceil(np.sqrt(E0**2-1)))
# nk=np.zeros((nmax,nmax))

# tmax=12000
# tdes=2000
# ED=E0
# E=0
# Emed=0
# EDmed=0

# for t in range(1,tmax+1):
#     for act in range(nmax**2):

#         nx=np.random.randint(nmax-1)
#         ny=np.random.randint(nmax-1)

#         dE= np.sqrt((nx+1)**2 + (ny+1)**2) # +1 pq sao estados de 1 a nmax (index+1)

#         if np.random.rand()<=0.5 : # adicionar fotao
#             if dE <= ED: # demon tem energia para dar
#                 nk[nx,ny] += 1
#                 E += dE
#                 ED -= dE
#         elif nk[nx,ny]>=1 : # aniquilar
#             nk[nx,ny] -= 1
#             dE = -dE ## remocao da delta_E negativo
#             E += dE
#             ED -= dE
#     if t >= tdes:
#         Emed += E
#         EDmed += ED
    
# tmedidas = tmax - tdes

# Emed /= tmedidas
# EDmed /= tmedidas

# print("Energia media do sistema: ",Emed)
# print("Temperatura: ",EDmed)

####################################
def fex28b(E0):
    nmax=int(np.minimum((np.ceil(np.sqrt(E0**2-1))),20))
    nk=np.zeros((nmax,nmax))

    tmax=3000 #12e3
    tdes=2000 #2e3
    ED=E0
    E=0
    Emed=0
    EDmed=0

    for t in range(1,tmax+1):
        for act in range(nmax**2):

            nx=np.random.randint(nmax-1)
            ny=np.random.randint(nmax-1)

            dE= np.sqrt((nx+1)**2 + (ny+1)**2) # +1 pq sao estados de 1 a nmax (index+1)

            if np.random.rand()<=0.5 : # adicionar fotao
                if dE <= ED: # demon tem energia para dar
                    nk[nx,ny] += 1
                    E += dE
                    ED -= dE
            elif nk[nx,ny]>=1 : # aniquilar
                nk[nx,ny] -= 1
                dE = -dE ## remocao da delta_E negativo
                E += dE
                ED -= dE
        if t >= tdes:
            Emed += E
            EDmed += ED
        
    tmedidas = tmax - tdes

    Emed /= tmedidas
    EDmed /= tmedidas

    return (Emed,EDmed)

####################################
k=5
T=np.zeros(k)
Emed=np.zeros(k)
i=0
for E0 in np.linspace(np.sqrt(2),80*np.sqrt(2),k) :
    (Emed[i],T[i]) = fex28b(E0)
    print("Simulação a temperatura T= ",T[i])
    i+=1


Tt=np.linspace(T[0],T[-1],40)
EmedT=np.pi*Tt**3*zeta(3)
plt.plot(T,Emed,'x',Tt,EmedT,'r-')



####################################
## c)





####################################


plt.show()