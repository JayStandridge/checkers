function [ board ] = showMeWhatYouGot( board, strat, d )
clear branches
branches=validMoves(board);
if branches(1)>100
    return
end
for i =1:size(branches,1)
    tempBoard=branches(i,:);
    for j=1:2:d
        tempBoard=switchSides(tempBoard);
        tempBranch=validMoves(tempBoard);
        if tempBranch(1)>100
            if tempBranch=='w'
                path(i,j)=-1;
            elseif tempBranch=='l'
                path(i,j)=1;
            end
            continue
        end
        for k=1:size(tempBranch,1)
            tempBranch(k,:)=switchSides(tempBranch(k,:));
            val(k)=evaluate(tempBranch(k,:),strat);
        end
        path(i,j)=min(val);
        tempBoard=tempBranch(find(val==min(val),1),:);
        tempBranch=validMoves(tempBoard);
        clear val
        if isa(tempBranch,'char')
            if tempBranch=='w'
                path(i,j+1)=1;
            elseif tempBranch=='l'
                path(i,j+1)=-1;
            end
            continue
        end
        for k=1:size(tempBranch,1)
            val(k)=evaluate(tempBranch(k,:),strat);
        end
        path(i,j+1)=max(val);
        tempBoard=tempBranch(find(val==max(val),1),:);
        clear val
    end
end
point=find(path==max(max(path)),1);
point=mod(point,size(branches,1));
if point==0
    point=size(branches,1);
end
board(:)=branches(point,:);
end