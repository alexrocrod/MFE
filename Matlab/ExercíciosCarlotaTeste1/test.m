close all; clear all;

N = 15;
nmax = 10;
A = zeros(N,nmax);
n = 0:nmax;
for i=1:nmax+1
    A(:,i) = n(i); 
end

A