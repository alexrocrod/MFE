function [x1,hn,Emedio]=metropolis(T,nequi,npassos)

% valores de x
xh=-2:0.05:2;
N=length(xh);

E=0;
Emedio=0;
nmedidas=npassos-nequi;

dx0=0.5;

% valores para fazer o histograma
nbins=10;
y=0.2*xh-xh.^2+2*xh.^4;

for t=1:npassos
    for act=1:N
        % selecionar posição inicial
        ip=randi(N,1);
        % posição a alterar
        x=xh(ip); 
        % variação
        dx = (2*rand(1)-1)*dx0/2;
        xf=x+dx;
        
        % Calculo da energia
        Ei = 0.2*x - x^2 + 2*x^4;
        Ef = 0.2*xf - xf^2 + 2*xf^4;
        % Variação da Energia
        dE=Ef-Ei;
        
        pA = min([ 1, (x*(xf + 1) * exp(-dE/T)) / (xf*x) ]);
        if rand(1)<pA
            E=E+dE;
            xh(ip)=xf;
            %x=xf;
        end
    end
    if t>nequi
        Emedio=Emedio+E;
    end
end
Emedio=Emedio/nmedidas;

% Histograma
[h,x1] = hist(y,nbins);
xmax = max(x1);
xmin = min(x1);
dx1 =(xmax-xmin)/nbins;
hn = h/(N*dx1);
end
