function [ vector ] = adSpots( int,king)
place=1;
if mod(int,8)~=0 && mod(int,8)>4 && int<29
    vector(place)=int+5;
    place=place+1;
elseif mod(int,8)~=0 && mod(int,8)<5 && int<29
    vector(place)=int+4;
    place=place+1;
end
if mod(int,8)~=1 && int<29 && (mod(int,8)>4 || mod(int,8)==0) && int<29
    vector(place)=int+4;
    place=place+1;
elseif mod(int,8)~=1 && mod(int,8)<5 &&int<29
    vector(place)=int+3;
    place=place+1;
end
if king
    if mod(int,8)~=1 && mod(int,8)>4 ||mod(int,8)==0 && int>4
        vector(place)=int-4;
        place=place+1;
    elseif mod(int,8)~=1 && mod(int,8)<5 && int>4
        vector(place)=int-5;
        place=place+1;
    end
    if mod(int,8)~=0 && mod(int,8)>4 && int>4
        vector(place)=int-3;
        place=place+1;
    elseif mod(int,8)~=0 && mod(int,8)<5 && int>4
        vector(place)=int-4;
        place=place+1;
    end
end
end

