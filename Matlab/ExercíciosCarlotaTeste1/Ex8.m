%% Exercício 8 
close all; clear all; clc 
%a)
a = 1;
q = 0.5; % probabilidade de a
M = 100; %nº de realizações
nmax = 100;
Xn(1)=0;    %posição inicial da particula

for i=1:M
    for n=1:nmax
        u=rand(1);
        if u<=q
            S=a;
        else
            S=-a;
        end
        Xn(n+1)=Xn(n)+S;
    end
    plot(0:nmax,Xn)
    xlabel('n'); ylabel('Xn');
    hold on
end

%% c)

close all; clear all

a = 1;
q = 0.5;                % probabilidade de a
M = 100;                %nº de realizações
nmax = 100;
nbins = 10;
xmed=zeros(1,nmax);
Xn=zeros(1,M);          %posição inicial de todas as realizações

for n=1:nmax            %todos os passos
    for ir=1:M          %todas as realizações
        u=rand(1);
        if u<=q
            S=a;
        else
            S=-a;
        end
        Xn(ir)=Xn(ir)+S;    %nova posicao da realizao ir da trajetoria
    end
    xmed(n)=sum(Xn)/M;      % a media da posicao sobre todas as realizacoes no instante n
    
    % fazer o histograma de 10 em 10 passos
    if (mod(n,10)==0)
        [h,x]=hist(Xn,nbins); 
        xmax=max(x); 
        xmin=min(x);
        dx=(xmax-xmin)/(nbins-1);
        hn=h/sum(h)/dx;
        VarX=4*q*(1-q)*a^2*n;   % Variancia --> enunciado
        Xmt=(2*q-1)*a*n;        % valor médio --> enunciado
        xx=xmin:(xmax-xmin)/200:xmax;
        pteorico=1/sqrt(2*pi*VarX) *exp(-(xx-Xmt).^2/(2*VarX)); %esperado para n grande
        figure(1)
        plot(x,hn,'kx',xx,pteorico,'r-')
        xlabel('x') ; ylabel('p(x,n)')
        hmax=max(hn);
        text(2*xmax/3,2*hmax/3,['n=' num2str(n)]);
        drawnow
        pause(3)
    end
end

figure(2)
n=1:nmax;
Xmt=(2*q-1)*a*n;
plot(n,xmed,'k.',n,Xmt,'r-')
xlabel('n')
ylabel('Xm(n)')

    



