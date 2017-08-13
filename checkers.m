load('values.mat');
load('strat.mat');
%% Make sure to set done=0 if youre starting over
%also run aiGen to generate new data before
generations=1;%how many gens you want to run right now
done=0;
population = 2;
children = 1;
total_pop = population + children;
games=5;%number of opponets an AI will face a generation
d = 2; %number of turns to look ahead
%I update done manually, Im storing the points data and need how many were
%done previously to keep up with the indexes
%%

%record = zeros(population,generations)

for i=1:generations
    
    points=zeros(total_pop,1);
    for j =1:children
        tempvar1=ceil(population*rand);
        tempvar2=mod(tempvar1+ceil((population -1)*rand),population);
        if tempvar2==0
            tempvar2=ceil(population*rand);
        end
        tempStrat=sex(strat(tempvar1,:),strat(tempvar2,:));
        strat(population + j,:)=tempStrat;
    end
    for j=1:total_pop
        count=0;
        for k=1:games
            tempvar3=ceil(population*rand);
            point=fight(strat(j,:),strat(tempvar3,:),d);
            count=count+1;
            points(j)=point+points(j);
            points(tempvar3)=4-point+points(tempvar3);
            clc
            fprintf('gen %d of %d\ngame %d of %d',i,generations,(j-1)*(total_pop-1)+count,(games*total_pop));
            
        end
    end
    for j =1:children
    strat(find(points==min(points),1),:)=[];
    points(find(points==min(points),1),:)=[];
    end
    subplot(2,3,i)
    hist(points)
    title(i)
    record(done+i,:)=points;
end
for i=1:population
    disp(points(i));
end

save('strat.mat');

