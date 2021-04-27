function [Emedio,Edmedio]=Oscialadores_quanticos(E0,npassos,nequi)
E=E0;
Ed=0;
N=40;

v=zeros(N,1);
dp=v;
x=zeros(N,1);
dx=x;
nq=zeros(N,1);
nq1=zeros(N,1);

nmedidas = npassos;
npassos = nequi + nmedidas;
Edmedio=0; Emedio=0; 
Edt=zeros(npassos,1);

c=0;
c1=0;
for t=1:npassos
    for k=1:N
        a=ceil(rand()*N);
        if rand()<=0
            if nq(a)>=1
                nq(a)=nq(a)-1;
                dE=N/2+sum(nq);
                E=E+dE;
                ED=ED-dE;
            end
        else
        dE=N/2+sum(nq); % energia necessária para criar fotão
        if Ed>=dE
            nq(a)=nq(a)+1;
            E=E+dE;
            ED=ED-dE;
        end
    end
    end
    Edt(t)=Ed;
    T(t)=1/log10(1+sqrt(Ed));
    if t>nequi
        Edmedio=Edmedio+Ed;
        Emedio=Emedio+E0-Ed;
    end
end

Edmedio=Edmedio/nmedidas
Emedio=Emedio/nmedidas

figure(1)
plot(1:npassos,Edt,'k.',1:npassos,E,'r.')
xlabel('t')
ylabel('<Ed>')
end