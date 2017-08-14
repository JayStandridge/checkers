function [ Child ] = Mate( Mom, Dad, Bit_Size, Genes_Total, Gene_Range, Array_Size, Mutation_Rate, Mutation_Size )
%MATE Summary of this function goes here
%   Detailed explanation goes here
Child = zeros(1,Array_Size);
for i = 1:Genes_Total
    Mom_Gene = round(((Mom(i)-Gene_Range(i,1))/Gene_Range(i,2))*(2^Bit_Size - 1));
    Dad_Gene = round(((Dad(i)-Gene_Range(i,1))/Gene_Range(i,2))*(2^Bit_Size - 1));
    Mate_Bits = 0;
    %Mutate_Bits = 0;
    Child_Gene = 0;
    for j = 1:Bit_Size
        % Choose the parents genes
        if rand >= .5;
            % Mom passes the trait
            Mate_Bits = bitset(Mate_Bits,j,1);
            Child_Gene = bitset(Child_Gene,j,bitget(Mom_Gene,j));
        else
            % Dad passes the trait
            Mate_Bits = bitset(Mate_Bits,j,0);
            Child_Gene = bitset(Child_Gene,j,bitget(Dad_Gene,j));
        end
        
        
        
    end
    
    Child(1,i) = (Child_Gene/(2^Bit_Size - 1))*Gene_Range(i,2) + Gene_Range(i,1);
    
    % Random Mutation based on Mutation_Rate % chance
    sign = 0;
    if (rand <= Mutation_Rate)
       if rand <= .5
           sign = -1;
       else
           sign = 1;
       end
       
       Child(1,i) = min(max(Child(1,i) + sign*rand*(Mutation_Size)*Gene_Range(i,2),Gene_Range(i,1)),Gene_Range(i,1) + Gene_Range(i,2));
            
    end

end

