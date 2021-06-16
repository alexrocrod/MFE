clear all
close all
namostras=1000;
pc=0.592746;pv=pc; nps=length(pv);
for L=[64,128];
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
    
end
ns_med=ns_med/namostras;
 eval(['save dadosL' num2str(L) 'pc'])
end
 