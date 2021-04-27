close all;clear all;clc;

n=10^2;
nbins=100;
p=rand(n,1);

r1=(p.*4/9).^1/2;
r2=(1./p*9/4).^1/10;

counter=[0 0];

for i=1:n
    if r2(i)<=1
        r3(i)=r1(i);
        counter(1)=counter(1)+1;
    else
        r3(i)=r2(i);
        counter(2)=counter(2)+1;
    end
end
counter

[h,x]=hist(r3,nbins);
xmax=max(x); xmin=min(x);
dx=(xmax-xmin)/(nbins-1);
hn=h/(n*dx);
plot(x,hn,'-b')
