%% Exercício 2 --> feito na aula
%% a)
clear all; close all;

% neste problema mudamos a lei de transformação
% estamos a fazer para o caso de k=1 (é nos dada a desidade de prob)
N = 10 ^5;          % nº de pontos
nbins = 50;
lambda = 1;
u = rand(N,1);      % coluna de numeros aleatórios
y = -(1/lambda)*log(1-u);
[h,x] = hist(y,nbins);

%normalizar
xmax = max(x);
xmin = min(x);
dx =(xmax-xmin)/nbins;
hn = h/(N*dx);
px = lambda*exp(-lambda*x);

%plots
figure(1)
plot(x,hn,'x',x,px,'r-');
xlabel('x');
ylabel('p(x)');

u1 = rand(N,1);
y1 = -(1/lambda)*log(1-u1);
u2 = rand(N,1);
y2 = -(1/lambda)*log(1-u2);
y = y1+y2;
[hy,xx] = hist(y,nbins);

%normalizar
xmax = max(xx);
xmin = min(xx);
dx =(xmax-xmin)/nbins;
hyn = hy/(N*dx);
py = lambda^2*xx.*exp(-lambda*xx);  %na expressão dos apontamentos o xx é y

%plots
figure(2)
subplot(2,1,1)
plot(x,hyn,'x',x,px,'r-');
xlabel('x');
ylabel('p(x)');
subplot(2,1,2)
plot(x,hn,'x',x,px,'r-',xx,hyn,'kx',xx,py,'r-')

%% b)

close all; clear all;

xmax = 20;
xmin = 0;
nr = 10;                % numero de retangulos
lr = (xmax-xmin)/nr;    % largura dos retangulos
xr = xmin:lr:xmax;      % vetor com as "pontas" dos retangulos

p = inline('l^k*x.*exp(-l*x)/gamma(k-1)','k','l','x'); %atenção à ordem
l = 1; k = 2;           % dados do problema
dx = 0.1;
x = xmin:dx:xmax;

% determinar a altura dos retangulos
% altura do retangulo -> valor máximo da função dentro do retangulo (x)

for i=1:nr
    ir=find(x>=xr(i) & x<=xr(i+1));     % indices do vetor x com x dentro do retangulo
    hr(i)=max(p(k,l,x(ir)));            % altura do retangulo
end

plot(x,p(k,l,x),'k-')   % faz o plot da exponencial 
hold on

% plot dos retangulos
for i=1:nr
    plot([xr(i),xr(i),xr(i+1),xr(i+1)],[p(k,l,xr(i)),hr(i),hr(i),p(k,l,xr(i+1))],'m-')
end



