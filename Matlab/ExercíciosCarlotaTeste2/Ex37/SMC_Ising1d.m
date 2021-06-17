 function [emed, cv, mag, susc,dmed]=SMC_Isinf1d(T,H,N,npassos, nequi)
% unidade de energia uE=J; uT=J/kB
%s=ones(1,N); % come√ßamos do estado com si=1 para todo o i
s=2*(randi(2,1,N)-1)-1; % s(i) aleatorio = +/-1

[listav,nv]=rede1d(N);
% dominios(s,listav,N);
E=0;
M=0;
for i=1:N
    E=E-s(i)*s(listav(i,2))-H*s(i); % express„o nos slides
    M=M+s(i);
end
% Inicializar os valores que queremos obter
emed=0; 
cv=0; 
mag=0; 
susc=0; 
dmed=0;

for t=1:npassos
    for act=1:N
        i=randi(N,1); % escolhemos um spin ao acaso 
        sl=-s(i); % propomos a inversao do spin
        dE=(s(i)-sl)*(s(listav(i,1))+s(listav(i,2)))+H*(s(i)-sl);
        dM=sl-s(i);
        % aceitar com pA=min(1,exp(-dE/T))
        if rand(1) < min([1,exp(-dE/T)])
             s(i)=sl;
             E=E+dE; 
             M=M+dM;
        end
    end
    if t> nequi
        emed=emed+E; 
        cv=cv+E^2;  
        mag=mag+M; 
        susc=susc+M^2;
        dmed=dmed+dominios(s,listav,N);
    end
end
nmedidas=npassos-nequi;
emed=emed/nmedidas; 
cv=cv/nmedidas; 
mag=mag/nmedidas; 
susc=susc/nmedidas;
cv=(cv-emed^2) / T^2; 
susc=(susc-mag^2)/T;
dmed=dmed/nmedidas;
end

function [listav,nv]=rede1d(N)
% condicoes fronteira periodicas
for i=1:N
    listav(i,1)=i-1; 
    listav(i,2)=i+1; 
    nv(i)=2;
    if i==1
        listav(i,1)=N;
    end
    if i==N
        listav(i,2)=1;
    end
end
end

% funÁ„o para calcular os dominios
% dominios --> conjunto de spins todo igual
function dmed=dominios(s,listav,N)
% fronteira entre dominios
front=zeros(1,N);

% for i=1:N
%     if s(i) ~= s(listav(i,2))
%         front(i)=1;
%     end
% end
% o ciclo for pode ser substituido por front=abs(s-s(listav(:,2))/2
front=s-s(listav(:,2));
pos=find(front~=0);
if numel(pos)==0
    dmed=N;
else
    dpos=[diff(pos), pos(1)+N-pos(end)]; %condicoes fronteira periodicas
    dpos(dpos>=N/2)=dpos(dpos>=N/2)-N/2; % condicoes fronteira periodicas
    dmed=mean(dpos);
   
end

end