clear all
close all
percolacao_pcL

load dadosL64pc.mat
i=find(s'>4 & s'<200 & ns_med>0);
a=polyfit(log10(s(i)'),log10(ns_med(i)),1);
x=log10([2,500]); y=a(1)*x+a(2);
    figure(8)
    loglog(s,ns_med(:,1),'r-',10.^x,10.^y,'k-')
    hold on
    xlabel('s'); ylabel('n_s')
tau=-a(1);
fprintf(1,'L=%d, tau=%f\n',L,tau)


load dadosL128pc.mat
i=find(s'>4 & s'<200 & ns_med>0);
a=polyfit(log10(s(i)'),log10(ns_med(i)),1);
x=log10([2,500]); y=a(1)*x+a(2);
    figure(8)
    loglog(s,ns_med(:,1),'m-',10.^x,10.^y,'k-')
  
    xlabel('s'); ylabel('n_s')
   

tau=-a(1);
fprintf(1,'L=%d, tau=%f\n',L,tau)
% load dadosL256pc.mat
% i=find(s'>4 & s'<200 & ns_med>0);
% a=polyfit(log10(s(i)'),log10(ns_med(i)),1);
% x=log10([2,500]); y=a(1)*x+a(2);
%     figure(8)
%     loglog(s,ns_med(:,1),'b-',10.^x,10.^y,'k-')
%   
%     xlabel('s'); ylabel('n_s')
%     hold off
%  
% tau=-a(1)

tau_esperado=187/91;
fprintf(1,'Sistema infinito, tau=%f\n',tau_esperado);