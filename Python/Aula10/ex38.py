import matplotlib.pyplot as plt
import numpy as np
from scipy.integrate import solve_ivp
from scipy.optimize import fmin

def FSIR(t,y,beta,gama):
    F = np.zeros(3)
    F[0] = -beta * y[0] * y[1]
    F[1] = beta * y[0] * y[1] - gama * y[1]
    F[2] = gama * y[1]
    return F

def chi2(x):
    te = np.array(range(15))
    ie = np.array([1, 3, 7, 25, 72, 222 , 282, 256, 233, 189, 123, 70, 25,11,4])
    n = 763
    i0 = 1
    s0 = n - 1
    r0 = 0
    y0 = [s0, i0, r0]
    beta = x[0]
    gama = x[1]
    sol = solve_ivp (FSIR, [np.min(te),np.max(te)], y0, t_eval = te, args = (beta, gama))
    yi = sol.y
    ii = yi[1,:]
    res = 0
    for i in te:
        res += (ii[i] - ie[i])**2
    return res

x0 = [0, 1]
beta, gama = fmin(chi2, x0)
print("beta:",beta)
print("gama:",gama)

t = np.array(range(15))
ie= np.array([1, 3, 7, 25, 72, 222 , 282, 256, 233, 189, 123, 70, 25,11,4])

n = 763
i0 = 1
s0 = n - 1
r0 = 0
y0 = [s0, i0, r0]

tmin = 0
tmax = 20
ti = np.arange(tmin, tmax, 0.05)

sol = solve_ivp (FSIR, [tmin, tmax], y0, t_eval = ti, args = [beta, gama])

yi = sol.y

plt.figure(1)
ii = yi[1,:]
plt.plot(t, ie, 'rx', ti, ii, '-k')
plt.xlabel('t')
plt.ylabel('i')

plt.figure(2)
s = yi[0,:]
plt.plot(ti, s, '-k')
plt.xlabel('t')
plt.ylabel('s')

plt.figure(3)
r = yi[2,:]
plt.plot(ti, r, '-k')
plt.xlabel('t')
plt.ylabel('r')

plt.show()
