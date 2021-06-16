import matplotlib.pyplot as plt
import numpy as np
from numpy.core.numeric import full
from scipy.integrate import solve_ivp
from scipy.optimize import fmin


t= np.array(range(15))
ie= np.array([1, 3, 7, 25, 72, 222 , 282, 256, 233, 189, 123, 70, 25,11,4])

n=763
i0=1
s0=n-1
r0=0
y0=[s0,i0,r0]
tmin=0
tmax=20
ti=np.arange(tmin,tmax,0.05)
t_span=[tmin,tmax]
# integracao numercia da ODE
def FSIR(t,y):
    beta=0.004617187500000001
    gama=-0.14375000000000315
    F=np.zeros(3)
    F[0]=-beta*y[0]*y[1]
    F[1]=beta*y[0]*y[1]-gama*y[1]
    F[2]=gama*y[2]
    return F

sol = solve_ivp (FSIR, t_span, y0,t_eval=ti)

# ti = sol.t
yi = sol.y

plt.figure(1)
ii=yi[1,:]
plt.plot(t,ie,'rx',ti,ii,'b-')
plt.xlabel('t')
plt.ylabel('i')

plt.figure(2)
s=yi[0,:]
plt.plot(ti,s,'rx')
plt.xlabel('t')
plt.ylabel('s')

plt.figure(3)
r=yi[2,:]
plt.plot(ti,r,'rx')
plt.xlabel('t')
plt.ylabel('r')

plt.show()

# def FSIR2(t,y,beta,gama):
#     F=np.zeros(3)
#     F[0]=-beta*y[0]*y[1]
#     F[1]=beta*y[0]*y[1]-gama*y[1]
#     F[2]=gama*y[2]
#     return F

# def chi2(x):
#     te = np.array(range(15))
#     ie = np.array([1, 3, 7, 25, 72, 222 , 282, 256, 233, 189, 123, 70, 25,11,4])
#     n = 763
#     i0 = 1
#     s0 = n-1
#     r0 = 0
#     y0 = [s0,i0,r0]
#     beta = x[0]
#     gama = x[1]
#     ti = te
#     sol = solve_ivp (FSIR2, [np.min(te),np.max(te)] , y0,t_eval=ti,args=(beta,gama))
#     ti = sol.t
#     yi = sol.y
#     ii = yi[0,:]
#     res = 0
#     for i in te:
#         res+=(ii[i]-ie[i])**2
#     return res

# x0=[0,1]
# x,chi2final=fmin(chi2,x0,maxfun=15)
# print(x)
# print(chi2final)