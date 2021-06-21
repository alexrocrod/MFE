close all, clear all
start_time = tic;

% parametros
nequi = 5E3; % numero de passos para equilibrio
nmedidas = 2E4; % numero de medidas apos equilibrio
N = 100; % numero de particulas
nmax = 60; % numero quantico maximo
Tv = linspace(3, 300, 30); % vector de temperaturas

ic = 1; % contador
z = zeros(length(Tv),1);
Emedio = zeros(1,length(Tv));
E2medio = zeros(1,length(Tv));
for T = Tv
    fprintf("Simulacao %d/%d\n", ic, length(Tv))
    
    [Emedio(ic), E2medio(ic), nkmedio, EF2] = metropolisFermioes(T, nequi, nmedidas, N, nmax);
    
    z(ic) = nkmedio(1) / (1 - nkmedio(1)); % o primeiro valor do nkmedio
    % e que guarda o estado de menor energia
    
    ic = ic + 1;
end

% comparacao com valores teoricos
Tt = transpose(linspace(3, 300, 30));
zt = exp(4*N./(pi*Tt)) - 1;
Et = -(pi/4).*Tt.^2.*dilog(1 + zt);
EGi = N*Tv; % gas ideal classico

fig1 = figure(1);
movegui(fig1,'northwest');
plot(Tv, Emedio-2*N, 'k*', Tt, Et, 'r-', Tv, EGi, 'r--')
xlabel('T')
ylabel('<E>')
legend('Location','northwest')
legend('<E> Simulação','<E> Teórica','<E> Gás ideal')

fig2 = figure(2);
movegui(fig2,'north');
semilogy(Tv, z, 'k*', Tt, zt, 'r-')
xlabel('T')
ylabel('z')
legend('Fugacidade Simulação','Fugacidade Teórica')

fig3 = figure(3);
movegui(fig3,'northeast');
% calculo da capacidade termica
Cv = (E2medio - Emedio.^2) ./ Tv.^2;
CvGi = N*ones(length(Tv),1); % gas ideal classico
plot(Tv, Cv, 'k*', Tv, CvGi, 'k-')
xlabel('T')
ylabel('Cv')
legend('Location','southeast')
legend('Cv Simulação','Cv Gás ideal')

end_time = toc(start_time);
fprintf("Execution time | %d:%d (minutes:seconds) | %d (seconds)\n", ...
    floor(end_time/60), round(mod(end_time,60)), end_time)