clear all
close all
N=5;
Pi=zeros(N+1,N+1);

for N1=0:N
    if N1>0 && N1<N
    Pi( N1, N1+1)= N1/N;
    Pi(N1+2,N1+1)=1-N1/N;
    end
    Pi(2,1)=1; Pi(N,N+1)=1;
end
Pi