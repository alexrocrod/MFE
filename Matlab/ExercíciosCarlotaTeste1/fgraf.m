function fgraf(x,y,L,px,py)
% objetivo da função é fazer um gráfico
ret=[0,L,L,0,0;0,0,L,L,0];
plot(x,y,'o', ret(1,:),ret(2,:),'k-')
hold on
quiver(x,y,px,py, 0.2,'r')
axis equal
axis([-0.5, L+0.5,-0.5,L+0.5]);
hold  off
drawnow
end