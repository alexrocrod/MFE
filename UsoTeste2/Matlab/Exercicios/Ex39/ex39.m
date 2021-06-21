clear all; close all
% Exercicio 36

N=1000; % nº de nodos
c=1.5;  % nº médio de vizinhos
[listv,nv, lista_sitios]=rg(N,c);
ncomp=numel(unique(lista_sitios));
fprintf(1,'numero de componentes=%d\n',ncomp)

for i=transpose(unique(lista_sitios))
    tamanho_comp(i)=sum(lista_sitios==i);
end
[S,lmax]=max(tamanho_comp);
fprintf(1,'Tamanho da maior componente=%d \n Label da maior componente=%d\n',S,lmax)
kmax=max(nv);
fprintf(1,'kmax=%d\n',kmax)
tmax=10000;

g=1/kmax; % taxa de recuperaÃ§Ã£o
% bc/gama_c = 1/<k> ; %estimativa baseada na teoria baseada no grau
bc=1/(c*kmax);
b=2;
fprintf(1,'b=%f \n bc=%f\n',b,bc );

dt=1/(N*g*kmax);

s=zeros(N,1);

vertices_na_maior_componente=find(lista_sitios==lmax);
i=vertices_na_maior_componente(randi(S,1)); % escolhemos um sitio ao acaso
%na maior componente
fprintf('Vertice infetado inicialmente=%d\n',i);
s(i)=1; % 1 unico infetado no inicio
tv=zeros(tmax,1);

xi=zeros(tmax,1);
xs=zeros(tmax,1);
xi(1)=1/N;
xs(1)=1-1/N;
Ni=1;   % infetados
Ns=N-1; % suscetiveis
Nr=0;   % recuperados
xinovo=xi(1);
for t=2:tmax
    tv(t)=tv(t-1)+dt*N;
    for act=1:N
        % escolher vertice ao acaso
        i=randi(N,1);
        if s(i)==0
            ni= sum(s(listv(i,1:nv(i))) ==1);% numero de infetados na vizinhanca de i
            if rand(1) < b*ni/(g*kmax)
                s(i)=1;
                Ni=Ni+1;
                Ns=Ns-1;
            end
        elseif(s(i)==1) % recuperaÃ§Ã£o de um infetado
            if rand(1) < 1/kmax
                s(i)=2;
                Ni=Ni-1; Nr=Nr+1;
            end
        end
    end
    xi(t)=Ni/N;
    xs(t)=Ns/N;
    if (mod(t,10)==0)
        % faz grafico de 10 em 10 passos
        plot(tv(1:t), xi(1:t),'r-', tv(1:t),xs(1:t),'b-',tv(1:t),1-xs(1:t)-xi(1:t),'k-',[tv(1) tv(t)],[S, S]/N,'g-')
        legend(['infeciosos ' ; 'suscetives ';'recuperados';'S          '],'Location','SouthEast')
        %text(mean([tv(1) tv(t)]), 1.1*tmax/N,'S')
        xlabel('t');
        ylabel('fracao')
        drawnow
        xianterior=xinovo;
        xinovo=xi(t);
        if abs(xinovo-xianterior) <1/N
            break;
        end
    end
    
end
