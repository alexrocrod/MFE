close all
clear all
hold on
L=10;
i=0;
for ix=1:L
    for iy=1:L
        i=i+1;
        x(i)=ix+(iy-1)*cos(pi/3);
        y(i)=(iy-1)*sin(pi/3)+1;
    end
end
plot(x,y,'.','MarkerSize',10)
axis equal
