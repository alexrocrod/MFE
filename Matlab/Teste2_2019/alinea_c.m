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

S8pc=interp1(p,S8,pc,'spline');
S16pc=interp1(p,S16,pc,'spline');
S32pc=interp1(p,S32,pc,'spline');
S64pc=interp1(p,S64,pc,'spline');
figure(4)
Lv=[8,16,32,64];
Spc=[S8pc,S16pc,S32pc,S64pc];
a=polyfit(log(Lv),log(Spc),1);
x1=[log(8),log(64)];
plot(log(Lv),log(Spc),'+',x1,a(1)*x1+a(2),'-')
xlabel('log L'); ylabel('log(S_{max}(p_c))')
gama_nu=a(1);
gama_nu_esperado=(43/18)/nu;
fprintf('gama/nu obtido=%f, gama/nu esperado=%f\n',-a(1),gama_nu_esperado)
