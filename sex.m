function [ child ] = sex( mom, dad )
child=zeros(1,5046);
upperbound=.25;
lowerbound=-.25;
mutRange=.05;
mutRate=.1;
for i=1:5046
    if rand>.5
        child(i)=mom(i);
    else
        child(i)=dad(i);
    end
    if rand<mutRate
        child(i)=child(i)+mutRange*(rand-.5);
    end
end
child(child>upperbound)=upperbound;
child(child<lowerbound)=lowerbound;
end