close all;clear all;clc;
N=40;

E=N/2+sum(1:N);
E0=1:4:2*N+1;
npassos=10000;
nequi=1000;
for E0=E0
[Emed,EDmed]=Oscialadores_quanticos(E0,npassos,nequi)
end
figure(2)
Ed=0:100;
T=1./(log10(1+sqrt(Ed)));
plot(Ed,T)