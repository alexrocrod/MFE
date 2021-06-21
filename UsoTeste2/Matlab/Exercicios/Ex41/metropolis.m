function [Emed, Mmed, Cv, Susc]=metropolis(npassos, nequi,T,L)
N=L^2;
% definir estado inicial +1  ou -1 com igual probabilidade
u=rand(1,N); % vetor linha de aleatorios uniformes em [0,1];
s=ones(1,N); s(u<=0.5)=-1;
% calculo da energia
[listav, nv]=lista_vizinhos(L);
E=0; M=0;
for i=1:N
    M=M+s(i);
    for j=1:nv(i)
        iv=listav(i,j);
        E=E-s(i)*s(iv);
    end
end
E=E*0.5; % porque contamoss duas vezes a mesma aresta anteriormente
Emed=0;Mmed=0; M2med=0; E2med=0;
for t=1:npassos
    for act=1:N
        i=randi(N,1); %escolher i ao acaso
        % soma dos spins vizinhos
        sv=0;
        for j=1:nv(i)
            iv=listav(i,j);
            sv=sv+s(iv);
        end
                
        sli=-s(i);
        % calcular a variação de energia
        dE=-sli*sv-(-s(i)*sv);
        % determinar se aceitamos a perturbação
        pA=min([1,exp(-dE/T)]);
        if rand(1) <=pA
            % aceitamos
            E=E+dE; % nova energia
            M=M-s(i)+sli; % nova Magnetizacao
            s(i)=sli;
        end
    
    end
    % calculo das media
    if t>nequi
        % Mmed, Emed, E2med, M2med
        Mmed=Mmed+ abs(M);
        Emed=Emed+E;
        M2med=M2med+ M^2;
        E2med=E2med+E^2;
        
    end
    
end
nmedidas=npassos-nequi;
Mmed=Mmed/nmedidas; Emed=Emed/nmedidas; E2med=E2med/nmedidas; 
M2med=M2med/nmedidas;

Cv=(E2med-Emed^2)/T^2; Susc=(M2med-Mmed^2)/T;


end