close all; clear all;
% Exercicio 35

N = 200;
npassos=20000;
nequi=2000;
nmedidas=npassos-nequi;
nmax=60;
TF=(3*N/(4*pi))^(2/3); % temperatura de fermi
% Energia de Fermi - exp teorica
EF=(3*N/(4*pi))^(2/3);
Tmax=2*TF;
Tv=[TF/20:TF/20:Tmax];
ic=0;

for T=Tv
    ic=ic+1;
    fprintf(1, 'Simulacao %d\n',ic)
    [Emedio(ic),E2medio(ic),nkmedio,EF2]=metropolis_ex35(T,nequi,nmedidas,N,nmax);
    mu(ic)=3/4+T*log(nkmedio(1)/(1-nkmedio(1))); 
    fprintf(1,'T=%f, <E>=%f,  mu=%f\n', T, Emedio(ic)-3/4,  mu(ic));
end

% Capacidade térmica
Cv=(E2medio-Emedio.^2)./Tv.^2;

% Temperaturas
Tt=transpose(linspace(TF/100,Tmax,100));
Tt1=Tt(Tt<=0.5*TF);
Tt2=Tt(Tt>1.5*TF & Tt<=Tmax);
TF2=EF2;

% Valores teoricos (T<TF)
Et=N*3*EF/5*(1+5*pi^2/12*(Tt1/TF).^(5/2));
mut=EF*(1-pi^2/12*(Tt1/TF).^2);
Cvt=N*(pi^2/2)*(Tt1/TF);

% Gás ideal clássico
EGI=3*N*Tt2/2;
muGI=Tt2.*log(4/(sqrt(pi)*3)*(TF./Tt2).^(3/2));
CvGI=3*N*ones(length(Tt2),1)/2;

% Plots
figure(1)
plot(Tv/(TF2-3/4),(Emedio-3*N/4)/(N*EF2),'kx',Tt1/TF,Et/(N*EF),'r-',Tt2/TF,EGI/(N*TF),'g-')
% subtrai-se 3N/4 porque tdos os estados de energia num sistema sem
% condicoes fronteira periodicas estao deslocados 3/4 de energia
% relativamente a um sistema com condicoes fronteira periodicas e as
% formulas teoricas assumem condicoes fronteira periodicas.
title('Energia')
xlabel('T/TF'); ylabel('<E>/N')
legend('Solução','T<Tc','Gás ideal clássico')

figure(2)
plot(Tv/(TF2-3/4),mu/(EF2-3/4),'kx',Tt1/TF,mut/EF,'r-', Tt2/TF,muGI/EF,'g-')
title('potencial químico')
xlabel('T/TF'); ylabel('mu/EF')
legend('Solução','T<Tc','Gás ideal clássico')

figure(3)
plot(Tv/(TF2-3/4),Cv/N,'k.',Tt1/TF,Cvt/N, 'r-',Tt2/TF,CvGI/N,'g-')
title('Capacidade térmica')
xlabel('T/TF'); ylabel('Cv/N')
legend('Solução','T<Tc','Gás ideal clássico')







