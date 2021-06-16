function [ label] = agregados( lv,k,s )
[N,kmax]=size(lv);
stack=zeros(N,1);
label=zeros(N,1);

verificado=zeros(N,1);
nstack=0;
lab=0;
for i=1:N
    if s(i)==1 && verificado(i)==0
        nstack=nstack+1;
        stack(nstack)=i;
        lab=lab+1;
        label(i)=lab;
       
    end
     while (nstack >0)
         iver=stack(nstack);
         nstack=nstack-1;
         
          for j=1:k(iver)
             ij=lv(iver,j);
             if s(ij) == 1  
                 label(ij)=lab;
          
             if (verificado(ij)==0)
                 nstack=nstack+1;
                 verificado(ij)=1;
                 stack(nstack)=ij;
             end
             end
         end
        
     end
end

end

