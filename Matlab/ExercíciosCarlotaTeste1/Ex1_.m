%% Exercício 1 --> feito na aula
%% 1a)
% Método de transformação das variáveis
% 1) Calcular F(y)
% 2) Inverter para obter y = F^(-1)(u)
% 3)Gerar u uniforme e calcular y = F^(-1)(u)

close all; clear all;

%variaveis
N = 10^6;               % nº de pontos
nbins = 100;             % nº de "colunas" que vai ter o histograma
u = rand(N,1);          % coluna de N numeros aleatórios
th = acos(1-2*u);       % calculo tem a ver com a densidade de prob. dada
                        % ver apontamentos
[h,x] = hist(th,nbins);     % gerar o histograma

%plots
figure(1)
subplot(1,2,1)
plot(x,h,'X')
subplot(1,2,2)
histogram(th,nbins)

%normalizar
xmax = max(x);
xmin = min(x);
dx =(xmax-xmin)/nbins;
hn = h/(N*dx);
px = sin(x)/2;

%plots
figure(2)
plot(x,hn,'x',x,px,'r-');
title('densidade de probabilidade')
xlabel('theta');
ylabel('p(theta)')

%% b) 
clear all
% gerar pontos distribuidos uniformemente numa esfera de R = 1;
% já temos os valores de theta;  
% vamos gerar os valore de phi (esfera, 3 dimnesões - x,th,phi)
% --> distribuição uniforme entre 0 e 2*pi

%gerar os pontos
N = 10^5;   
u = rand(N,1);
th=acos(1-2*u);
phi = 2*pi*rand(N,1);
R = 1;                  %raio da esfera

% componentes do vetor v (coordenadas esféricas)
vx = R*sin(th).*cos(phi);
vy = R*sin(th).*sin(phi);
vz = R*cos(th);

%plots
figure(3)
subplot(2,1,1)
plot3(vx,vy,vz,'.')
subplot(2,1,2)
mzeros=zeros(N,3);
quiver3(mzeros(:,1),mzeros(:,2),mzeros(:,3),vx,vy,vz,0)



