
function [Emedio,EDmedio,binsV,hv]=fex27(N,E0,nequi, nmedidas)
%E0 = Energia total do gas ideal 
%um=m; 
%uv=sqrt(uE/uM)
%N = numero de particulas
%particulas discerniveis
%Estado do sistema (r1,p1,r2,p2,....,rN,pN)


p=zeros(N,3); % momentos lineares
v0=sqrt(2*E0/N);
p(:,1)=v0*ones(N,1); %HAVIA ERRO AQUI p(:,1)=v0*zeros(N,1);
dv0=v0/10;
binsV=transpose(0:dv0:3*v0);
hv=zeros(numel(binsV),1);

ED=0;
E=E0;
npassos=nequi+nmedidas;

EDt=zeros(npassos,1);
EDmedio=0; Emedio=0;
for t=1: npassos
    
    for nact=1:N
        
    % perturbar o momento de uma particula escolhida ao acaso
    
    %escolher a particula
    ip=randi(N,1);
    dp=(2*rand(1,3)-1)*dv0;
    dE=dot(p(ip,:),dp)+0.5*norm(dp)^2;

        if dE<0
           % aceitamos a perturbação
           p(ip,:)=p(ip,:)+dp;
           E=E+dE;
           ED=ED-dE;
        else
            if dE<=ED
               p(ip,:)=p(ip,:)+dp;
               E=E+dE;
               ED=ED-dE;   
            end
        end
            
    end% end nact  
        
     EDt(t)=ED;
    if t> nequi
        EDmedio=EDmedio+ED;
        Emedio=Emedio+E;
        % histograma do modulo das velocidades
        norma_p=sqrt(p(:,1).^2+p(:,2).^2+p(:,3).^2);
        [aux]=hist(norma_p,binsV);
        hv=hv+transpose(aux);
    end
    
end %end t

Emedio=Emedio/nmedidas;
EDmedio=EDmedio/nmedidas;
hv=hv/(nmedidas*N*(binsV(2)-binsV(1)));

% alinea b
h1=figure(1);
set(h1, 'Units','normalized', 'Position',[0,1/3, 1/4,1/3])
subplot(2,1,1)
tv=1:npassos;
plot(tv,EDt,'.')
xlabel('t'); ylabel('ED(t)');
% histograma dos valores observados de ED
% Bins de energia
deltaE=1; 
Ebins=[0: deltaE: E0/5]; % Alteração Ebins=[0: deltaE: E0] Nao e' necessario utilizar um valor maximo de bin de energia igual a E0

hED=hist(EDt,Ebins); hED=hED/sum(hED)/deltaE; %normalizacao
subplot(2,1,2)
PED=(1/EDmedio)*exp(-Ebins/EDmedio); % valor esperado para P(ED)
semilogy(Ebins,hED,'.', Ebins,PED,'k-')
xlabel('ED'); ylabel('P(ED)')
end
