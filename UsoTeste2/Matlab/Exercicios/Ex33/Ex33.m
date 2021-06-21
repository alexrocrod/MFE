close all; clear all;

nequi=2000; 
npassos=20000; 
nmedidas=npassos-nequi;
nmax=60;
N=200;
Tc=N^(2/3)*3.31/(2*pi^2);
Tmax=3*Tc;
Tv=linspace(Tc/10,Tmax,30);
ic=0;
%Descomentar para fazer Simulações
for T=Tv
    ic=ic+1;
    fprintf(1, 'Simulacao %d\n',ic)
    
    [Emedio(ic),E2medio(ic), nkmedio] = metropolis_ex33(T ,nequi, nmedidas,N, nmax);
    z(ic)=nkmedio(1)/(1+nkmedio(1));
    f0(ic)=nkmedio(1)/N;
    fprintf(1,'T=%f, <E>=%f,  z=%f, f0=%f \n', T, Emedio(ic)-3*N/4,  z(ic),f0(ic));
end
% comparacao com expressoes teoricas
% para comparar com as expressoes teoricas a energia do estado fundamental
% e' subtraida de 3*N

% Descomentar para carregar dados
% load dados_ex33_N200

Tt=transpose(linspace(Tc/10,Tmax,100));
Tt1=Tt(Tt<=Tc);
Tt2=Tt(Tt>2*Tc & Tt<=Tmax);

Et = N*Tc*0.7701*(Tt1/Tc).^(5/2); % valido para T<Tc
EGI=3*N*Tt2/2; % gas ideal clássico
zt = ones(numel(Tt1),1);
zGI=2.612*(Tc./Tt2).^(3/2);

figure(1)
plot(Tv,Emedio-3*N/4,'kx',Tt1,Et,'r-',Tt2,EGI,'g-')
xlabel('T'); ylabel('<E>')

figure(2)
plot(Tv,z,'kx',Tt1,zt,'r-', Tt2,zGI,'g-')
xlabel('T'); ylabel('z')

figure(3)
f0t=1-(Tt1/Tc).^(3/2);
plot(Tv,f0,'kx',Tt1,f0t,'r-')
xlabel('T'); ylabel('f0')

figure(4)
Cv=(E2medio-Emedio.^2)./Tv.^2; % calculo da capacidade termica
Cvt=N*1.925*(Tt1/Tc).^(3/2);
CvGI=3*N*ones(length(Tt2),1)/2; % Cv do gas ideal classico ERRO
plot(Tv,Cv,'k.',Tt1,Cvt, 'r-',Tt2,CvGI,'g-')
xlabel('T'); ylabel('Cv')
%save dados_ex32_N800


