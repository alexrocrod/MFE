clear all
close all
load dadosL8_10000_40000
N8=N; mag8=mmed/N8; susc8=susc/N8;
load dadosL16_10000_40000
N16=N; mag16=mmed/N16; susc16=susc/N16;
load dadosL32_10000_40000
N32=N; mag32=mmed/N32; susc32=susc/N32;
load dadosL64_10000_40000
N64=N; mag64=mmed/N64; susc64=susc/N64;

% susceptibilidade
xi8=linspace(2.3,2.7,1000);
yi8=interp1(Tv,susc8,xi8,'spline');
[myi8,i]=max(yi8);
Tm8=xi8(i);
xi16=linspace(2,2.8,1000);
yi16=interp1(Tv,susc16,xi16,'spline');
[myi16,i]=max(yi16);
Tm16=xi16(i);

xi32=linspace(2,2.8,1000);
yi32=interp1(Tv,susc32,xi32,'spline');
[myi32,i]=max(yi32);
Tm32=xi32(i);

xi64=linspace(2,2.8,1000);
yi64=interp1(Tv,susc64,xi64,'spline');
[myi64,i]=max(yi64);
Tm64=xi32(i);

figure(1)
plot(Tv,susc8,'o',Tv,susc16,'x',Tv, susc32, '+',Tv, susc64,'s',xi8,yi8,'r-',Tm8,myi8,'ko',...
    xi16,yi16,'r-',Tm16,myi16,'kx',xi32,yi32,'r-',Tm32,myi32,'k+',xi64,yi64,'r-',Tm64,myi64,'ks')
axis([2,3,0,75])
xlabel('T'); ylabel('chi_L')
pause(5)

figure(2)
plot(Tv,mag8,'o',Tv,mag16,'x',Tv, mag32, '+',Tv, mag64,'s')

pause(5)
xlabel('T'); ylabel('m_L')
i=find(Tv==Tc);
mTc=[mag8(i), mag16(i), mag32(i),mag64(i)];
Ls=[8,16,32,64];
a=polyfit(log(Ls(1:4)), log(mTc(1:4)),1);
xr=[1.8,4.5]; yr=a(1)*xr+a(2);

figure(3)

plot(log(Ls), log(mTc),'+',xr,yr,'r-')
xlabel('log L'); ylabel('log( m(Tc)  )')
fprintf(1,'declive=%f valor esperado (-beta/nu)=%f\n',a(1),-1/8)

figure(4)
susc_max=[myi8,myi16,myi32,myi64];
a=polyfit(log(Ls(1:4)), log(susc_max(1:4)),1);
xr=[1.8,4.5]; yr=a(1)*xr+a(2);
plot(log(Ls(1:4)), log(susc_max),'+',xr,yr,'r-')
xlabel('log L'); ylabel('log( chi_{max})')
fprintf(1,'declive=%f valor esperado (gama/nu)=%f\n',a(1),7/4)

figure(5)
% assumir nu=1;
TmL=[Tm8,Tm16,Tm32, Tm64];
a=polyfit(1./Ls(1:4),TmL,1);
xr=[0,0.15]; yr=a(1)*xr+a(2);
plot(1./Ls(1:4),TmL,'o',xr,yr,'r-')
xlabel('1/L^{nu}'); ylabel('Tm(L)')
fprintf(1,'o.o.=%f valor esperado (Tc)=%f\n',a(2),2/log(1+sqrt(2)));

figure(1)
gama=7/4; nu=1;
s8=susc8*8^(-gama/nu); x8=8*(Tv-Tc).^nu;
s16=susc16*16^(-gama/nu); x16=16*(Tv-Tc).^nu;
s32=susc32*32^(-gama/nu); x32=32*(Tv-Tc).^nu;
s64=susc64*64^(-gama/nu); x64=64*(Tv-Tc).^nu;

subplot(1,2,1)
semilogy(Tv,susc8,'o',Tv,susc16,'x',Tv, susc32, '+',Tv, susc64,'s')
%axis([1.5,3,0,75])
xlabel('T'); ylabel('chi_L')
subplot(1,2,2)
semilogy(x8,s8,'o',x16,s16,'x',x32, s32, '+',x64, s64,'s')
%axis([-50,50,0,0.05])
xlabel('x=L (T-T_c)^{nu}'); ylabel('Q_{chi}(x)=chi_L L^{-gama/nu}')

figure(2)
beta=1/8; nu=1;
ms8=mag8*8^(beta/nu); x8=8*(Tv-Tc).^nu;
ms16=mag16*16^(1/8); x16=16*(Tv-Tc);
ms32=mag32*32^(1/8); x32=32*(Tv-Tc);
ms64=mag64*64^(1/8); x64=64*(Tv-Tc);
subplot(1,2,1)
plot(Tv,mag8,'o',Tv,mag16,'x',Tv, mag32, '+',Tv, mag64,'s')
xlabel('T'); ylabel('m_L')
subplot(1,2,2)
semilogy(x8,ms8,'o',x16,ms16,'x',x32, ms32, '+',x64, ms64,'s')
xlabel('x=L (T-T_c)^{nu}'); ylabel('Q_m(x)=m_L L^{beta/nu}')



