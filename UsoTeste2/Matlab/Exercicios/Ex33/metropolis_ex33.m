function [Emedio,E2medio,nkmedio]=metropolis_ex33(T,nequi,nmedidas,N,nmax)

% PASSO 1
[lv,nv]=listv3d_sem_cfp(nmax);
nk=zeros(nmax^3,1);
nkmedio=nk;
estado_particula=ones(N,1); % todas as particulas no estado k de menor energia
E=3*N/4;      % Energia inicial do sistema quando todas estão no estado k de mais baixa energia
nk(1)=N; % Todas as particulas estão no estado 1
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
        ny=floor(mod(ik-1,nmax^2)/nmax)+1; 
        nz=floor((ik-1)/nmax^2)+1;
        Epi=(nx^2+ny^2+nz^2)/4;
        
        nxv=mod(ikv-1, nmax)+1; 
        nyv=floor(mod(ikv-1,nmax^2)/nmax)+1; 
        nzv=floor((ikv-1)/nmax^2)+1;
        Epf=(nxv^2+nyv^2+nzv^2)/4;
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
        E2medio=E2medio+E^2;
        nkmedio=nkmedio+nk;
    end
end
Emedio=Emedio/nmedidas;
E2medio=E2medio/nmedidas;
nkmedio=nkmedio/nmedidas;

end