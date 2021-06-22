clear all
close all
clc


E=200; 
N=400;
teq=1000;
tmax=10000;

rho=0.1:0.01:1;
L=round(N./rho);
rho=N./L;


Tteor(1:length(L))=2*E/N;
muTeor=-Tteor.*log((L/N).*sqrt(pi*Tteor));
muHC=-Tteor.*log(((L-N)/N).*sqrt(pi*Tteor));

il=0;
aux=0.1:0.1:0.9;
Lv=round(N./aux);

for L=Lv
    fprintf('L=%d, E=%f, N=%d\n',L,E,N)
    pause(2)
    il=il+1;
    [Edt,Ndt]=SimChemDemonHC(teq,tmax,L,N,E);

figure(1)
subplot(2,1,1)
tv=1:tmax;
plot(tv,Edt(:),'-')
xlabel('t'); ylabel('Ed')
subplot(2,1,2)
plot(tv,Ndt(:),'-')
xlabel('t'); ylabel('Nd')
set(gcf,'Position',[1,320, 300, 200]);

hNE=zeros(N+1,E+1);
for t=1:tmax
    hNE(Ndt(t)+1,Edt(t)+1)=hNE(Ndt(t)+1,Edt(t)+1)+1;
end
Ndmedio=sum(sum(hNE').*[0:N])/sum(sum(hNE));
Nmedio(il)=N-Ndmedio;

Edmedio=sum(sum(hNE).*[0:E])/sum(sum(hNE));
Emedio(il)=E-Edmedio;

figure(2)
subplot(2,1,1)
Ev=0:E;
i=find(hNE(ceil(Ndmedio)+1,:)>0);
 ifit=i(1:max([3,floor(length(i)/5)]));
aT=polyfit(Ev(ifit),log(hNE(ceil(Ndmedio)+1,ifit)),1);
%i=find(hNE(2,:)>0);
%aT=polyfit(Ev(i(1:2)),log(hNE(2,i(1:2))),1);

semilogy(Ev,hNE(ceil(Ndmedio)+1,:),'.', Ev(ifit),exp(aT(1)*Ev(ifit)+aT(2)),'k-')
%semilogy(Ev,hNE(2,:),'.', Ev(i),exp(aT(1)*Ev(i)+aT(2)),'k-')
xlabel('Ed'); ylabel('P(Nd=Ndmedio,Ed)')

clear i
Nv=0:N;
 i=find(hNE(:,ceil(Edmedio)+1)>0 );%& Nv'<Ndmedio);
 ifit=i(1:max([3,floor(length(i)/5)]));
 amu=polyfit(Nv(ifit)',log(hNE(ifit,ceil(Edmedio)+1)),1);
%i=find(hNE(:,2)>0 );%& Nv'<Ndmedio);
%amu=polyfit(Nv(i(1:2))',log(hNE(i(1:2),2)),1);

subplot(2,1,2)
semilogy(Nv,hNE(:,ceil(Edmedio)+1),'.',Nv(ifit),exp(amu(1)*Nv(ifit)+amu(2)),'k-')
%semilogy(Nv,hNE(:,2),'.',Nv(i(1:3)),exp(amu(1)*Nv(i(1:3))+amu(2)),'k-')
xlabel('Nd'); ylabel('P(Nd,Ed=Edmedio)')
set(gcf,'Position',[320,320, 300, 200]);

T(il)=-1/aT(1);

mu(il)=amu(1)*2*E/N;%T(il);



figure(4)
subplot(2,1,1)
rhov=N./Lv(1:il);

plot(rhov, T(1:il),'.',rho,Tteor,'r-')
xlabel('rho'); ylabel('T')
subplot(2,1,2)

plot(rhov, mu(1:il),'.',rho,muTeor,'r-',rho,muHC,'k-')
xlabel('rho'); ylabel('mu')
set(gcf,'Position',[640,320, 300, 200]);
end
