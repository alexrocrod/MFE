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
p1=[pc-0.1:0.0001:pc+0.1];
y=interp1(p,S8,p1,'spline');[S8max,i]=max(y);pm8=p1(i);
y=interp1(p,S16,p1,'spline');[S16max,i]=max(y);pm16=p1(i);
y=interp1(p,S32,p1,'spline');[S32max,i]=max(y);pm32=p1(i);
y=interp1(p,S64,p1,'spline');[S64max,i]=max(y);pm64=p1(i);
figure(1)
plot(p,S8,'+',p,S16,'x',p,S32,'s',p,S64,'d')
ylabel('S'); xlabel('p')
Lv=[8,16,32,64]+300;
nu=4/3;
theta=1+1/nu;
x=Lv.^-theta;
pm=[pm8,pm16,pm32,pm64];
figure(2)
a=polyfit(x(2:4),pm(2:4),1);
x1=[x(1),x(end)];
plot(x,pm,'.',x1,a(1)*x1+a(2),'-')
xlabel('x=(L+L_0)^{-theta}'); ylabel('p_m(L)')
pc_inf=a(2);
fprintf('pc obtido=%f, pc esperado=%f\n',a(2),pc)
fprintf('Comentario:\n')
fprintf('O ajuste deve ser feito sem incluir L=8.\n')
fprintf('O comportamento L^{-theta} so se estabelece para L>> L_0\n')