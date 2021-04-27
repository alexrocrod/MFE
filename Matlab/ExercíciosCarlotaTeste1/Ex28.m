% Exercicio 28 
% --> algoritmo de Demon (IMPORTANTE, SAI NO TESTE)

close all; clear all;
% b)
np_equi = 2000;
n_medidas = 10000;
% E0 = 10;    % Energia tem que estar entre sqrt(2) e 80*sqrt(2)

count = 0; %contador de energias
for E0=linspace(sqrt(2),80*sqrt(2),10)
count = count +1;
[Emedio,EDmedio]=f_ex28_b(E0,np_equi,n_medidas)
fprintf(1,'E0 = %f, \nEmedio = %f ,\nEDmedio = %f \n', E0,Emedio,EDmedio)
Em(count)=Emedio; %guardar as energias
T(count)=EDmedio;
EmTeorico=1.20206*pi*T(count)^3;
end

Tv=[0:0.1:3.5];
EmTeorico=1.20206*pi*Tv.^3;
figure(2)
plot(T,Em,'.',Tv,EmTeorico,'k-')
xlabel('T'); 
ylabel('Emedio');

% c)
fprintf(1,' alinea c\n');

for E0=linspace(20*sqrt(2),80*sqrt(2),3);
 Ev=sqrt(2):0.1:E0;
 fprintf(1,'Calculos para E0=%f\n',E0);
 
[Emedio,EDmedio,Ebins,NmedioE]=f_ex28_c(E0,np_equi, n_medidas);
T=EDmedio-0.2;
NEteorico=(pi/2)*Ev./(exp(Ev/T)-1);
figure(3)
semilogy(Ebins,NmedioE,'.',Ev,NEteorico,'k-')
xlabel('E'); ylabel('Nfmedio(E)');
hold on
drawnow
end
