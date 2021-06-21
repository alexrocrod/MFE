function [lv,nv]=listv3d_sem_cfp(nmax)
%sem condicoes fronteira periodicas
N=nmax^3; %numero de nodos da grelha
nv=zeros(N,1); % numero de vizinhos de cada nodo
lv=zeros(N,6);% lista de vizinhos de cada nodo

for nx=1:nmax
    for ny=1:nmax
        for nz=1:nmax
            
          ik=(nz-1)*nmax^2+(ny-1)*nmax+nx; % passar de 3 indices para 1 indice
       
         for iv=-1:2:1 % somar -1 ou 1 a nx  
            nx1=nx+iv ; ny1=ny; nz1=nz;% primeiro vizinho
            if nx1<=nmax && nx1 >=1
               ik1=(nz1-1)*nmax^2+(ny1-1)*nmax+nx1; % vizinho do ik
               nv(ik)=nv(ik)+1; % numero de vizinhos aumenta
               lv(ik,nv(ik))=ik1;
            end
         end
         
         for iv=-1:2:1 % somar -1 ou 1 a ny  
             nx1=nx ; ny1=ny+iv; nz1=nz;% primeiro vizinho
             if ny1<=nmax && ny1 >=1
                 ik1=(nz1-1)*nmax^2+(ny1-1)*nmax+nx1; % vizinho do ik
                 nv(ik)=nv(ik)+1; % numero de vizinhos aumenta
                 lv(ik,nv(ik))=ik1;
             end
         end
         
         for iv=-1:2:1 % somar -1 ou 1 a nz 
              nx1=nx ; ny1=ny; nz1=nz+iv;% primeiro vizinho
              if nz1<=nmax && nz1 >=1
                 ik1=(nz1-1)*nmax^2+(ny1-1)*nmax+nx1; % vizinho do ik
                 nv(ik)=nv(ik)+1; % numero de vizinhos aumenta
                 lv(ik,nv(ik))=ik1;
              end 
       end
     end
  end
end
end


