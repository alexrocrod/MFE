clear all
close all
namostras=1000;
pv=0.4:0.01:0.8; nps=length(pv);
for L=[8,16,32,64];
    fprintf(1,'A calcular para L=%d\n',L);
    
     N=L*L;

ip=0; 

pinf_med=zeros(1,nps);


s=1:N;
for p=pv
    ip=ip+1;
    for amostra=1:namostras
          [Ninf]= percfunc(L,p);
          pinf_med(ip)=pinf_med(ip)+Ninf/N;
         
    end
    pinf_med(ip)=pinf_med(ip)/namostras;
    
%     figure(1)
%     hold on
%      plot(pv(1:ip),pinf_med(1:ip),'r+')
%       xlabel('p'); ylabel('P_inf')
end

 eval(['save dadosL' num2str(L)])
end

 load dadosL8.mat
 p=pv; Pinf8=pinf_med;
 load dadosL16.mat
 p=pv;Pinf16=pinf_med;
 load dadosL32.mat
  p=pv;Pinf32=pinf_med;
 load dadosL64.mat
  p=pv;Pinf64=pinf_med;
 
 figure(1)
 plot(p,Pinf8,'+',p,Pinf16,'x',p,Pinf32,'s',p,Pinf64,'d')
 ylabel('P_{inf}=N_{inf}/N'); xlabel('p')
 % grafico de escalonamento 
 figure(2)
 beta=5/36; nu=4/3; pc=0.5;
 F8=8^(beta/nu)* Pinf8; x8=8*abs(p-pc).^nu;
 F16=16^(beta/nu)* Pinf16; x16=16*abs(p-pc).^nu;
 F32=32^(beta/nu)* Pinf32; x32=32*abs(p-pc).^nu;
 F64=64^(beta/nu)* Pinf64; x64=64*abs(p-pc).^nu;
 loglog(x8,F8,'+',x16,F16,'x',x32,F32,'s',x64,F64,'d')
 xlabel('x=L(p-p_c)^{nu}'); ylabel('F(x)=L^{(beta/nu)} P_{inf}(p)')
 
 % alinea c
 
 % valores de Ninf para p=pc;
 i=find(p==pc);
 Ninf8=Pinf8(i)*8^2;Ninf16=Pinf16(i)*16^2; Ninf32=Pinf32(i)*32^2; Ninf64=Pinf64(i)*64^2;
 
 figure(3)
 L=[8,16,32,64]; Ninf=[Ninf8,Ninf16,Ninf32,Ninf64];
 pfit=polyfit(log(L),log(Ninf),1);
 df=pfit(1);
 % reta
 xr=log(L); yr=pfit(2)+ xr*df;
plot(log(L), log(Ninf),'k+',xr,yr,'r-')
xlabel('log L') ; ylabel ('log N_{inf}(p=p_c)')
df_esperado=91/48;
fprintf(1,'df=%f Valor esperado df=%f\n',df,df_esperado)