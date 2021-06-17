close all; clear all;
% Exercicio 2

N = 10^4;
cv=0.5:0.1:2;

ic=0;
for c=cv
    ic=ic+1;
    fprintf(1,'Simulação %f \n',ic)
    [listv,nv, lista_sitios]=rg(N,c);
    ncomp=numel(unique(lista_sitios));
    %fprintf(1,'numero de componentes=%d\n',ncomp)
    
    for i=transpose(unique(lista_sitios))
        tamanho_comp(i)=sum(lista_sitios==i);
    end

    % maior componente
    [S(ic),lmax]=max(tamanho_comp);
    
    % alinea b)
    s_pequenos=[tamanho_comp(1:lmax-1),tamanho_comp(lmax+1:end)];
    comp_pequena(ic)=sum(s_pequenos.^2)./sum(s_pequenos);
    %fprintf(1,'Tamanho da maior componente=%d \n Label da maior componente=%d\n',S,lmax)
    
    % valor teórico
    St(ic)=pfixo(c);

end

% Normalização do valor obtido para a maior componente
S=S./N;

figure(1)
plot(cv,S,'r-',cv,St,'b-');
xlabel('c')
ylabel('S')
legend('Solução','Valor Teorico')
title('Valor da maior componente em função de c')

% alinea b)
figure(2)
plot(cv,comp_pequena,'b-')
xlabel('c')
ylabel('S')
title('alinea b) - <S> em função de c')


