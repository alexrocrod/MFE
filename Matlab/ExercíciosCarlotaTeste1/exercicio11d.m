clear all
close all
tmax=100; N=30;
nreal=100;
N1med=zeros(tmax+1,1);
for real=1:nreal
    N1(1)=N;
    N1med(1)=N1med(1)+N1(1);
        for t=1:tmax
        
        pd=N1(t)/N;%prob de diminuir e´zero
        pa=1-N1(t)/N;%prob de aumentar
         if rand() <=pd
             N1(t+1)=N1(t)-1;
         else
             N1(t+1)=N1(t)+1;
         end
         N1med(t+1)=N1med(t+1)+N1(t+1);
        end
        figure(2)
        plot(0:tmax,N1,'k-')
        hold on
end
N1med=N1med/nreal; % media sobre as realizaçoes

figure(1)
t=0:tmax;
N1med_t=N/2+(N-N/2)*exp(-t*log(1/(1-2/N)));

plot(t,N1med,'kx',t,N1med_t,'r-')
xlabel('t'); ylabel('N1(t)')

             
             