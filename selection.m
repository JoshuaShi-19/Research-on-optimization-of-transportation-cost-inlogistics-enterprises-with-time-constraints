%�ӳ�������Ⱥѡ�����, �������ƴ洢Ϊselection.m
function seln=selection(rank)
P=rank(5,:);
for i=1:2
    r=rand;  %����һ�������
    j=1;
    while sum(P(1:j))<r
       j=j+1;
    end
    seln(i)=rank(1,j);
end