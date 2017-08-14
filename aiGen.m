function [strat] = aiGen(population)
    strat=.5*(rand(population,5046)-.5);
end
%save('strat.mat',strat)