%faz graficos a partir de dados gravados no ficheiro matlab.mat
% para L=8, 16, 32
clear all
close all
load matlab
L=8; N=L^2;
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

figure(1)
plot(Tv, Emed16/N, 'x')

figure(2)
plot(Tv, Cv16/N, 'x')

figure(3)
plot(Tv, Mmed16/N, 'x')

figure(4)
plot(Tv, Susc16/N, 'x')

L=32; N=L^2;

figure(1)
plot(Tv, Emed32/N, 'x')

figure(2)
plot(Tv, Cv32/N, 'x')

figure(3)
plot(Tv, Mmed32/N, 'x')

figure(4)
plot(Tv, Susc32/N, 'x')

