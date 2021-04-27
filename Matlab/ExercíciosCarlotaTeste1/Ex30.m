% Exercício 30 
% Algoritmo de Demon
close all; clear all;

npassos = 10000;
nequi = 1000;
N = 40;
i = 0;

% a) e c) --> sistema clássico
% for E0=1:4:2*N+1
%     i = i+1;
%     [Emed(i),EDmed]=Osciladores_classicos_2(E0,npassos,nequi);
%     %E_medio
%     T(i)=EDmed; % dito no enunciado 
%     
%     %fprintf(1,'E0=%f, T=%f, <E>=%f\n',E0,T(i),Emed)
% end
% 
% T_teorico=0:0.1:2;
% % kb = 1.38*10^(-23);
% % R = 8.31;
% E_teorico = N.*T_teorico;
% figure(2)
% plot(T,Emed,'r.',T_teorico,E_teorico,'k-')
% xlabel('T')
% ylabel('<E>')
% legend('Resultado numérico','Valor teórico')
% title('Energia média do sistema em função da temperatura')

% b) e c) --> sistema quantico



for E0=1:2*N+1
    i = i+1;
    [Emed(i),EDmed]=Osciladores_quanticos(E0,npassos,nequi);
    
    T(i)=(log(1+sqrt(EDmed))); % dito no enunciado 
    
    %fprintf(1,'E0=%f, T=%f, <E>=%f\n',E0,T(i),Emed)
end


T_teorico_SQ = 0:0.1:2;
E_teorico_SQ = N/2 + N./(exp(1./T_teorico_SQ)-1);

figure(4)
plot(T,Emed,'r.',T_teorico_SQ,E_teorico_SQ,'k-')
xlabel('T')
ylabel('<E>')
legend('Resultado numérico','Valor teórico')
title('Energia média do sistema em função da temperatura')

