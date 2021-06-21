close all; clear all;
% Exercicio 1

% demora estupidamente mais do q o do sor

% npassos=10^4;
% nequi=10^2;
npassos=10^6;
nequi=10^4;

Tv=[0.01:0.05:2];
ic=0;
xh=-2:0.05:2;

for T=Tv
    ic=ic+1;
    fprintf(1,'Simulação %d \n',ic)
    
    [x,hn,Emedio(ic)]=metropolis(T,nequi,npassos);
    
end

figure(1) %histograma
plot(x,hn,'x')
xlabel('x'); ylabel('hn');
title('Histograma')

figure(2)
plot(Tv,Emedio,'r.')
xlabel('T'); ylabel('<E>')
title('Energia potencial em função da temperatura')




