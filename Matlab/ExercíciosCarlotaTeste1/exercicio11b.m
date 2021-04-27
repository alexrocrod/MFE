clear all
close all
N=20;
Pi=zeros(N+1,N+1);

for N1=0:N
    if N1>0 && N1<N
    Pi( N1, N1+1)= N1/N;
    Pi(N1+2,N1+1)=1-N1/N;
    end
    Pi(2,1)=1; Pi(N,N+1)=1;
end

[V,D]=eig(Pi);
D=diag(D);
[D,is]=sort(D,'descend');
V=V(:,is);
pst=V(:,1)/sum(V(:,1)); %normalizacao
N1=0:N;
pst_t=factorial(N)./(factorial(N1).*factorial(N-N1)) * 2^(-N);
plot(N1,pst,'rx',N1,pst_t,'k.')
xlabel('N1'); ylabel('p_{st}')
