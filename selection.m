%子程序：新种群选择操作, 函数名称存储为selection.m
function seln=selection(rank)
P=rank(5,:);
for i=1:2
    r=rand;  %产生一个随机数
    j=1;
    while sum(P(1:j))<r
       j=j+1;
    end
    seln(i)=rank(1,j);
end