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
gama_nu_esperado=(43/18)/nu;

figure(6)
y8=S8/(8^(gama_nu_esperado)); x8=8./(abs(p-pc).^(-nu));
y16=S16/(16^(gama_nu_esperado)); x16=16./(abs(p-pc).^(-nu));
y32=S32/(32^(gama_nu_esperado)); x32=32./(abs(p-pc).^(-nu));
y64=S64/(64^(gama_nu_esperado)); x64=64./(abs(p-pc).^(-nu));


loglog(x8,y8,'+',x16,y16,'x',x32,y32,'s',x64,y64,'d')
xlabel('x=L/csi'); ylabel('G(x)=S L^{-gama/nu}')

