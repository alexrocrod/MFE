clear all;close all;clc;
%% Defenição de Constantes
p=0.65;
nRondas=100;
w=[p 1-p];

%% Começo do Jogo
Dinheiro=zeros(1,nRondas);
Dinheiro(1)=10;%Dinheiro inicial

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
    wtot(t+1)=wtot(t)*2*w(xr);
    D(t)=Dinheiro(1)*wtot(t);
    Dinheiro(t+1)=D(t);
end

%Teorico
w_analitico = 1+p*log2(p)+(1-p)*log2(1-p);
D_analitico_por_ronda=Dinheiro(1)*2.^(w_analitico.*t);
w_med = sum(wtot)/nRondas;

t=1:nRondas;
plot(t,D,t,D_analitico_por_ronda,'r')