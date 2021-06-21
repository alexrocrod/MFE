function [Fluxo,erroF,pressao,erroP]=fex31(N,T,Nestados)
% Fluxo --> nº de particulas que saem por unidade de área e intervalo de
% tempo

% dados da abertura
dr=0.01;       
dA=pi*dr^2;
dt=0.01; % Intervalo de tempo 
r=zeros(N,3); % posições das particulas a 3D
v=zeros(N,3);   % velocidades a 3D
Fluxo=0;
erroF=0;
pressao=0;
erroP=0;
A=1;
% gerar Nestados
for n=1:Nestados
    % gerar posições
    r(:,1:2)=rand(N,2)-0.5; % coordenadas x e y [-1/2;1/2]
    r(:,3)=rand(N,1)-1;     % coordenadas z [-1;0]
    % gerar velocidades
    % podemos fazer desta maneira porque é um gás ideal (as coordenadas têm distribuição uniforme)
    % em qualquer gás as velocidades têm a distribuição de velocidades de
    % Maxwell --> ver expressão nos slides
    v=randn(N,3)*sqrt(T);   % geramos v com a distribuição de velocidades de Maxwell com variância proporcional à temperatura
    
    % no intervalo de tempo dt as particulas movem-se
    rn=r+v*dt; % as particulas moveram-se uniformemente
    % determinamos agora quais são as particulas que saem da caixa pela
    % abertura
    condicao_saida=(rn(:,3)>0) & (sqrt(rn(:,1).^2+rn(:,2).^2)<dr);
    condicao=rn(:,3)>0; % aqui consideramos todas as particulas que batem na parede
    numero=sum(condicao_saida); % nº de particulas que saem
    %a)
    Fluxo=Fluxo+numero/(dA*dt);
    erroF=erroF+(numero/(dA*dt))^2;
    %b)
    Forca=-sum(-2*v(condicao,3)/dt);  % Força exercida na parede
    pressao=pressao+Forca/A;
    erroP=erroP+(Forca/A)^2;
end
Fluxo=Fluxo/Nestados; % media do Fluxo
erroF=erroF/Nestados; % media do Fluxo ao quadrado
erroF=sqrt((erroF-Fluxo^2)/Nestados);
pressao=pressao/Nestados;
erroP=erroP/Nestados;
erroP=sqrt((erroP-pressao^2)/Nestados);


end
