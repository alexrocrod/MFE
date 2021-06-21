clear all
close all
L=8; N=L^2;
Tv=[1.5:0.1:2.1, 2.269, 2.3:0.1:3];
npassos=10^5; nequi=10^4;
i=0;
for T=Tv
    i=i+1;
    fprintf(1,'L=%d, Simulação a T=%f\n',L,T);
[Emed(i), Mmed(i), Cv(i), Susc(i)]=metropolis(npassos, nequi,T,L);

end

figure(1)
plot(Tv, Emed/N, 'x')
xlim([Tv(1),Tv(end)])
hold on
xlabel('T'); ylabel('<E>/N')
figure(2)
plot(Tv, Cv/N, 'x')
xlim([Tv(1),Tv(end)])
hold on
xlabel('T'); ylabel('Cv/N')
figure(3)
plot(Tv, Mmed/N, 'x')
axis([Tv(1), Tv(end), 0, 1])

hold on
xlabel('T'); ylabel('<M>/N')
figure(4)
plot(Tv, Susc/N, 'x')
xlim([Tv(1),Tv(end)])
hold on
xlabel('T'); ylabel('Susc/N')

L=16; N=L^2;
i=0;
for T=Tv
    i=i+1;
    fprintf(1,'L=%d, Simulação a T=%f\n',L,T);
[Emed16(i), Mmed16(i), Cv16(i), Susc16(i)]=metropolis(npassos, nequi,T,L);

end
figure(1)
plot(Tv, Emed16/N, 'x')
hold on

figure(2)
plot(Tv, Cv16/N, 'x')
hold on

figure(3)
plot(Tv, Mmed16/N, 'x')
hold on

figure(4)
plot(Tv, Susc16/N, 'x')
hold on

L=32; N=L^2;
i=0;
for T=Tv
    i=i+1;
    fprintf(1,'L=%d, Simulação a T=%f\n',L,T);
[Emed32(i), Mmed32(i), Cv32(i), Susc32(i)]=metropolis(npassos, nequi,T,L);

end
figure(1)
plot(Tv, Emed32/N, 'x')

figure(2)
plot(Tv, Cv32/N, 'x')

figure(3)
plot(Tv, Mmed32/N, 'x')

figure(4)
plot(Tv, Susc32/N, 'x')

save
