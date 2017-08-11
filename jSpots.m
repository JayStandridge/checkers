function [ vector ] = jSpots( int,king)
place=1;
vector=[];
if mod(int,4)~=0 && int<24
    vector(place)=int+9;
    place=place+1;
end
if mod(int,4)~=1 && int<25
    vector(place)=int+7;
    place=place+1;
end
if king
    if mod(int,4)~=1 && int>9
        vector(place)=int-9;
        place=place+1;
    end
    if mod(int,4)~=0 && int>8
        vector(place)=int-7;
        place=place+1;
    end
end
if isempty(vector)
    vector=0;
end
end


