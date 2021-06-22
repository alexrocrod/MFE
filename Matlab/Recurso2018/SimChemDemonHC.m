function [Edt,Ndt]=SimChemDemonHC(teq,tmax,L,N,E)
pm=ceil(sqrt(E));
jmax=2*pm+1;
ps=zeros(L,jmax);
x=zeros(L,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p0=ceil(sqrt(E/N)); 
Es=0;
N0=floor(E/(p0*p0));

for k=1:N0
    ix=randi(L);
    jp0=(2*(randi(2)-1)-1)*p0+pm+1;
    cond=x(ix)>0;
    
    while(cond)
    ix=randi(L);
   jp0=(2*(randi(2)-1)-1)*p0+pm+1;
    cond=x(ix)>0;
    end
    ps(ix,jp0)=1;
    x(ix)=x(ix)+1;
    Es=Es+p0*p0;
end

Nd=N-N0;
Ed=E-Es;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
          [i1,i2]=find(ps>0);
          plot(i1,i2-pm-1,'.');  axis([1, L, -pm,pm])
          xlabel('x'); ylabel('p');  set(gcf,'Position',[1,10, 300, 200]); drawnow
for t=1:teq+tmax
    for ip=1:N
         ix=randi(L);
         jp=randi(2*pm+1);
         Ep=(jp-pm-1)^2;
    
      
       if ps(ix,jp)==0
       
           if (Nd>0 && Ep<=Ed && x(ix)==0)
              Ed=Ed-Ep;                
              x(ix)=x(ix)+1; 
              Nd=Nd-1;
              ps(ix,jp)=1;
           end
       else
           Nd=Nd+1;
           Ed=Ed+Ep;
           ps(ix,jp)=0;
           x(ix)=x(ix)-1;
       end
    end   
          
   if t>teq   
          Ndt(t-teq)=Nd; Edt(t-teq)=Ed; 
          if(mod(t,tmax/100)==0)
             fprintf(' t=%f\n',t)
             figure(3)
             [i1,i2]=find(ps>0);
             plot(i1,i2-pm-1,'.');  axis([1, L, -pm,pm])
             xlabel('x'); ylabel('p'); set(gcf,'Position',[1,10, 300, 200]); drawnow
          end    
   end
end
end
