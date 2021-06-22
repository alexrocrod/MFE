% metropolis 3D Fermioes (ex35)
function [Emedio,E2medio,nkmedio,EF2]=metropolis_Fermioes_3D(T,nequi,nmedidas,N,nmax)
    % Gás idela Fermiões

    % PASSO 1
    [lv,nv]=lista_vizinhos(nmax);
    nk=zeros(nmax^3,1);
    nkmedio=nk;
    estado_particula=zeros(N,1);
    Eestado=zeros(nmax^3,1);
    for nx=1:nmax
        for ny=1:nmax
            for nz=1:nmax
                ik=nx+nmax*(ny-1)+nmax^2*(nz-1);
                % calcula a energia de cada estado
                Eestado(ik)=(nx^2+ny^2+nz^2)/4;
            end
        end
    end
    % ordena em ordem crescente
    [Eestado_ordenado,ik_ordem]=sort(Eestado,'ascend');
    % colocar particulas nos estados
    E=0;
    for i=1:N
        estado_particula(i)=ik_ordem(i);
        nk(ik_ordem(i))=1;
        E=E+Eestado_ordenado(i);
    end
    % Energia de Fermi
    EF2=Eestado_ordenado(N); % Estado de + alta energia ocupado no estado fundamental

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
            if (nk(ikv)==0)

%                 nx=mod(ik-1, nmax)+1; 
%                 ny=floor(mod(ik-1,nmax^2)/nmax)+1; 
%                 nz=floor((ik-1)/nmax^2)+1;
                Epi=Eestado(ik);
%                 Epi=(nx^2+ny^2+nz^2)/4;

%                 nxv=mod(ikv-1, nmax)+1; 
%                 nyv=floor(mod(ikv-1,nmax^2)/nmax)+1; 
%                 nzv=floor((ikv-1)/nmax^2)+1;
                Epf=Eestado(ikv);
%                 Epf=(nxv^2+nyv^2+nzv^2)/4;
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

% metropolis 2D Fermioes (ex34)
function [Emedio,E2medio, nkmedio]=metropolis_Fermioes_2D(T,nequi,nmedidas,N,nmax)

    % PASSO 1
    [lv,nv]=lista_vizinhos(nmax);

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

% metropolis 3D Bosoes (ex33)
function [Emedio,E2medio,nkmedio]=metropolis_Bosoes_3D(T,nequi,nmedidas,N,nmax)

    % PASSO 1
    [lv,nv]=lista_vizinhos_3D(nmax);
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

% metropolis 2D Bosoes (ex32)
function [Emedio,E2medio,nkmedio]=metropolis_Bosoes_2D(T,nequi,nmedidas,N,nmax)

    % PASSO 1
    [lv,nv]=lista_vizinhos(nmax);
    nk=zeros(nmax^2,1);
    nkmedio=nk;
    estado_particula=ones(N,1); % todas as particulas no estado k de menor energia
    E=2*N;      % Energia inicial do sistema
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
