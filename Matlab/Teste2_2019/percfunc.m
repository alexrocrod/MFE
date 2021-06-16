function [ns,S,Pinf,lab_percolativo] = percfunc(L, p)
N=L*L;

[lv,k]=listv_sem_cfp(L);
s=double(rand(N,1)<p);
[ label] = agregados( lv,k,s );
labuni=unique(label);
nagr=length(labuni);

% determinar se existe agregado percolativo
agregado_percolativo=false;
liga_updown=false;
liga_downright=false;
liga_downleft=false;
lab_percolativo=0;

for i=1:L % primeira linha
    if s(i)==1;
    for j=N-L+1:N
        if label(i)==label(j);
            liga_updown=true;
        end
    end
     for j=1:L:N-L+1
         if label(i)==label(j);
            liga_downleft=true;
         end
     end
     for j=L:L:L*L
         if label(i)==label(j);
            liga_downright=true;
         end
     end
    agregado_percolativo=liga_updown && liga_downleft && liga_downright;
    if agregado_percolativo
     lab_percolativo=label(i); 
     break;
    end
    end
end

ns=zeros(N,1);
for agr=1:nagr
    lab=labuni(agr);
    if (lab ~=lab_percolativo) % excluimos o agregado percolativo
    s=sum(label==lab);
    ns(s)=ns(s)+1;
    end
end
ns=ns/N;
Pinf=0;
if  agregado_percolativo
Pinf=sum(label==lab_percolativo);
Pinf=Pinf/N;
end
sv=1:N;
S=sv.^2*ns;

end

