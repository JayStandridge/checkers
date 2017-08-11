function [ board ] = switchSides( board )
if length(board)==1
    return
end
tempBoard=zeros(1,32);
for i =1:32
    tempBoard(i)=board(33-i);
end
board=tempBoard*-1;
end