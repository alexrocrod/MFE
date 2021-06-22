clear all
close all
N=1e2; p=1;
npassos=1000;
gv=[0:0.05:1];
il=0;
for g=gv
    il=il+1;
[niv,t]=ex3a(N,p,g, npassos);

% figure(1)
% plot(t,niv,'.')
% xlabel('t'); ylabel('ni')
% axis([0 max(t), 0, N])
% drawnow
nis(il)=mean(niv(end-100:end));
fprintf (' gama=%f, Fraçao de infetados=%f\n', g, nis(il)/N)

end
figure(2)

plot(gv,nis/N,'x')
xlabel('t'); ylabel('ni/N')


