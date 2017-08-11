function [  ] = fightAI( strat )
board=[1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
d=6;
playing=true;
dispBoard(board,0);
while playing
    user=input('Make your move:\n(enter "0" to forfeit)\n');
    if user==0
        point=2+.5*tanh(sum(board))^5;
        fprintf('Its a tie, you recieve %1.2f points!\n',point)
        return
    end
    tempboard=board;
    branches=validMoves(board);
    userEnd=length(user);
    tempboard(user(1:userEnd-1))=0;
    tempboard(user(userEnd))=board(user(1));
    for i=1:size(branches,1)
        if tempboard==branches(i,:)
            board=branches(i,:);
            dispBoard(board,0)
        end
    end
    if tempboard~=board
        disp('invalid move. Try again.\n');
        continue
    end
    if isempty(board(board<0))
        fprintf('You Win! Your receive 4 points!\n')
        return
    elseif isempty(board(board>0))
        fprintf('You lose! Your receive 0 points!\n')
        return
    end
    board=switchSides(board);
    board=showMeWhatYouGot(board, strat, d);
    dispBoard(board,1)
    board=switchSides(board);
    if isempty(board(board<0))
        fprintf('You Win! Your receive 4 points!\n')
        return
    elseif isempty(board(board>0))
        fprintf('You lose! Your receive 0 points!\n')
        return
    end
end
end
