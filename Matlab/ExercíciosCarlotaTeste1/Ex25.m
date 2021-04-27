% Exerc�cio 25 
% --> din�mica molecular e algoritmo de leapfrog
close all; clear all;

L = 12;  % largura da caixa
N = 12;  % n� de particulas
x = L/2*ones(N,1); % posi��o inicial das particulas (meio da caixa)
a = L/N;            % vamos dividir o y(L) em 12 partes 
y = linspace(a/2,L-a/2,N);  % a � a distancia entre os centros das particulas
y = transpose(y);   % porque o linspace cria um vetor coluna

px = ones(N,1);
py = zeros(N,1);
[Fx,Fy]=fForcas(L,N,x,y);

% fgraf(x,y,L,px,py) %fun��o para fazer o gr�fico
% para o algortimo de leapfrog precisamos das for�as entre particulas, por
% isso vamos fazer uma fun��o para calcular as for�as
npassos=500;
dt=0.01;    % dt tem que ser pequeno para n�o se tornar inst�vel
fprintf(1,'500 passos \n')
[x,y,px,py,Ec,Ep]=leapfrog(L,N,npassos, dt, x, y, px, py);

px=-px;
py=-py;
fprintf(1,'Invers�o das velocidades --> +500 passos \n')
[x,y,px,py,Ec,Ep]=leapfrog(L,N,npassos, dt, x, y, px, py);

% perturba��o ligeira da particula 1
px(1)=px(1)+1e-6*(2*rand(1)-1);
py(1)=py(1)+1e-6*(2*rand(1)-1);
npassos=500;
fprintf(1,'Adicionamos perturba��o � velocidade da particula 1 - + 500 passos \n')
[x,y,px,py,Ec,Ep]=leapfrog(L,N,npassos, dt, x, y, px, py);

px=-px;
py=-py;
fprintf(1,'Invers�o das velocidades --> + 1000 passos \n')
npassos=1000;
[x,y,px,py,Ec,Ep]=leapfrog(L,N,npassos, dt, x, y, px, py);

figure(2)
% plot das energias --> cin�tica, potencial e total
t=(1:npassos)*dt;
plot(t,Ec,'bo',t,Ep,'gx', t,Ec+Ep,'r+')
legend('Ec','Ep','E_total')
xlabel('t'); ylabel('Energia')