function [Emed,EDmed]=Osciladores_classicos_2(E0,npassos,nequi)

N = 40;
p = zeros(N,1);
x = zeros(N,1);
delta = sqrt(2*E0/(10*N));

ED = E0;
E = (1/2)*(x.^2+p.^2); %Hamiltoniano

Emed = 0;
EDmed=0;

for t=1:npassos
    for i=1:N
        
        ip = randi(N,1);
        dp = (2*rand(1)-1)*delta;
        dx = (2*rand(1)-1)*delta;
        dE = dot(p(ip,:),dp)+0.5*norm(dp)^2+dot(x(ip,:),dx)+0.5*norm(dx)^2;   % ver código e apontamentos do ex 27
        
        na=rand(1);
        if na <= 0.5
            if dE <=0 % aceitar a perturbação
                p(ip,:)=p(ip,:)+dp;
                x(ip,:)=x(ip,:)+dx;
                E=E+dE;
                ED=ED-dE;
            else
                if dE<ED
                    p(ip,:)=p(ip,:)+dp;
                    x(ip,:)=x(ip,:)+dx;
                    E=E+dE;
                    ED=ED-dE;
                end  
            end 
        end
        
    end
    EDt(t) = ED;
    
    if t>nequi
        EDmed=EDmed+ED;
        Emed=Emed+E0-ED;
    end
    
end %end t
Emed=Emed/npassos;
EDmed=EDmed/npassos;

figure(1)
tv=1:npassos;
plot(tv,EDt,'k.')
xlabel('t'); 
ylabel('ED(t)');
%axis([0 npassos 0 50])

end