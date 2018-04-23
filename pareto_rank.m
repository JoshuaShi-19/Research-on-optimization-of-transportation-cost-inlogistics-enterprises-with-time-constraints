function rank=pareto_rank(pop,ec_par,lc_par)
[fun1,fun2]=fitfun(pop,ec_par,lc_par);
[y, index] = sort(fun1);
fun=[index;y;fun2(:,index)];%先对fun1排序，即先对目标函数1费用排序
for j=1:size(pop,1)%个体循环，计算出第j个个体的“序”，根据论文《基于时间约束下物流企业运输成本优化研究_张倩》中介绍，设n为第g代种群中非劣于si的个体数，则称1+n为个体si的序。
    r(j)=0;
    for i=1:size(pop,1)
        if i==j
            continue
        end
        if fun(3,i)<=fun(3,j)||fun(2,i)<=fun(2,j)
            r(j)=r(j)+1;
        end
    end
end
% %以下为按照fun1来确定概率
% number=[size(fun,2):-1:1];
% fun(4,:)=r;
% P=number./sum(number);
% fun(5,:)=P;
% rank=fun;

%以下按照序来确定的概率P
[y1, index1] = sort(r);%根据序来排序
a=y1;
a=(max(a)+1)*ones(1,length(a))-a;
rank_for_fit=[fun(:,index1);a];%把序插入到种群适合度矩阵中

% index2=find(diff(rank_for_fit(4,:)));
% a=[];
% for i=1:length(index2)
%     if i==1
%         a(1:index2(i))=[index2(i):-1:1];
%     else
%         a(index2(i-1)+1:index2(i))=[index2(i):-1:index2(i-1)+1];
%     end
% end
% a(index2(end)+1:size(rank_for_fit,2))=[size(rank_for_fit,2):-1:index2(end)+1];
%     %问题：按照序来排序，序相等的个体得到的交配概率也相等，导致fun1目标没有有效突出出来，因此，在序相等的情况下，加入一个调节向量a，可以通过a/k来调节a的效果
% a=a/2;
% rank_for_fit(4,:)=rank_for_fit(4,:)+a;

sumfit=sum(rank_for_fit(4,:));%序加和
P=rank_for_fit(4,:)./sumfit;%按照序来计算概率
rank=[fun(:,index1);y1;P];%概率插入到种群适合度矩阵中
%以上为按照序来确定的概率P

%求出每个个体的概率并插入到种群适合都矩阵中
%当前的rank中，第1-5行分别表示：种群序列号，fun1，fun2，pareto序，选择概率P