function [niv,t]=ex3a(N,p,g, npassos)
[lv]=listaviz(N);
s=double(rand(N,1)<=p);
dt=1/2; 
niv=zeros(npassos+1,1); niv(1)=sum(s); ni=niv(1);

t=zeros(npassos+1,1);

for n=1:npassos
    for a=1:N
        i=randi(N,1); 
        if s(i)==0
            nvi=sum(s(lv(i,:)));
            pr=nvi/2;
            if rand(1) <= pr
                s(i)=1; ni=ni+1;
            end
        else
            pr=g*0.5;
            if rand(1) <= pr
                s(i)=0; ni=ni-1;
            end
        end
       
    end
    
    niv(n+1)=ni; t(n+1)=t(n)+dt;
    
end

end

function [lv]=listaviz(N)
lv=zeros(N,2);
for i=1:N
    lv(i,1)=i+1; lv(i,2)=i-1; 
end
lv(N,1)=1; lv(1,2)=N;
end