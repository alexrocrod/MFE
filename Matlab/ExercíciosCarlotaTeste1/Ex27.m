% Exercicio 27 
% semelhante ao exercicio 28
close all; clear all;

close all; clear all;
N=40;   % número de particulas
nequi=500; 
nmedidas=1000;
ic=0;

for E0=linspace(10,200,5)
 fprintf(1,'Calculos para E0=%f\n',E0);
 ic=ic+1;
[Emedio,EDmedio,binsV,hv]=fex27(N,E0,nequi, nmedidas);
v=0:0.01:max(binsV);
T(ic)=EDmedio;
Em(ic)=Emedio;
pvteorico=((4*pi*v.^2)/ ( 2*pi*T(ic) )^(3/2) ).*exp(-v.^2/(2*T(ic)));

h2=figure(2);
set(h2, 'Units','normalized', 'Position',[1/3,1/3, 1/4,1/3])
plot(binsV,hv,'.', v,pvteorico,'k-')
xlabel('v'); ylabel('p(v)');
hold on
drawnow

end

h3=figure(3);
set(h3, 'Units','normalized', 'Position',[2/3,1/3, 1/4,1/3])
Tv=0: 0.1: max(T);
Emteorica=(3/2)*Tv; %alterado para Tv
plot(T,Em/N,'.', Tv, Emteorica,'k-') % Havia Erro Aqui plot(T,Emedio/N,'.', Tv, Emteorica,'k-')
xlabel('T'); ylabel('E media /N')


