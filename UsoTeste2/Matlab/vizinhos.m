% Lista 2D periodicas
function [listav, nv]=lista_vizinhos_2D_Peri(nmax)
listav=zeros(nmax^2,4); % guarda o indice dos vizinhos de cada estado
nv=zeros(nmax^2, 1); % guarda o numero de vizinhos de cada estado

for i=1: nmax^2
    nx=mod(i-1,nmax)+1; ny=floor((i-1)/nmax)+1;
    
    nx1=nx+1; ny1=ny; %vizinho1
    if nx1 > nmax
       nx1=1;
    end
    nv(i)=nv(i)+1;
    iv=nx1+nmax*(ny1-1);
    listav(i,nv(i))=iv;
        
    nx2=nx; ny2=ny+1; %vizinho2
    if ny2 > nmax
        ny2=1;  
    end
    nv(i)=nv(i)+1;
    iv=nx2+nmax*(ny2-1);
    listav(i,nv(i))=iv;
    
    nx3=nx-1; ny3=ny; %vizinho3
    if nx3 <1
        nx3=nmax;
    end
    nv(i)=nv(i)+1;
    iv=nx3+nmax*(ny3-1);
    listav(i,nv(i))=iv;
    
    nx4=nx; ny4=ny-1; %vizinho4
    if ny4 <1
        ny4=nmax; 
    end
    nv(i)=nv(i)+1;
    iv=nx4+nmax*(ny4-1);
    listav(i,nv(i))=iv;
end

end

% Lista 3D periodicas
function [listav, nv]=lista_vizinhos_3D_Peri(nmax)
listav=zeros(nmax^3,6); % guarda o indice dos vizinhos de cada estado
nv=zeros(nmax^3, 1); % guarda o numero de vizinhos de cada estado

for i=1: nmax^3
    nz=floor((i-1)/nmax^2)+1;
    ny=floor(mod(i-1,nmax^2)/nmax)+1;
    nx=mod(mod(i-1,nmax^2), nmax)+1;
    
    nx1=nx+1; ny1=ny; nz1=nz; %vizinho1
    if nx1 > nmax
       nx1=1;
    end
    nv(i)=nv(i)+1;
    iv=nx1+(ny1-1)*nmax+(nz1-1)*nmax^2;
    listav(i,nv(i))=iv;
        
    nx2=nx; ny2=ny+1; nz2=nz; %vizinho2
    if ny2 > nmax
        ny2=1;  
    end
    nv(i)=nv(i)+1;
    iv=nx2+(ny2-1)*nmax+(nz2-1)*nmax^2;
    listav(i,nv(i))=iv;
    
    nx3=nx-1; ny3=ny;nz3=nz; %vizinho3
    if nx3 <1
        nx3=nmax;
    end
    nv(i)=nv(i)+1;
    iv=nx3+(ny3-1)*nmax+(nz3-1)*nmax^2;
    listav(i,nv(i))=iv;
    
    nx4=nx; ny4=ny-1;nz4=nz; %vizinho4
    if ny4 <1
        ny4=nmax; 
    end
    nv(i)=nv(i)+1;
    iv=nx4+(ny4-1)*nmax+(nz4-1)*nmax^2;
    listav(i,nv(i))=iv;
    
    nx5=nx; ny5=ny; nz5=nz+1; %vizinho5
    if nz5 >nmax
        nz5=1; 
    end
    nv(i)=nv(i)+1;
    iv=nx5+(ny5-1)*nmax+(nz5-1)*nmax^2;
    listav(i,nv(i))=iv;
    
    nx6=nx; ny6=ny; nz6=nz-1; %vizinho6
    if nz6 <1
        nz6=nmax; 
    end
    nv(i)=nv(i)+1;
    iv=nx6+(ny6-1)*nmax+(nz6-1)*nmax^2;
    listav(i,nv(i))=iv;
end

end

% Lista 2D 
function [listav, nv]=lista_vizinhos(nmax)
nv=zeros(nmax^2,1);
listav=zeros(nmax^2,4);
for ik=1:nmax^2
    nx=mod(ik-1, nmax)+1; ny=floor((ik-1)/nmax)+1;
    % vizinho 1
    nx1=nx+1;  ny1=ny;
    if nx1 <=nmax
        ikv=nx1+(ny1-1)*nmax;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    % vizinho 2
    nx2=nx;  ny2=ny+1;
    if ny2 <=nmax
        ikv=nx2+(ny2-1)*nmax;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    % vizinho 3
    nx3=nx-1;  ny3=ny;
    if nx3 >=1
        ikv=nx3+(ny3-1)*nmax;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    % vizinho 4
    nx4=nx;  ny4=ny-1;
    if ny4 >=1
        ikv=nx4+(ny4-1)*nmax;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    
end

end

% Lista 3D 
function [listav, nv]=lista_vizinhos_3D(nmax)
nv=zeros(nmax^3,1);
listav=zeros(nmax^3,6);
for ik=1:nmax^3
    nz=floor((ik-1)/nmax^2)+1;
    ny=floor(mod(ik-1,nmax^2)/nmax)+1;
    nx=mod(mod(ik-1,nmax^2), nmax)+1;
    
    % vizinho 1
    nx1=nx+1;  ny1=ny; nz1=nz;
    if nx1 <=nmax
        ikv=nx1+(ny1-1)*nmax+(nz1-1)*nmax^2;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    
    % vizinho 2
    nx2=nx;  ny2=ny+1;nz2=nz;
    if ny2 <=nmax
        ikv=nx2+(ny2-1)*nmax+(nz2-1)*nmax^2;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    
    % vizinho 3
    nx3=nx-1;  ny3=ny; nz3=nz;
    if nx3 >=1
        ikv=nx3+(ny3-1)*nmax+(nz3-1)*nmax^2;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    
    % vizinho 4
    nx4=nx;  ny4=ny-1; nz4=nz;
    if ny4 >=1
        ikv=nx4+(ny4-1)*nmax+(nz4-1)*nmax^2;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    
    % vizinho 5
    nx5=nx;  ny5=ny; nz5=nz-1;
    if nz5>=1
        ikv=nx5+(ny5-1)*nmax+(nz5-1)*nmax^2;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    
    % vizinho 6
    nx6=nx;  ny6=ny; nz6=nz+1;
    if nz6<=nmax
        ikv=nx6+(ny6-1)*nmax+(nz6-1)*nmax^2;
        nv(ik)=nv(ik)+1;
        listav(ik,nv(ik))=ikv;
    end
    
end

end