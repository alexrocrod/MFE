clear all;close all;clc;
%% Defenição de Constantes
p=0.65;
nRondas=100;
w=[p 1-p];

%% Começo do Jogo
Dinheiro=zeros(1,nRondas);
Dinheiro(1)=10;%Dinheiro inicial

y = ones(nRondas,1);
x = rand(nRondas,1);
y(x<w(2)) = 0;

wtot(1)=0;

for t=1:nRondas
%     aposta(1)=rand()*Dinheiro(t);%dinheiro apostado em 0
%     aposta(2)=Dinheiro(t)-aposta(1);%dinheiro apostado em 1
    
    if y(t)==0
        xr=2;
    else
        xr=1;
    end
    wtot(t+1)=wtot(t)+w(xr);
    D(t)=Dinheiro(1)*2*wtot(t);
    Dinheiro(t+1)=D(t);
end


w_med = sum(w)/nRondas

w_analitico = 1+p*log2(p)+(1-p)*log2(1-p)
t=1:nRondas;
D_analitico_por_ronda=Dinheiro(1)*2.^(w_analitico.*t);

plot(t,D,t,D_analitico_por_ronda,'r')