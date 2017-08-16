load('values.mat');
%load('strat.mat');
%% Make sure to set done=0 if youre starting over
%also run aiGen to generate new data before
generations=1;%how many gens you want to run right now
done=0;
population = 2;
children = 1;
total_pop = population + children;
games=2;%number of opponets an AI will face a generation
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

%%
record = zeros(population,generations);

for i=1:generations
    Mutation_Rate = Mutation_Rate_init-Mutation_Rate_init*i/generations;
    Mutation_Size = Mutation_Rate_init-Mutation_Rate_init*i/generations;
    points=zeros(total_pop,1);
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
    for j=1:total_pop
        count=0;
        for k=1:games
            tempvar3=ceil(population*rand);
            [point(1),point(2)]=fight(strat(j,:),strat(tempvar3,:),d);
            count=count+1;
            points(j)=point(1)+points(j);
            points(tempvar3)=point(2)+points(tempvar3);
            clc
            fprintf('gen %d of %d\ngame %d of %d',i,generations,(j-1)*(games)+count,(games*total_pop));
            
        end
    end
    for j =1:children
        strat(find(points==min(points),1),:)=[];
        points(find(points==min(points),1),:)=[];
    end
%     subplot(2,3,i)
%     hist(points)
%     title(i)
    %record(:,done+i)=points;
end
for i=1:population
    disp(points(i));
end

save('strat.mat');

