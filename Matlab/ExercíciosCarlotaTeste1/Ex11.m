%% a) Matriz de transição de prob. para a cadeia de Markov
close all; clear all;

N = 20;
PI = zeros(N+1,N+1);

for N1=0:N
    if N1>0 && N1<N
        PI(N1,N1+1)=N1/N;
        PI(N1+2,N1+1)=1-N1/N;
    end
    PI(2,1)=1;
    PI(N,N+1)=1;
end

%% b)
%clear all;

[V,D] = eig(PI);        % V -> matriz com os vetores próprios
                        % D -> valores próprios na diagonal
v_prop = diag(D);       % matriz coluna com os valores próprios
[v_prop,is] = sort(v_prop,'descend');   % ordena os valores próprios
V = V(:,is);
pst=V(:,1)/sum(V(:,1));  % normalização
N1=0:N;
ps_t=factorial(N)./(factorial(N1).*factorial(N-N1))*2^(-N);
plot(N1,pst,'r*',N1,ps_t,'k.')
xlabel('N1'); ylabel('p_(st)')

%% c) Simulação de Monte Carlo
close all; clear all

tmax=10000;
N=30;
N1=zeros(1,tmax);
N1(1)=N;
tdesp=500; %vamos desprezar os primeiros 100

for t=1:tmax
    pd = N1(t)/N;       % prob. de diminuir
    pa = 1-N1(t)/N;     % prob. de aumentar
    if rand()<=pd
        N1(t+1)=N1(t)-1;
    else
        N1(t+1)=N1(t)+1;
    end
end

t=0:tmax;
figure(1)
plot(t,N1,'k-')
xlabel('t'); ylabel('N1(t)')

n1=0:N;
[h]=hist(N1(tdesp:end),n1);
h=h/sum(h);
ps_t=factorial(N)./(factorial(n1).*factorial(N-n1))*2^(-N);
figure(2)
plot(n1,h,'x',n1,ps_t,'r-');
xlabel('N1'); ylabel('h_n(N1)')

%% d)
close all; clear all

tmax=100;
N=30;
nreal=100;
N1 = zeros(1,tmax);
N1(1)=1;
N1_med=zeros(tmax+1,1);

for real=1:nreal
    N1(1)=N;
    N1_med(1)=N1_med(1)+N1(1);
    for t=1:tmax
        pd = N1(t)/N;       % prob. de diminuir
        pa = 1-N1(t)/N;     % prob. de aumentar
        if rand()<=pd
            N1(t+1)=N1(t)-1;
        else
            N1(t+1)=N1(t)+1;
        end
        N1_med(t+1)=N1_med(t+1)+N1(t+1);
    end
    figure(2)
    plot(0:tmax,N1,'k-')   
    hold on
end

t=0:tmax;
N1_med=N1_med/nreal;        %média sobre as realizações
N1_med_t=N/2+(N-N/2)*exp(-t*log(1/(1-2/N)));
figure(1)
plot(t,N1_med,'kx',t,N1_med_t,'r-')
xlabel('t'); ylabel('N1(t)')
