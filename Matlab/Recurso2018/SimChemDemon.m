function [Edt,Ndt]=SimChemDemon(teq,tmax,L,N,E)
%input
%teq - tempo de equilibraçao em MCS/N
%tmax- tempo de simulaçao para calculode medias em MCS/N
%L - tamanho da rede
%N- Numero de particulas
%E - Energia total do sistema

% output 
% Ndt - numero de particula no demon para t>teq
% Edt - Energia do demon para t>teq

pm=ceil(sqrt(E)); % maximo valor dos momentos -pm<=p<=pm
jmax=2*pm+1; % numero dtotal e valores de p
ps=zeros(L,jmax); % matriz que armazena a ocupaçao do espaço de fases (x,p)
% com x inteiro entre 1 e L e p inteiro entre -pm e pm

x=zeros(L,1);% vetor que armazena a ocupaçao da componente x do espaço de fases

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p0=ceil(sqrt(E/N)); % momento inicial das particulas
Es=0;%energia do sistema
N0=floor(E/(p0*p0)); % numero de particulas com momento p0
%%colocam-se N particulas numa posiçao aleatoria e momento +/-p0
for k=1:N0
    ix=randi(L);
    jp0=(2*(randi(2)-1)-1)*p0+pm+1;
    cond=ps(ix,jp0)>0; % nao se permite que mais que 1 particula ocupe um ponto do espaço de fases
    
    while(cond) % caso o ponto do espaço de fases esteja ocupado procura aleatoriamente outro ponto
        % para colocar a particula
    ix=randi(L);
    jp0=(2*(randi(2)-1)-1)*p0+pm+1;
    cond=ps(ix,jp0)>0;
    end
    ps(ix,jp0)=1; %atualiza ocupaçao do espaço de fases
    x(ix)=x(ix)+1;
    Es=Es+p0*p0; % atualiza a energia do sistema
end

Nd=N-N0; % particulas nao colocadas no espaço de fases e atribuidas ao emon
Ed=E-Es; % energia inicial do demon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% grafico da distribuiçao inicial das particulas pelo espaço de fase
% pontos com particulas sao representados com .
figure(3)
          [i1,i2]=find(ps>0);
          plot(i1,i2-pm-1,'.');  axis([1, L, -pm,pm])
          xlabel('x'); ylabel('p');  set(gcf,'Position',[1,10, 300, 200]); drawnow

for t=1:teq+tmax % ciclo temporal de simulaçao em MCS/N
    for ip=1:N % ciclo para atualizar N pontos do espaço de fases em  cada valor de t
         ix=randi(L); %escolhe aleatoriamente um ponto do espaço de fases
         jp=randi(2*pm+1);
         Ep=(jp-pm-1)^2; % energia de uma particula no ponto do espaço de fases
    
           
       if ps(ix,jp)==0 % se o ponto do espaço de fases estiver vazio
       
           if (Nd>0 && Ep<=Ed ) % se o demon tiver particulas e energia suficiente para criar uma particula
              Ed=Ed-Ep;        %cria a particula e diminui a energia do demon        
              x(ix)=x(ix)+1;  % atualiza ocupaçao do espaço de fases
              ps(ix,jp)=1;
              Nd=Nd-1; % diminui o numero de particulas no demon
              
           end
       else % caso o ponto do espaço de fases esteja ocupado
           Nd=Nd+1; % retira a particula para o demon aumentando o numero de particulas
           Ed=Ed+Ep; % atualiza a energia do demon
           ps(ix,jp)=0; % atualiza a ocupaçao do espaço de fases
           x(ix)=x(ix)-1;
       end
    end   
          
   if t>teq   % se t>teq regista o valor do numero de particulas no demon e da energia do demon num vetor
          % Ndt e Edt
          Ndt(t-teq)=Nd; Edt(t-teq)=Ed;  
          if(mod(t,tmax/100)==0)
              % de tmax/10 em tmax/100 passos imprime o tempo
             fprintf(' t=%f\n',t)
             figure(3) % atualiza grafico de ocupacao do espaco de fases
             [i1,i2]=find(ps>0);
             plot(i1,i2-pm-1,'.');  axis([1, L, -pm,pm])
             xlabel('x'); ylabel('p');  set(gcf,'Position',[1,10, 300, 200]); drawnow
             
          end    
   end
end % fim do ciclo do tempo
end
