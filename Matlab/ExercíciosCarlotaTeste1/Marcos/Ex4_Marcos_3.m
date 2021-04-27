clear all;close all;clc;
%% Defenição de Constantes
p=0.5;
nRondas=100;
w=[p 1-p];

%% Começo do Jogo
Dinheiro=zeros(1,nRondas);
Dinheiro(1)=2;%Dinheiro inicial

y = zeros(nRondas,1);
x = rand(nRondas,1);
y(x<w(1)) = 1;

wtot(1)=1;

for t=1:nRondas
%     aposta(1)=rand()*Dinheiro(t);%dinheiro apostado em 0
%     aposta(2)=Dinheiro(t)-aposta(1);%dinheiro apostado em 1
    
    if y(t)==0
        xr=2;
    else
        xr=1;
    end
    wtot(t+1)=wtot(t)*w(xr);
end

%Teorico
t=1:nRondas;
w_analitico = 1+p*log2(p)+(1-p)*log2(1-p)
w_med = sum(wtot)/nRondas


wtot(end)/w_analitico
