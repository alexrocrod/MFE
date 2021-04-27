function [Emedio,EDmedio,Ebins,NmedioE]=f_ex28_c(E0,np_equi,n_medidas)
% E0 --> Energia total do gas considerando uE=hc/(2L)
% np_equi --> nº de passos para o equilibrio (que vamos desprezar no inicio)

n0=floor(sqrt( E0^2-1));       % formula dada no inunciado
                            % numero quantico máximo de um fotão
n0=min(n0,50);
% Bins de energia
deltaE=sqrt(2);
Ebins=[sqrt(2): deltaE: E0];
nbinsE=numel(Ebins);
% Faz corresponder nx e ny a um bin de energia
for nx=1:n0
     for ny=1:n0
         E=sqrt(nx^2+ny^2); 
         bin=floor((E-sqrt(2))/deltaE)+1;
         nx_ny_to_binE(nx,ny)=bin;
     end
end

% Estado do sistema Nf(nx,ny)= Numero de fotoes com dados numeros quantico (nx,ny)
% (é especificado indicando quantos fotões existem com um dado nx e ny)
Nf=zeros(n0,n0); % estado microscópico inicial do sistema (neste caso,sem fotões)
% Energia inicial do gas de fotões = zero
npassos = np_equi+n_medidas;
ED = E0; % Energia inicial do demon
E=0;
EDt=zeros(npassos,1);
EDmedio=0; Emedio=0;
NmedioE=zeros(nbinsE,1);

for t=1:npassos
    for nact=1:n0^2
        %escolher um tipo de fotão ao acaso
        nx=randi(n0,1); % inteiro uniforme
        ny=randi(n0,1);
        % escolher e aumentar ou diminuir com igual probabilidades tendo em conta
        % que o número de fotões não podes ser negativo
        na = rand(1);
        if na<=0.5
            % diminuimos N(nx,ny) em uma unidade
            if Nf(nx,ny)>=1
                Nf(nx,ny) = Nf(nx,ny)-1;
                dE=-sqrt(nx^2+ny^2);
                E=E+dE;
                ED=ED-dE;
            end
        else
            % aumentamos N(nx,ny) em uma unidade
            % a energia do demon é sempre positiva
            dE=sqrt(nx^2+ny^2); % energia necessária para criar fotão
            if ED>=dE
                Nf(nx,ny)=Nf(nx,ny)+1;
                E=E+dE;
                ED=ED-dE;
            end
        end
    end %end nact
    EDt(t)=ED;
    if t> np_equi
        EDmedio=EDmedio+ED;
        Emedio=Emedio+E;
        % acumulamos os valores do numero de fotoes com uma dada energia
        for nx=1:n0
            for ny=1:n0
                 Enxny=sqrt(nx^2+ny^2);
                 if Enxny<=E0 % so acumulamos o numero de fotoes com energia inferior a E0
                    NmedioE(nx_ny_to_binE(nx,ny))=NmedioE(nx_ny_to_binE(nx,ny))+Nf(nx,ny);
                 end
            end
        end
    end
end %end npassos
NmedioE=NmedioE/(nmedidas*(Ebins(2)-Ebins(1))); 
Emedio=Emedio/n_medidas;
EDmedio=EDmedio/n_medidas;

figure(1)
subplot(2,1,1)
tv=1:npassos;
plot(tv,EDt,'.')
xlabel('t'); 
ylabel('ED(t)');
% histograma dos valores observados de ED
Ebins=[0: deltaE: E0];
hED=hist(EDt,Ebins); 
hED=hED/sum(hED)/deltaE; %normalizaca
subplot(2,1,2)
PED=(1/EDmedio)*exp(-Ebins/EDmedio); % valor esperado para P(ED)
semilogy(Ebins,hED,'.', Ebins,PED,'k-')
xlabel('ED'); 
ylabel('P(ED)')
Ebins=[sqrt(2): deltaE: E0];
end
