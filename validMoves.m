function [ outcomes ] = validMoves( board )
place=1;
clear outcomes
outcomes=[];
pieces=find(board>0);
for i=1:length(pieces)
    if board(pieces(i))==1.5
        king=true;
    else
        king=false;
    end
    adspots=adSpots(pieces(i),king);
    for j=1:length(adspots)
        if board(adspots(j))==0
            tempboard=board;
            tempboard(adspots(j))=tempboard(pieces(i));
            tempboard(pieces(i))=0;
            tempboard(33)=0;
            outcomes(place,:)=tempboard;
            place=place+1;
        end
    end
    jspot=jSpots(pieces(i),king);
    for j=1:length(jspot)
        aspot=floor((jspot(j)-pieces(i))/2)+pieces(i)+(mod(pieces(i)-1,8)>3);
        if jspot(j)~=0 && board(jspot(j))==0 && board(aspot)<0
            tempboard=board;
            tempboard(jspot(j))=tempboard(pieces(i));
            tempboard(aspot)=0;
            tempboard(pieces(i))=0;
            tempboard(33)=1;
            outcomes(place,:)=tempboard;
            place=place+1;
            kspot=jSpots(jspot(j),king);
            for k=1:length(kspot)
                aspot=floor((kspot(k)-jspot(j))/2)+jspot(j)+(mod(jspot(j)-1,8)>3);
                if kspot(k)~=0 && tempboard(kspot(k))==0 && tempboard(aspot)<0
                    tempboard2=tempboard;
                    tempboard2(kspot(k))=tempboard2(jspot(j));
                    tempboard2(aspot)=0;
                    tempboard2(jspot(j))=0;
                    tempboard2(33)=1;
                    outcomes(place,:)=tempboard2;
                    place=place+1;
                    lspot=jSpots(kspot(k),king);
                    for l=1:length(lspot)
                        aspot=floor((lspot(l)-kspot(k))/2)+kspot(k)+(mod(kspot(k)-1,8)>3);
                        if lspot(l)~=0 && tempboard2(lspot(l))==0 && tempboard2(aspot)<0
                            tempboard3=tempboard2;
                            tempboard3(lspot(l))=tempboard3(kspot(k));
                            tempboard3(aspot)=0;
                            tempboard3(kspot(k))=0;
                            tempboard3(33)=1;
                            outcomes(place,:)=tempboard3;
                            place=place+1;
                        end
                    end
                end
            end             
        end
    end
    
end
if sum(board<0)==0
    outcomes='w';
    return
end
if isempty(outcomes)
    outcomes='l';
    return
end
for i=1:size(outcomes,1)
    for j=29:32
        if outcomes(i,j)==1
            outcomes(i,j)=1.5;
        end
    end
end
if sum(outcomes(:,33))>0
    outcomes(outcomes(:,33)==0,:)=[];
end
outcomes(:,33)=[];
end