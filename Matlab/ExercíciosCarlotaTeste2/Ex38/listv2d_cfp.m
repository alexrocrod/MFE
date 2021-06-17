function [lv,nv]=listv2d_cfp(nmax)
%sem condicoes fronteira periodicas
N=nmax*nmax; %numero de nodos da grelha
nv=zeros(N,1); % numero de vizinhos de cada nodo
lv=zeros(N,4);% lista de vizinhos de cada nodo

for nx=1:nmax
    for ny=1:nmax
        
        ik=(ny-1)*nmax+nx; % passar de 2 indices para 1 indice
       
        nx1=nx+1 ; ny1=ny; % primeiro vizinho
        %if nx1<=nmax
        if nx1==nmax+1
            nx1=1;  
        end
           ik1=(ny1-1)*nmax+nx1; % vizinho do ik
           nv(ik)=nv(ik)+1; % numero de vizinhos aumenta
           lv(ik,nv(ik))=ik1;
      
        
        nx2=nx ; ny2=ny+1; % segundo vizinho
        if ny2== nmax+1
            ny2=1;
        end
           ik2=(ny2-1)*nmax+nx2; % vizinho do ik
           nv(ik)=nv(ik)+1; % numero de vizinhos aumenta
           lv(ik,nv(ik))=ik2;
  
        
        nx3=nx-1 ; ny3=ny; % terceiro vizinho
        if  nx3 ==0
            nx3=nmax;
        end
           ik3=(ny3-1)*nmax+nx3; % vizinho do ik
           nv(ik)=nv(ik)+1; % numero de vizinhos aumenta
           lv(ik,nv(ik))=ik3;
  
        
        nx4=nx ; ny4=ny-1; % quarto vizinho
        if  ny4 ==0
            ny4=nmax;
        end
        ik4=(ny4-1)*nmax+nx4; % vizinho do ik
           nv(ik)=nv(ik)+1; % numero de vizinhos aumenta
           lv(ik,nv(ik))=ik4;
        
end
end
end
