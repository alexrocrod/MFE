function [x,y,px,py,Ec,Ep]=leapfrog(L,N,npassos, dt, x, y, px, py)
for n=1:npassos
    [Fx,Fy]=fForcas(L,N,x,y);
    x=x+dt*px+0.5*dt^2*Fx;
    y=y+dt*py+0.5*dt^2*Fy;
    % condições fronteira periodicas
    % as que saem por uma parede da caixa entram pela parede oposta.
    x(x>L)=x(x>L)-L; 
    x(x<0)=x(x<0)+L;
    y(y>L)=y(y>L)-L; 
    y(y<0)=y(y<0)+L;
   
    % novas Forï¿½as
    [Flx,Fly, Epn]=fForcas(L,N,x,y);
    px=px+0.5*dt*(Flx+Fx);
    py=py+0.5*dt*(Fly+Fy);
    fgraf(x,y,L,px,py);
    Ec(n)=0.5*sum(px.^2+py.^2);
    Ep(n)=Epn;
end

end 