function [ aVal1 ] = fight( strat1,strat2,d )
stalemate=50;
board=[1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
%d=2;
displayBoard=0;
if displayBoard
    dispBoard(board,0)
%     h=figure;
%     filename='checkers.gif';
%     frame = getframe(h); 
%     im = frame2im(frame); 
%     [imind,cm] = rgb2ind(im,256); 
%     imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
end
for i=1:stalemate
    %record(i,:)=board;
    board=showMeWhatYouGot(board,strat1,d);
    if displayBoard
        dispBoard(board,0)
        pause(.00001)
%         frame = getframe(h); 
%         im = frame2im(frame); 
%         [imind,cm] = rgb2ind(im,256); 
%         imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end
    if isempty(board(board<0))
        aVal1=1;
        return
    elseif isempty(board(board>0))
        aVal1=0;
        return
    end
    board=switchSides(board);
    board=showMeWhatYouGot(board,strat2,d);
    if displayBoard
        dispBoard(board,1)
        pause(.000001)
%         frame = getframe(h); 
%         im = frame2im(frame); 
%         [imind,cm] = rgb2ind(im,256); 
%         imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    if isempty(board(board<0))
        aVal1=0;
        return
    elseif isempty(board(board>0))
        aVal1=1;
        return
    end
    board=switchSides(board);
end
aVal1=0.5;
end