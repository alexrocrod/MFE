%% Exercício 4 
close all; clear all;

Nt = 1000;     % número de tentativas

p=1;
y = zeros(Nt,1);
x = rand(Nt,1);
y(x<p) = 1;

w1=p;
w0=1-p;
w_sair=[w1 w0];
w=zeros(Nt,1);
w(1)=1;
D0=1;

for t=1:Nt
    if y(t)==1
        xr=1;
    else y(t)==0
        xr=2;
    end
    w(t+1)=w(t)*w_sair(xr);
end

w_med=sum(w)/Nt
w_analitico = 1+p*log2(p)+(1-p)*log2(1-p)




