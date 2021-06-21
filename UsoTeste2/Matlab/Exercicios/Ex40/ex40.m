clear all; close all
% Exercício 37

N=20;   % nº de spins
fprintf(1,'N = %f \n',N)
npassos=10000; 
nequi=1000;

Tv=[0.1:0.1:1 , 1.5:0.5: 15];
H=0; % campo magnético (o campo magnético externo é nulo)

T=[0.1:0.01:15];
% Calculo e plot das expressões teóricas 
[m,mi, s,si,e,ei,cv,cvi]=expTeoricasIsing1d(T,H,N);
figure('units','normalized','outerposition',[0 0 1 1])
% Energia
% figure(1) 
subplot(2,5,1);
plot(T,e,'k-',T,ei,'b-'); 
xlabel('T'); 
ylabel('E/N'); 
title('Energia')
hold on
% capacidade termica
% figure(2)  
subplot(2,5,2);
plot(T,cv,'k-',T,cvi,'b-'); 
xlabel('T'); 
ylabel('Cv/N'); 
title('Cv')
axis([0, T(end), 0, 0.6]);
hold on
% magnetização
% figure(3) 
subplot(2,5,3);
plot(T,m,'k-',T,mi,'b-'); 
xlabel('T'); 
ylabel('M/N'); 
title('Magnetização')
hold on
%suscetibilidade
% figure(4)
subplot(2,5,4);
semilogy(T,s,'k-',T,si,'b-'); 
xlabel('T'); 
ylabel('S/N'); 
title('Suscetibilidade magnética')
axis([0, T(end), 0, 50]);
hold on

it=0;

for T=Tv
    it=it+1;
    [emedS(it), cvS(it), magS(it), suscS(it),dmed(it)]=SMC_Ising1d(T,H,N,npassos, nequi);
    fprintf(1,'Simulacao T=%f \n',T)
end

% Energia
subplot(2,5,1);
plot(Tv,emedS/N,'r.')
% Capacidade térmica
subplot(2,5,2);
plot(Tv,cvS/N,'r.')
% Magnetização
subplot(2,5,3);
plot(Tv,magS/N,'r.')
% Suscetibilidade magnética
subplot(2,5,4);
semilogy(Tv,suscS/N,'r.')

pause
N=200;
fprintf(1,'N = %f \n',N)
npassos=10000; 
nequi=1000;

Tv=[0.1:0.1:1 , 1.5:0.5: 15];
H=0;

T=[0.1:0.01:15]; 
[m,mi,  s,si,e,ei,cv,cvi]=expTeoricasIsing1d(T,H,N);
% Energia
subplot(2,5,6);
plot(T,e,'k-',T,ei,'b-'); 
xlabel('T'); 
ylabel('E/N'); 
title('Energia')
hold on
% Cv
subplot(2,5,7);
plot(T,cv,'k-',T,cvi,'b-'); 
xlabel('T'); 
ylabel('Cv/N'); 
title('Cv')
axis([0, T(end), 0, 0.6]);
hold on
% Magnetização
subplot(2,5,8);
plot(T,m,'k-',T,mi,'b-'); 
xlabel('T'); 
ylabel('M/N'); 
title('Magnetização')
hold on
% suscetibilidade
subplot(2,5,9);
semilogy(T,s,'k-',T,si,'b-'); 
xlabel('T'); 
ylabel('S/N'); 
title('Suscetibilidade magnética')
axis([0, T(end), 0, 50]); 
hold on
% tamanho dos domínios
subplot(2,5,10);
csi=-1./log(tanh(1./T));
semilogy(T, csi,'b-'); 
axis([0, T(end) 0 N]); 
xlabel('T'); 
ylabel('csi'); 
title('Tamanho dos domínios')
hold on


it=0;
 for T=Tv
    it=it+1;

    [emedS(it), cvS(it), magS(it), suscS(it),dmed(it)]=SMC_Ising1d(T,H,N,npassos, nequi);
    fprintf(1,'Simulacao T=%f \n',T)
 end
subplot(2,5,6); 
plot(Tv,emedS/N,'r.');
subplot(2,5,7);
plot(Tv,cvS/N,'r.')
subplot(2,5,8);
plot(Tv,magS/N,'r.');
subplot(2,5,9);
semilogy(Tv,suscS/N,'r.')
subplot(2,5,10);
semilogy(Tv, dmed,'r.')

% pode demonstrar-se que num sistema em que um spin Ã© 1 com probabilidade
% 1/2 tem dmedio=2  ou seja dmedio = soma_k (k (1/2)^k 

        