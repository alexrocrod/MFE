clear all
close all
tmax=10000; N=30;
tdesp=500; %numero de passos iniciais desprezados
N1(1)=N;

for t=1:tmax
 
        pd=N1(t)/N;%prob de diminuir e´zero
        pa=1-N1(t)/N;%prob de aumentar
         if rand() <=pd
             N1(t+1)=N1(t)-1;
         else
             N1(t+1)=N1(t)+1;
         end
end
t=0:tmax;
plot(t,N1,'k-')
xlabel('t'); ylabel('N1(t)')
n1=0:N;
[h]=hist(N1(tdesp:end),n1);
figure(2)
h=h/sum(h);
pst_t=factorial(N)./(factorial(n1).*factorial(N-n1)) * 2^(-N); % distribuição binomial teorica
plot(n1,h,'x', n1, pst_t,'r-')
xlabel('N1'); ylabel('h_n(N1)');


             
             