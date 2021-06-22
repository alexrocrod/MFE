function [lv,nv]=listv_rede_triangular(L)
N=L*L;
lv=zeros(N,6);
nv=ones(N,1)*6;
for ix=1:L
    for iy=1:L
        i=ix+(iy-1)*L;
        i1=mod(ix,L)+1+(iy-1)*L; lv(i,1)=i1;
        i2=ix+mod(iy,L)*L; lv(i,2)=i2;
        i3=mod(ix-2,L)+1+mod(iy,L)*L;lv(i,3)=i3;
        i4=mod(ix-2,L)+1+(iy-1)*L;lv(i,4)=i4;
        i5=ix+mod(iy-2,L)*L;lv(i,5)=i5;
        i6=mod(ix,L)+1+mod(iy-2,L)*L;lv(i,6)=i6;
%         x=ix+(iy-1)*cos(pi/3); y=iy;
%         plot(x,y,'.','MarkerSize',10)
%         hold on
%         axis equal
%         drawnow
    end
%     hold off
end
        