% Alexandre Rodrigues 92993
% MFE - Aula01 - Ex.1

clear all
close all
clc

%% consts:
n=1e3;

%% a)

% numeros
u=rand(n,1);
theta=acos(1-2*u);

% histograma u
figure(1)

nbins=20; 
max=1;
dx = (max-0)/nbins;
bins=dx/2:dx:max-dx/2;

[h]=hist(u,bins);
hn=(h/sum(h))/dx;
x=0:0.01:max;
%p(u)=1:
pu=ones(1,length(x));
plot(bins,hn,'x',x,pu,'r-');
xlabel('u');
ylabel('p(u)')

% histograma
figure(2)

nbins=20; 
max=pi;
dx = (max-0)/nbins;
bins=dx/2:dx:max-dx/2;

[h]=hist(theta,bins);
hn=(h/sum(h))/dx;
x=0:0.01:max;

axis([0,1,0,1.2])
plot(bins,hn,'x',x,sin(x)/2,'r-');
xlabel('theta');
ylabel('p(theta)')

%% b)

phi= 2*pi*rand(n,1);


figure(3)
x=sin(theta).*cos(phi);
y=sin(theta).*sin(phi);
z=cos(theta);
axis equal
plot3(x,y,z,'.')









