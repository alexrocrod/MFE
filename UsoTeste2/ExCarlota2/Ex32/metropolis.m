function [Emedio,E2medio,nkmedio]=metropolis(T,nequi,nmedidas,N,nmax)

% PASSO 1
[lv,nv]=listv2d_sem_cfp(nmax);
nk=zeros(nmax^2,1);
nkmedio=nk;
estado_particula=ones(N,1); % todas as particulas no estado k de menor energia
E=2*N;      % Energia inicial do sistema
nk(1)=N; % Todas as particulas est�o no estado 1
Emedio=0;
E2medio=0;
% PASSOS 2
npassos=nequi+nmedidas;
for t=1:npassos
    for act=1:N
        % PASSO 2A
        ip=randi(N,1);
        ik=estado_particula(ip);
        % PASSO 2B
        ikv=lv(ik,randi(nv(ik),1)); % estado vizinho de ik escolhido ao acso de entre nv(ik)
        nx=mod(ik-1, nmax)+1; 
        ny=floor((ik-1)/nmax)+1; 
        Epi=nx^2+ny^2;
        
        nxv=mod(ikv-1, nmax)+1; 
        nyv=floor((ikv-1)/nmax)+1; 
        Epf=nxv^2+nyv^2; 
        
        dE=Epf-Epi;
        
        % PASSOS 2C
        pA=min([1, ((nv(ik)*(nk(ikv)+1))/(nv(ikv)*nk(ik))) * exp(-dE/T)]);
        
        if rand(1)<pA
            % PASSO 2D
            estado_particula(ip)=ikv;
            nk(ik)=nk(ik)-1;
            nk(ikv)=nk(ikv)+1;
            E=E+dE;
        end
    end
% PASSO 2E
    if t>nequi
        Emedio=Emedio+E;
        E2medio=E2medio+E;
        nkmedio=nkmedio+nk;
    end
end
Emedio=Emedio/nmedidas;
E2medio=E2medio/nmedidas;
nkmedio=nkmedio/nmedidas;

end