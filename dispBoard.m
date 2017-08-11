function [  ] = dispBoard( board, turn )
clf
grid on
if turn==1
    board=switchSides(board);
end
hold on
axis square
for i=1:32
    x=-.8+.4*(mod(i-1,4))+(mod(i-1,8)>3)*.2;
    y=-.8+.2*floor((i-1)/4);
    if board(i)==0
    elseif board(i)==1
        plot(x,y,'or','markersize',20,'markerfacecolor','red')
    elseif board(i)==-1
        plot(x,y,'ok','markersize',20,'markerfacecolor','black')
    elseif board(i)==1.5
        plot(x,y,'dr','markersize',20,'markerfacecolor','red')
    elseif board(i)==-1.5
        plot(x,y,'dk','markersize',20,'markerfacecolor','black')
    end
end
axis([-.8 .6 -.8 .6])
hold off
end
