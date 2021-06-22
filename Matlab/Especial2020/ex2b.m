
clear all
close all
clc

nequi=1000; nmedidas=10000;
nmax=50;
N=100;
Tv=linspace(0.1,2,20);
ic=0;
for T=Tv
    ic=ic+1;
   
    [Emedio(ic),E2medio(ic)] = ex2a(T ,nequi, nmedidas,N);
    
    fprintf(1,'Simulacao %d, T=%f, <E>=%f \n', ic, T, Emedio(ic)/N);
  
    
end
% comparacao com expressoes teoricas

Tt=transpose(linspace(0.1,2,200));

Et = N*(0.5+1./(exp(1./Tt)-1));

figure(1)
plot(Tv,Emedio/N,'kx',Tt,Et/N,'r-')
xlabel('T'); ylabel('<E>')
