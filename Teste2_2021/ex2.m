% ex 2 do teste 23/6/21 MFE
% Alexandre Rodrigues 92993

clear all
close all

c=4;
N=1000;

%% a)

[listav, nv, S, comp]=rede_aleatoria(N,c);

% estado do sistema
e=zeros(N,1);
%suscetivel e=0; infecioso e=1; recuperado e=2;

% numero de componentes 
nc=max(comp);
for i=1:nc
    sz(i)=sum(comp==i); %tamanho da componente i
end
[S,cg]=max(sz); % S é  o tamanho da componente gigante e cg é o label
verticesCG=find(comp==cg); 

vertices2=find(nv==2); % 2 contactos 
vertices4=find(nv==4);
vertices6=find(nv==6);

frac2=numel(vertices2)/N;
frac4=numel(vertices4)/N;
frac6=numel(vertices6)/N;

fprintf(1,'frac2=%f, frac4=%f, frac6=%f\n', frac2, frac4, frac6)

% R.: Tal como esperado há uma maior fração de sitios com 4 contactos, o número médio defenido,c.


%% b)

betav=linspace(0.01,0.5,50);
gama=1;
ntransicoes=1e5; 
Nei=500;

fracr=zeros(numel(betav),1);
ibeta=0;
for beta=betav
    ibeta=ibeta+1;
    for act=1:Nei
        e=zeros(N,1);
        % escolher um ao acaso
        i=randi(S,1); % escolhe um dos S ao acaso
        % construimos o estado inicial
        e(verticesCG(i))=1; % coloca este vertice como infetado

        [kk,kmax]=size(listav); % kmax é o número de colunas de lista v
        % atribuir vertices às classes
        [classe,n_classe]=constroi_classe(N,e, listav, nv,kmax);

        
        % fazer a simulação
        [~,~,~, nr, ntr]=MC_tempo_continuo(N, beta, gama,listav, nv, e, kmax, n_classe, classe,ntransicoes);

        fracr(ibeta)=fracr(ibeta)+nr(ntr)/N;
    end
    fracr(ibeta)=fracr(ibeta)/Nei;
    fprintf(1,'beta=%f, fracr=%f\n', beta, fracr(ibeta))
end

figure(1)
plot(betav,fracr,'k.')
xlabel('beta'); ylabel('fracr')

% R.: Podemos estimar o valor de beta critico como 0.25.



%% c)

gama=1/15;
beta=3*gama;

e=zeros(N,1);
i=randi(S,1); % escolhe um dos S ao acaso
% construimos o estado inicial
e(verticesCG(i))=1; % coloca este vertice como infetado

% atribuir vertices às classes
[classe,n_classe]=constroi_classe(N,e, listav, nv,kmax);


[t,ns, ni, nr, ntr,nis,nss]=MC_tempo_continuo(N, beta, gama,listav, nv, e, kmax, n_classe, classe,ntransicoes);

figure(3)
plot(t(1:ntr),nss(1:ntr,1),'b-', t(1:ntr),nss(1:ntr,2),'r-', t(1:ntr),nss(1:ntr,3),'k-')
hold on
plot(t(1:ntr),nis(1:ntr,1),'b--', t(1:ntr),nis(1:ntr,2),'r--', t(1:ntr),nis(1:ntr,3),'k--')
xlabel('t'); ylabel('ni2, ni4, ni6')
legend('ns2', 'ns4' , 'ns6','ni2', 'ni4' , 'ni6','Location','NorthEastOutside')

%% 

function [classe,n_classe]=constroi_classe(N,e, listav, nv,kmax)
classe=zeros(N,kmax+1); %inicializaçao da matriz das classes
n_classe=zeros(kmax+1,1); % regista o numero de vertices em cada classe
for i=1:N
    % suscetiveis
    if e(i)==0 % vertice suscetivel
        % calcular numero de vizinhos infetados
        nvi=0;
        for j=1:nv(i)
            if e(listav(i,j))==1 % esta infetado
                nvi=nvi+1;
            end
        end
        if nvi>0
            n_classe(nvi)=n_classe(nvi)+1; 
            classe(n_classe(nvi),nvi)=i; % colocamos o vertice i na classe ni
        end
    elseif e(i)==1
        n_classe(kmax+1)=n_classe(kmax+1)+1; % aumentamos o numero na classe dos infetados
        classe(n_classe(kmax+1),kmax+1)=i;
    end
           
end

end

function [t,ns, ni, nr,ntransicoes,nis,nss]=MC_tempo_continuo(N, beta, gama,listav, nv, e, kmax, n_classe, classe,ntransicoes)
ns=zeros(ntransicoes,1); ni=ns; nr=ns;
ns(1)=sum(e==0); ni(1)=sum(e==1); nr(1)=N-ns(1)-ni(1);
t=zeros(ntransicoes,1); pr=zeros(kmax+1,1);

nis=zeros(ntransicoes,3);
nss=zeros(ntransicoes,3);

vertices2=find(nv==2); % 2 contactos 
vertices4=find(nv==4);
vertices6=find(nv==6);

nss(1,1)=sum(e(vertices2)==0);
nss(1,2)=sum(e(vertices4)==0);
nss(1,3)=sum(e(vertices6)==0);

nis(1,1)=sum(e(vertices2)==1);
nis(1,2)=sum(e(vertices4)==1);
nis(1,3)=sum(e(vertices6)==1);

for tr=1:ntransicoes
    if (mod(tr,1000)==0)
        fprintf(1,'Transicao tr=%d\n',tr)
    end
    % copia informacao do instante anterior
    ns(tr+1)=ns(tr); ni(tr+1)=ni(tr); nr(tr+1)=nr(tr);
    nis(tr+1,:)=nis(tr,:);
    nss(tr+1,:)=nss(tr,:);
    
    % taxa total de transicao
    lambda=sum(beta*[1:kmax]'.* n_classe(1:kmax))+gama*n_classe(kmax+1);
    if lambda==0
        ntransicoes=tr-1;
        %fprintf(1,'Epidemia Terminou, Número de transições=%d\n', ntransicoes)
        return
    end
    % tempo para a transicao com distribuição exponencial
    tau=-log(1-rand(1))/lambda; % tempo de espera até se observar transicao
    t(tr+1)=t(tr)+tau; % instante de tempo em que se d'a a transição
    %fazer a transicao
    % escolher ao caso com probabiloidade pr uma das classes
    i=[1:kmax]';
    
    pr(i)=i.*n_classe(1:kmax)*beta/lambda;
    pr(kmax+1)=gama*n_classe(kmax+1)/lambda;
   
    caso=roleta(kmax+1,pr); % indica-nos em que classe vai ocorrer a transição
    % escolher um vertice da classe para fazer a transição
    
    if caso ~= kmax+1
        % um suscetivel infetou
        ns(tr+1)=ns(tr+1)-1; ni(tr+1)=ni(tr+1)+1;
        %escolher um dos suscetiveis da classe
        i=randi(n_classe(caso),1);
        index=classe(i,caso);
        e(index)=1; % infetou 
        if sum(vertices2==index)==1
            nss(tr+1,1)=nss(tr+1,1)-1;
            nis(tr+1,1)=nis(tr+1,1)+1;
        elseif sum(vertices4==index)==1
            nss(tr+1,2)=nss(tr+1,2)-1;
            nis(tr+1,2)=nis(tr+1,2)+1;
        elseif sum(vertices6==index)==1
            nss(tr+1,3)=nss(tr+1,3)-1;
            nis(tr+1,3)=nis(tr+1,3)+1;
        end
    else
        i=randi(n_classe(kmax+1),1); % escolher um infetado ao acaso
        e(classe(i,kmax+1))=2; % o infetado recuperou
        ni(tr+1)=ni(tr+1)-1; nr(tr+1)=nr(tr+1)+1;
        index=classe(i,kmax+1);
        if sum(vertices2==index)==1
            nis(tr+1,1)=nis(tr+1,1)-1;
        elseif sum(vertices4==index)==1
            nis(tr+1,2)=nis(tr+1,2)-1;
        elseif sum(vertices6==index)==1
            nis(tr+1,3)=nis(tr+1,3)-1;
        end
    end
    
    % atualiza a matriz das classes
    % pode fazer-se a atualizacao de modo muito mais eficiente 
    % o que faz nesta versao é construir a matriz classe de novo
    [classe,n_classe]=constroi_classe(N,e, listav, nv,kmax);
    
end

end

function caso=roleta(nr,pr)
% escolhe um de nr casos com probabilidade de cada caso no vetor pr
u=rand(1);
pacum=0;
for i=1:nr
    pacum=pacum+pr(i);
    if u<=pacum
        caso=i;
        return
    end
end
end

function  [comp]=componentes(listav,nv)

[n,kmax]=size(listav);
comp=zeros(n,1); % cada sitio pertencente a uma componente vai ser identificado 
%por um numero
verificado=zeros(n,1); %lista dos verificados
averificar=zeros(n,1); % lista dos sitios a verificar
n_averificar=0;
rotulo=0; % rotulo inicial

for i=1:n
    if verificado(i)==0 % ainda nao esta verificado
       verificado(i)=1; % passa a verificado
       % colocar na lista a verificar
       n_averificar=n_averificar+1; % aumenta o numero na lista a verificar
       averificar(n_averificar)=i; %colocado na lista a verificar
       rotulo=rotulo+1;
       comp(i)=rotulo; % atribuimos o rotulo ao nodo i
    end
    while  n_averificar > 0
        j=averificar(n_averificar); % vamos  verificar o nodo j (ultimo da lista
        n_averificar=n_averificar-1; %removemos esse nodo da lista averificar
        % adicionar os vizinhos desse nodo a' lista a verificar
        for jv=1:nv(j)
            comp(listav(j,jv))=rotulo; % os vizinhos têm o mesmo rotulo
            if verificado(listav(j,jv))==0 % se o vizinho nao estiver verificado
                % adicionamos o vizinho a' lista a verificar
                n_averificar=n_averificar+1;
                averificar(n_averificar)=listav(j,jv); % adicionado a lista
                verificado(listav(j,jv))=1;
            end
        end        
  
    end
    
end

end

function [listav,nv, S, comp]=rede_aleatoria(n,c)

%criar rede aleatória
%n = numero total de nodos
%c=numero medio de vizinhos ou grau medio

p=c/(n-1); % probabilide de uma aresta existir
kmax=floor(10*c); %numero maximo de vizinhos admitido

listav=zeros(n,kmax);
nv=zeros(n,1);
for i=1:n
    for j=i+1:n
        if rand(1) <=p
            nv(i)=nv(i)+1; nv(j)=nv(j)+1;
            listav(i,nv(i))=j; listav(j,nv(j))=i;
        end
    end
end

comp=componentes(listav,nv);

ncomponentes=max(comp); % numero de componentes

% calcular tamanho das componentes
scomp=zeros(n,1); % tamanho de cada componente
for rotulo=1:ncomponentes
    scomp(rotulo)=sum(comp==rotulo); % calcula o numero de nodos
    % no vetor com que e' igual ao rotulo
end
[S,rS]=max(scomp); % a componente gigante e' a componente com maior tamanho

S=S/n;


end




