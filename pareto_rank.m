function rank=pareto_rank(pop,ec_par,lc_par)
[fun1,fun2]=fitfun(pop,ec_par,lc_par);
[y, index] = sort(fun1);
fun=[index;y;fun2(:,index)];%�ȶ�fun1���򣬼��ȶ�Ŀ�꺯��1��������
for j=1:size(pop,1)%����ѭ�����������j������ġ��򡱣��������ġ�����ʱ��Լ����������ҵ����ɱ��Ż��о�_��ٻ���н��ܣ���nΪ��g����Ⱥ�з�����si�ĸ����������1+nΪ����si����
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
% %����Ϊ����fun1��ȷ������
% number=[size(fun,2):-1:1];
% fun(4,:)=r;
% P=number./sum(number);
% fun(5,:)=P;
% rank=fun;

%���°�������ȷ���ĸ���P
[y1, index1] = sort(r);%������������
a=y1;
a=(max(a)+1)*ones(1,length(a))-a;
rank_for_fit=[fun(:,index1);a];%������뵽��Ⱥ�ʺ϶Ⱦ�����

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
%     %���⣺����������������ȵĸ���õ��Ľ������Ҳ��ȣ�����fun1Ŀ��û����Чͻ����������ˣ�������ȵ�����£�����һ����������a������ͨ��a/k������a��Ч��
% a=a/2;
% rank_for_fit(4,:)=rank_for_fit(4,:)+a;

sumfit=sum(rank_for_fit(4,:));%��Ӻ�
P=rank_for_fit(4,:)./sumfit;%���������������
rank=[fun(:,index1);y1;P];%���ʲ��뵽��Ⱥ�ʺ϶Ⱦ�����
%����Ϊ��������ȷ���ĸ���P

%���ÿ������ĸ��ʲ����뵽��Ⱥ�ʺ϶�������
%��ǰ��rank�У���1-5�зֱ��ʾ����Ⱥ���кţ�fun1��fun2��pareto��ѡ�����P