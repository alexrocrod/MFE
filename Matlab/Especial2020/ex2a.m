function [Emedio,E2medio]=ex2a(T ,nequi, nmedidas,N)

n=zeros(N,1); 
E=N/2; %Energia inicial do sistema

Emedio=0; E2medio=0;
npassos=nequi+nmedidas; 
for t=1:npassos
    for act=1:N
        ip=randi(N,1); %Escolhe o oscilador
        % propõe aumentar ou diminuir o seu número quântico
        if rand(1) <= 0.5
            if n(ip) >=1
                % energia diminui e é sempre aceite
                dE=-1;
                n(ip)=n(ip)-1;
                E=E+dE;
            end
        else
            dE=1;
            if rand(1) < exp(-dE/T)
                n(ip)=n(ip)+1;
                E=E+dE;
            end
        end
    end  
    
   if t> nequi
            Emedio=Emedio+E;
            E2medio=E2medio+E^2;
     end
end
Emedio=Emedio/nmedidas;
E2medio=E2medio/nmedidas;
end
