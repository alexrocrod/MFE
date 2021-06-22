function [Ninf] = percfunc(L, p)
N=L*L;

[lv,k]=listv_rede_triangular(L);
s=double(rand(N,1)<p);
[ label] = agregados( lv,k,s );
labuni=unique(label); % determina os labels diferentes existentes
nagr=length(labuni); % nagr e' o numero de agregados +1 ( dado 0 ser tambem label)
tamanho=zeros(nagr,1);
for agregado=1:nagr
    if (labuni(agregado)>0) % e necessario excluir o 0 que e' o label de vertices nao ocupados
    tamanho(agregado)=sum(label==labuni(agregado)); 
    end
end

Ninf=max(tamanho); % o tamanho maior


end

