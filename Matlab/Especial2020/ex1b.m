
clear all
close all
clc

n=10000; 
L=2;
nbins=100;

x=ex1a(L,n); %geração dos numeros aleatorios

%histograma
[h,z]=hist(x,nbins);
zmax=max(z); zmin=min(z);
dz=(zmax-zmin)/(nbins-1);
hn=h/(n*dz);

%funcao dendsidade de probabilidade para comparar
pz=(pi*sin((2*pi*z)/L))/L;

plot(z,hn,'x',z,pz,'r-')
xlabel('theta'); ylabel('p(theta)');