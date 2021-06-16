function [lv,k]=listv_sem_cfp(L)
%sem condicoes fronteira periodicas
N=L*L;
k=zeros(N,1);
lv=zeros(N,4);
for x=1:L
    for y=1:L
        i=(y-1)*L+x;
        x1=x+1 ; y1=y; 
        
        if x1<=L
           i1=(y1-1)*L+x1;
           k(i)=k(i)+1;
           lv(i,k(i))=i1;
        end
        x2=x ; y2=y+1; 
        if y2<=L
           i2=(y2-1)*L+x2;
           k(i)=k(i)+1;
           lv(i,k(i))=i2;
        end
        
        x3=x-1 ; y3=y; 
        if(x3>=1)
        i3=(y3-1)*L+x3;
        k(i)=k(i)+1;
        lv(i,k(i))=i3;
        end
         x4=x; y4=y-1; 
         if(y4>=1)
            i4=(y4-1)*L+x4;
            k(i)=k(i)+1;
            lv(i,k(i))=i4;
        end
     end
end
end
