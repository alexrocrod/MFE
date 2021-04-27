function [Emed,EDmed]=Osciladores_quanticos(E0,npassos,nequi)

N = 40; % numero de osciladores
nmax = N;
n = 0:nmax;

%delta = sqrt(2*E0/(10*N));

ED = E0;
E = N/2;

Emed = 0;
EDmed=0;

for t=1:npassos
    for k=1:N
        % escolher um oscilador
        ip = randi(N,1);
        % escolher e aumentar ou diminuir com igual probabilidades
        dE=rand(1)*ip;
        
        na=rand(1);
        if na <= 0.5
            if n(ip)>=1
                n(ip) = n(ip)-1;
                dE=-rand(1)*ip;
                E=E+dE;
                ED=ED-dE;
            else
                if dE<=ED
                    n(ip) = n(ip)+1;
                    dE=rand(1)*ip;
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

figure(3)
tv=1:npassos;
plot(tv,EDt,'k.')
xlabel('t');
ylabel('ED(t)');
%axis([0 npassos 0 50])

end