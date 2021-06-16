clear all
close all
load dadosL8.mat
S8=Smed; p=pv; Pinf8=pinf_med;
load dadosL16.mat
S16=Smed; p=pv;Pinf16=pinf_med;
load dadosL32.mat
S32=Smed; p=pv;Pinf32=pinf_med;
load dadosL64.mat
S64=Smed; p=pv;Pinf64=pinf_med;
pc=0.592746;
nu=4/3;
p1=[pc-0.1:0.0001:pc+0.1];


nu=4/3;

Lv=[8,16,32,64];


P8pc=interp1(p,Pinf8,pc,'spline');
P16pc=interp1(p,Pinf16,pc,'spline');
P32pc=interp1(p,Pinf32,pc,'spline');
P64pc=interp1(p,Pinf64,pc,'spline');

figure(5)
x1=[log(8),log(64)];

%fit1
Pinf=[P8pc,P16pc,P32pc,P64pc];
a=polyfit(log(Lv),log(Pinf),1);
%fit2

Pinf2=[P16pc,P32pc,P64pc];
a2=polyfit(log(Lv(2:4)),log(Pinf2),1);
%fit3

Pinf3=[P32pc,P64pc];
a3=polyfit(log(Lv(3:4)),log(Pinf3),1);

plot(log(Lv),log(Pinf),'+',x1,a(1)*x1+a(2),'-',x1,a2(1)*x1+a2(2),'-',x1,a3(1)*x1+a3(2))
ylabel('log(P_{inf}(p_c))');xlabel('log(L)');



beta_nu_esperado=(5/36)/nu;
fprintf('beta/nu obtido=%f, beta/nu esperado=%f\n',-a(1),beta_nu_esperado)
fprintf('Comentario: \n')
fprintf('Se retirarmos do fit o sistema mais pequeno (L=8) obtemos beta/nu =%f \n',-a2(1))
fprintf('Se retirarmos do fit os dois sistemas mais pequenos (L=8,16) obtemos beta/nu =%f \n',-a3(1))
fprintf('So com sistemas maiores obtemos beta/nu =%f \n',beta_nu_esperado)

