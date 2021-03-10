% Alexandre Rodrigues 92993
% MFE - Aula01 - Ex.??

close all
clear all
clc

%% a)

n=1e4;
lambda=2;

u=rand(n,1);
x=-1/lambda*log(1-u);

% histograma x
figure(1)

nbins=20; 
max=5/lambda;
dx = (max-0)/nbins;
bins=dx/2:dx:max-dx/2;

[h]=hist(x,bins);
hn=(h/sum(h))/dx;
x=0:0.01:max;
%p(x)=lambda*exp(-lambda*x):
px=lambda*exp(-lambda*x);
plot(bins,hn,'x',x,px,'r-');
xlabel('x');
ylabel('p(x)')

