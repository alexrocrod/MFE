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

beta_nu_esperado=(5/36)/nu;

figure(7)
y8=Pinf8/(8^(-beta_nu_esperado)); x8=8./(abs(p-pc).^(-nu));
y16=Pinf16/(16^(-beta_nu_esperado)); x16=16./(abs(p-pc).^(-nu));
y32=Pinf32/(32^(-beta_nu_esperado)); x32=32./(abs(p-pc).^(-nu));
y64=Pinf64/(64^(-beta_nu_esperado)); x64=64./(abs(p-pc).^(-nu));


loglog(x8,y8,'+',x16,y16,'x',x32,y32,'s',x64,y64,'d')
xlabel('x=L/csi'); ylabel('H(x)=P_{inf} L^{beta/nu}')

