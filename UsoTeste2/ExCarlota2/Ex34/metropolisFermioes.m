function [Emedio,E2medio, nkmedio]=metropolisFermioes(T,nequi,nmedidas,N,nmax)

% PASSO 1
[lv,nv]=listv2d_sem_cfp(nmax);

nk=zeros(nmax^2,1);
nkmedio=nk;

% calcular a energia de cada estado
estado_particula = zeros(N,1);
Eestado = zeros(nmax^2,1);
for nx = 1:nmax
    for ny = 1:nmax
        ik = nx + nmax*(ny-1);
        Eestado(ik) = nx^2 + ny^2;
    end
end
[Eestado_ordenado, ik_ordem] = sort(Eestado, 'ascend'); % ordem crescente

% colocar N particulas nos respectivos estados de forma crescente em
% energia
E = 0;
for i = 1:N
    estado_particula(i) = ik_ordem(i);
    nk(ik_ordem(i)) = 1;
    E = E + Eestado_ordenado(i);
end

npassos = nequi + nmedidas;
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
        % estado vizinho de ik escolhido ao acso de entre nv(ik)
        ikv=lv(ik,randi(nv(ik),1)); 
        
        % so se fazem os calculos se o estado que se esta a considerar nao
        % tiver ja uma particula
        if (nk(ikv) == 0)
            % as energias ja estao calculadas por isso basta seleccionar o
            % valor correspondente a particula escolhida aleatoriamente
            Epi = Eestado(ik);
            Epf = Eestado(ikv);
            % variacao de energia
            dE=Epf-Epi;
            
            % PASSOS 2C
            % probabilidade de aceitacao
            pA=min([1, ((nv(ik)*(nk(ikv)+1))/(nv(ikv)*nk(ik))) * exp(-dE/T)]);
            
            if rand(1)<pA
                % PASSO 2D
                estado_particula(ip)=ikv;
                nk(ik)=nk(ik)-1;
                nk(ikv)=nk(ikv)+1;
                E=E+dE;
            end
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