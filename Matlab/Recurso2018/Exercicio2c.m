clear all
close all
clc

L=1000;
E=200; 
N=400;
teq=1000;
tmax=10000;
[Edt,Ndt]=SimChemDemon(teq,tmax,L,N,E);

figure(1)
subplot(2,1,1)
tv=1:tmax;
plot(tv,Edt(:),'-')
xlabel('t'); ylabel('Ed')
subplot(2,1,2)
plot(tv,Ndt(:),'-')
xlabel('t'); ylabel('Nd')


hNE=zeros(N+1,E+1);
for t=1:tmax
    hNE(Ndt(t)+1,Edt(t)+1)=hNE(Ndt(t)+1,Edt(t)+1)+1;
end
Ndmedio=sum(sum(hNE').*[0:N])/sum(sum(hNE));
Nmedio=N-Ndmedio;
fprintf('<N>=%f, <Nd>=%f\n',Nmedio,Ndmedio)

Edmedio=sum(sum(hNE).*[0:E])/sum(sum(hNE));
Emedio=E-Edmedio;
fprintf('<E>=%f, <Ed>=%f\n',Emedio,Edmedio)

figure(2)
subplot(2,1,1)
Ev=0:E;
i=find(hNE(ceil(Ndmedio)+1,:)>0);  ifit=i(1:max([3,floor(length(i)/5)]));aT=polyfit(Ev(ifit),log(hNE(ceil(Ndmedio)+1,ifit)),1);


T=-1/aT(1);
Tteor=2*Emedio/Nmedio; % ou Tteor=2E/N admitindo <Ed> <<E e <Nd><<N
fprintf('T=%f, Tteor=%f\n',T,Tteor)

semilogy(Ev,hNE(ceil(Ndmedio)+1,:),'.', Ev(i),exp(aT(1)*Ev(i)+aT(2)),'k-')
xlabel('Ed'); ylabel('P(Ndmedio,Ed)')

clear i
Nv=0:N;

i=find(hNE(:,ceil(Edmedio)+1)>0 ); ifit=i(1:max([3,floor(length(i)/5)]));amu=polyfit(Nv(ifit)',log(hNE(ifit,ceil(Edmedio)+1)),1);

mu=amu(1)*T;
muTeor=-Tteor*log((L/Nmedio)*sqrt(pi*Tteor)); % muTeor=-Tteor*log((L/N)*sqrt(pi*Tteor));
%admitindo <Nd><<N
fprintf('mu=%f, muTeor=%f\n',mu,muTeor)

subplot(2,1,2)
semilogy(Nv,hNE(:,ceil(Edmedio)+1),'.',Nv(i),exp(amu(1)*Nv(i)+amu(2)),'k-')
xlabel('Nd'); ylabel('P(Nd,Edmedio)')
