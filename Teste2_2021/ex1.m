% ex 1 do teste 23/6/21 MFE
% Alexandre Rodrigues 92993

clear all
close all

kb=1.38e-23;
beta=1/(kb*200);
g = 9.8;
m = 16 * 1.66e-27;

npassos=1e6; nequi=1e5;

[h,hh,ht,Et]=mc(npassos,nequi,beta);

Em=mean(Et);
hm=mean(ht);

fprintf(1,'<E>=%f, <h>=%f\n', Em, hm)

hst=linspace(hh(1),hh(end),numel(hh)*10);
Pst=beta*m*g.*exp(-beta*m*g.*hst);
Pst=Pst./(sum(Pst)*(hst(2)-hst(1)));

figure(1)
plot(hh,h,'k.',hst,Pst,'r-'); 
xlabel('x'); ylabel('p(x)')
ylim([0,0.0001])

function [h,hh,ht,Et]=mc(npassos,nequi,beta)
    h=0; 
    delta=10*1e3; %m
    E=energia(h);
    
    nm=0;
    
    ht=zeros(npassos-nequi,1);
    Et=zeros(npassos-nequi,1);    
    
    for t=1:npassos
        %hn = max(0, h + delta*(rand(1)-0.5));
        
        %hn = h + delta*(randn(1)-0.5);
        dh = (rand(1) * (- delta)) + delta / 2;
        hn=h+dh;
        if hn<0
            continue
        end
        
        
        En = energia(hn);
        dE = En-E;
        
        if rand(1) < min(1,exp(-dE*beta))
            h=hn;
            E=En;
        end

        if t> nequi
            nm=nm+1;
            ht(nm)=h;
            Et(nm)=E;
        end
    end
    
    hh=0:1:2e5;
    [h]=hist(ht,hh);
    h=h/(sum(h)*(hh(2)-hh(1)));
end

function [E]=energia(h)
g = 9.8;
m = 16 * 1.66e-27;
E= m * g * h;
end