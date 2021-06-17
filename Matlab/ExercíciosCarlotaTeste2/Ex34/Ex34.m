close all; clear all; 
% Exercício 34

nequi=5000;
nmedidas=20000;
nmax=60;
N=100;

Tv=linspace(3,300,30);
ic=0;

for T=Tv
    ic=ic+1;
    fprintf("Simulacao %d/%d\n", ic, length(Tv))
    [Emedio(ic),E2medio(ic), nkmedio]=metropolisFermioes(T,nequi,nmedidas,N,nmax);
    z(ic)=nkmedio(1)/(1-nkmedio(1));
%     zt=-1+exp(4*N/(pi*T));
%     Et=(-pi/4)*T^2*dilog(1+zt);
%     fprintf(1,'Simulacao %d, T=%f, <E>=%f, Et=%f, z=%f, zt=%f\n', ic, T, Emedio(ic)-2*N, Et, z(ic),zt);
end

Tt=transpose(linspace(3,300,300));
zt = exp(4*N./(pi*Tt)) - 1;
Et = -(pi/4).*Tt.^2.*dilog(1 + zt);
% Gas ideal clássico
EGi = N*Tv;

figure(1)
plot(Tv,Emedio-2*N,'kx',Tt,Et,'r-',Tv,EGi,'r--')
xlabel('T'); 
ylabel('<E>')
title('<E>(T)')
legend('Teórico','Valor obtido','gás ideal clássico')

figure(2)
semilogy(Tv,z,'kx',Tt,zt,'r-')
xlabel('T'); 
ylabel('z')
title('z(T)')
legend('Teórico','Valor obtido')

% Capacidade térmica
figure(3)
Cv = (E2medio - Emedio.^2) ./ Tv.^2;
CvGi = N*ones(length(Tv),1);  % gas ideal classico
plot(Tv,Cv,'k.',Tv,CvGi,'r--')
xlabel('T');
ylabel('Cv');
legend('Cv(T)')

