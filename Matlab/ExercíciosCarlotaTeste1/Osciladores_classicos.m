function [Emed,EDmed]=Osciladores_classicos(E0,npassos,nequi)

N = 40;
nmedidas=npassos-nequi;
p = zeros(N,1);
x = zeros(N,1);
delta = sqrt(2*E0/(10*N))

ED = E0;
% E = E0;
E = (1/2)*(x.^2+p.^2); %Hamiltoniano
Emed = 0;
EDmed=0;

for t=1:npassos
    for i=1:N
        
        ip = randi(N,1);
        dp = (2*rand(1)-1)*delta;
        dx = (2*rand(1)-1)*delta;
        dE = (1/2)*(dp^2+dx^2);
        
        na = rand(1);
        if na<=0.5
            p(ip,:)=p(ip,:)+dp;
            x(ip,:)=x(ip,:)+dx;
            E=E+dE;
            ED=ED-dE;
        end
    end
    EDt(t) = ED;
    
    if t>nequi
        EDmed=EDmed+ED;
        Emed=Emed+E;
    end
    
end %end t
Emed=Emed/nmedidas;
EDmed=EDmed/nmedidas;

figure(1)
tv=1:npassos;
plot(tv,EDt,'.')
xlabel('t');
ylabel('ED(t)');
axis([0 npassos -6000 500])

end