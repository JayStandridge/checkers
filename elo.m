function [ elo1, elo2 ] = elo( elo1, elo2, aVal1, k )
aVal2=1-aVal1;
eVal1=(1+10^((elo2-elo1)/400))^-1;
eVal2=1-eVal1;
elo1=elo1+k*(aVal1-eVal1);
elo2=elo2+k*(aVal2-eVal2);
end