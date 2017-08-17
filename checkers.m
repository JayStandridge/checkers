load('values.mat');
%load('strat.mat');
%% Make sure to set done=0 if youre starting over
%also run aiGen to generate new data before
generations=80;%how many gens you want to run right now
done=20;
population = 15;
children = 15;
total_pop = population + children;
games=5;%number of opponets an AI will face a generation
d = 6; %number of turns to look ahead
%I update done manually, Im storing the points data and need how many were
%done previously to keep up with the indexes
%%
if done==0
    strat=aiGen(population);
end
Bit_Size      = 32;
Genes_Total   = 5046;
for i = 1:5046
    Gene_Range(i,1) = -0.25;
    Gene_Range(i,2) = 0.5;
end
Array_Size    = 5046;
Mutation_Rate_init = 0.25;
Mutation_Size_init = 0.25;
kVal=32;
%%
record = zeros(population,generations);
eloRecord(1:total_pop,1+done:done+generations)=1000;
eloNow(1:total_pop,1)=1000;
for i=1:generations
    Mutation_Rate = Mutation_Rate_init-Mutation_Rate_init*i/generations;
    Mutation_Size = Mutation_Rate_init-Mutation_Rate_init*i/generations;
    for j =1:children
        tempvar1=1;
        tempvar2=1;
        while tempvar1 == tempvar2
            tempvar1=ceil(population*rand);
            tempvar2=ceil(population*rand);
        end
        Mom = strat(tempvar1,:);
        Dad = strat(tempvar2,:);
        tempStrat=Mate(Mom, Dad, Bit_Size, Genes_Total, Gene_Range, Array_Size, Mutation_Rate, Mutation_Size);
        strat(population + j,:)=tempStrat;
    end
    eloNow(population+1:total_pop)=1000;
    for j=1:total_pop
        count=0;
        for k=1:games
            tempVar3=ceil(total_pop*rand);
            while tempVar3 == j
                tempVar3=ceil(total_pop*rand);
            end
            aVal1=fight(strat(j,:),strat(tempVar3,:),d);
            count=count+1;
            [eloNow(j),eloNow(tempVar3)]=elo(eloNow(j),eloNow(tempVar3),aVal1,kVal);
            clc
            fprintf('gen %d of %d\ngame %d of %d',i,generations,(j-1)*(games)+count,(games*total_pop));
            
        end
    end
    eloRecord(:,done+i)=eloNow;
    for j =1:children
        strat(find(eloNow==min(eloNow),1),:)=[];
        eloNow(find(eloNow==min(eloNow),1))=[];
    end
%     subplot(2,3,i)
%     hist(points)
%     title(i)
    %record(:,done+i)=points;
end
for i=1:population
    disp(eloRecord(i));
end
save('strat.mat');
subplot(2,2,1)
plot(mean(eloRecord))
title('Average Elo vs Generations')
subplot(2,2,2)
plot(max(eloRecord))
title('Max Elo vs Generations')
subplot(2,2,3)
hold on
plot(eloRecord,'.k','MarkerSize',20)
boxplot(eloRecord)
title('Box Plot Vs Generations')
hold off
subplot(2,2,4)
plot(std(eloRecord))
title('Std Vs Generations')