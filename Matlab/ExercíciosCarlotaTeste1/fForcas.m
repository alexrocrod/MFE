function [Fx,Fy,Epn]=fForcas(L,N,x,y)
Fx=zeros(N,1); 
Fy=zeros(N,1);
% considerar todos pares de particulas
Epn=0;
for i=1:N-1
    for j=i+1:N
        rij=[x(i)-x(j),y(i)-y(j)];
        % condicoes fronteira periodicas
        % consideramos a interação com a imagem mais proxima 
        % da particula j
        if rij(1) >=L/2
            rij(1)=rij(1)-L; % xij relativo à imagem mais proxima da particula j
        end
          if rij(2) >=L/2
            rij(2)=rij(2)-L;
          end
          if rij(1) <=-L/2
            rij(1)=rij(1)+L;
        end
          if rij(2) <=-L/2
            rij(2)=rij(2)+L;
          end
         
        dij=norm(rij);      %distancia
        Fij=48*(dij^(-13)-0.5*dij^(-7)); %modulo
        Fx(i)=Fx(i)+Fij*rij(1)/dij; 
        Fy(i)=Fy(i)+Fij*rij(2)/dij;
        Fx(j)=Fx(j)-Fij*rij(1)/dij; 
        Fy(j)=Fy(j)-Fij*rij(2)/dij;
        Epn=Epn+4*(dij^(-12)-dij^(-6));
        
        end
end
end