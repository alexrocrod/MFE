%% Exercício 3
% Método de transformação das variáveis
% 1) Calcular F(y)
% 2) Inverter para obter y = F^(-1)(u)
% 3)Gerar u uniforme e calcular y = F^(-1)(u)

close all; clear all

N = 10^5;
nbins = 30; 
u = rand(N,1);
r = (4*(1-u)).^(-1/9);

[h,x] = hist(r,nbins);     % gerar o histograma

% normalizar 
nx = length(x);
xmax = max(x);
xmin = min(x);
dx =(xmax-xmin)/nbins;
hn = h/(N*dx);

for i=1:nx
    if x(i)>=0 && x(i)<=1
        px(i)=(9/4)*(x(i)).^2;
    else
        px(i)=(9/4)*(x(i)).^(-10);
    end
end

%plots
plot(x,hn,'x')
hold on
plot(x,px,'r-')
title('densidade de probabilidade')
xlabel('r');
ylabel('p(r)')