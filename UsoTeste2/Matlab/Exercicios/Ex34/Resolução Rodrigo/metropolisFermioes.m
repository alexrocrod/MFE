function [Emedio, E2medio, nkmedio, EF2] = metropolis3Dadaptado(T, nequi, nmedidas, N, nmax)
% Gas ideal Fermioes

[lv,nv] = listv2d_sem_cfp(nmax);

% numero de particulas com vector de onda k
nk = zeros(nmax^2,1);
nkmedio = nk;

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

% energia de Fermi igual ao estado de mais alta energia ocupado no estado
% fundamental
EF2 = Eestado_ordenado(N);

npassos = nequi + nmedidas;

Emedio = 0;
E2medio = 0;

for t = 1:npassos
    for act = 1:N
        % escolha de particula ao acaso
        ip = randi(N,1);
        ik = estado_particula(ip);
        
        % estado vizinho de ik escolhido ao acaso de entre nv(ik)
        ikv = lv(ik, randi(nv(ik),1));
        
        % so se fazem os calculos se o estado que se esta a considerar nao
        % tiver ja uma particula
        if (nk(ikv) == 0)
            % as energias ja estao calculadas por isso basta seleccionar o
            % valor correspondente a particula escolhida aleatoriamente
            Epi = Eestado(ik);
            Epf = Eestado(ikv);

            % variacao de energia
            dE = Epf - Epi;

            % probabilidade de aceitacao
            pA = min([ 1, (nv(ik)*(nk(ikv) + 1) * exp(-dE/T)) / (nv(ikv)*nk(ik)) ]);

            if rand(1) < pA
                estado_particula(ip) = ikv;
                nk(ik) = nk(ik) - 1;
                nk(ikv) = nk(ikv) + 1;
                E = E + dE;
            end
        end
    end
    
    if t > nequi
        Emedio = Emedio + E;
        E2medio = E2medio + E^2;
        nkmedio = nkmedio + nk;
    end
end

Emedio = Emedio/nmedidas;
E2medio = E2medio/nmedidas;
nkmedio = nkmedio/nmedidas;
end