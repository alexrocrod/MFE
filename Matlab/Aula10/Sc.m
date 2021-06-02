clear all
close all
n=1e3;
i=0;
cv=0.5:0.1:3;
for c=cv
 i=i+1;   
[listav,nv, S(i), comp]=rede_aleatoria(n,c);

end
plot(cv, S, 'rx')
xlabel('c'); ylabel('S')
