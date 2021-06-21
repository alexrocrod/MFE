close all; clear all; 
% Exercício 31
% a)
N=1000;         % nº de particulas
Nestados=1e4;   % nº de estados

Tv=linspace(0.1,10,10);
i=0;
for T=Tv
    i=i+1;
    [Fluxo(i),erroF(i),pressao(i),erroP(i)]=fex31(N,T,Nestados);
end

figure(1)
errorbar(Tv,Fluxo,erroF,'x')
T=0:0.01:10;
Fluxo_teorico=N*sqrt(T/(2*pi));
hold on
plot(T,Fluxo_teorico,'r-')
xlabel('T')
ylabel('Fluxo')
title('Fluxo em função da temperatura')

figure(2)
errorbar(Tv,pressao,erroP,'x')
T=0:0.01:10;
pressao_teorico=N*T;    % P=(N/V)KbT
hold on
plot(T,pressao_teorico,'r-')
xlabel('T')
ylabel('Pressão')
title('Pressão em função da temperatura')

