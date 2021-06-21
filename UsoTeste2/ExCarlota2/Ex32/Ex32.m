close all; clear all; 
% Exercicio 32

nequi=500; 
nmedidas=2000;
nmax=50;
N=100;
Tv=linspace(3,300,30);
ic=0;
for T=Tv
    ic=ic+1;
    [Emedio(ic),E2medio(ic), nkmedio] = metropolis(T ,nequi, nmedidas,N, nmax);
    z(ic)=nkmedio(1)/(1+nkmedio(1));
    zt = 1-exp(-4*N./(pi*T) );
    Et = (pi/4)*T.^2 .*dilog(1 - zt );
    fprintf(1,'Simulacao %d, T=%f, <E>=%f, Et=%f, z=%f, zt=%f\n', ic, T, Emedio(ic)-2*N, Et, z(ic),zt);
    
%     mesh(reshape(nkmedio,nmax,nmax)); % plot do numero medio de particulas com um dado nx e ny
%     xlabel('nx'); ylabel('ny'); zlabel('<nk>')
%     drawnow
     
end

% comparacao com expressoes teoricas
Tt=transpose(linspace(3,300,300));
zt = 1-exp(-4*N./(pi*Tt) );
Et = (pi/4)*Tt.^2 .*dilog(1 - zt);
EGI=N*Tv; % gas ideal clássico
figure(1)
plot(Tv,Emedio-2*N,'kx',Tt,Et,'r-',Tv,EGI,'r--')
xlabel('T'); ylabel('<E>')

figure(2)
plot(Tv,z,'kx',Tt,zt,'r-')
xlabel('T'); ylabel('z')

figure(3)
Cv=(E2medio-Emedio.^2)./Tv.^2; % calculo da capacidade termica
CvGI=N*ones(length(Tv),1); % Cv do gas ideal classico
plot(Tv,Cv,'k.',Tv,CvGI,'r-')
xlabel('T'); ylabel('Cv')

