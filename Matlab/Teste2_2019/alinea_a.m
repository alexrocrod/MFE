clear all
close all
namostras=1000;
pv=0.4:0.01:0.8; nps=length(pv);
for L=[8,16,32,64];
    fprintf(1,'A calcular para L=%d\n',L);
    
     N=L*L;

ip=0; 

pinf_med=zeros(1,nps);
Smed=zeros(1,nps);
ns_med=zeros(N,nps);
s=1:N;
for p=pv
    ip=ip+1;
    for amostra=1:namostras
          [ns,S,Pinf,lab_percolativo]= percfunc(L,p);
          pinf_med(ip)=pinf_med(ip)+Pinf;
          ns_med(:,ip)=ns_med(:,ip)+ns;
          Smed(ip)=Smed(ip)+S;
    end
    pinf_med(ip)=pinf_med(ip)/namostras;
    Smed(ip)=Smed(ip)/namostras;
    
%     figure(1)
%     hold on
%     plot(pv(1:ip),pinf_med(1:ip),'r+')
%      xlabel('p'); ylabel('P_inf')
%     figure(2)
%     hold on
%     loglog(pv(1:ip),Smed(1:ip),'r+')
%     xlabel('p'); ylabel('S')
%     figure(3)
%     loglog(s,ns_med(:,ip),'r-')
%     hold on
%     xlabel('s'); ylabel(' n_s')
  
end
 ns_med=ns_med/namostras;
 %eval(['save dadosL' num2str(L)])
end

load dadosL8.mat
S8=Smed; p=pv; Pinf8=pinf_med;
load dadosL16.mat
S16=Smed; p=pv;Pinf16=pinf_med;
load dadosL32.mat
S32=Smed; p=pv;Pinf32=pinf_med;
load dadosL64.mat
S64=Smed; p=pv;Pinf64=pinf_med;

figure(1)
plot(p,Pinf8,'+',p,Pinf16,'x',p,Pinf32,'s',p,Pinf64,'d')
ylabel('S'); xlabel('p')

figure(2)
plot(p,S8,'+',p,S16,'x',p,S32,'s',p,S64,'d')
ylabel('S'); xlabel('p')
 