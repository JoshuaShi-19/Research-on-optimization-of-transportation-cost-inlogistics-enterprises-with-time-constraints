function [fun1,fun2]=fitfun(pop,ec_par,lc_par)
global customer;
global vehicle;
global transport_time;
for j=1:size(pop,1)%����ѭ��
    p=pop(j,:);%��ǰ����
    index=find(p==0);
    tran_cost=0;
    f2(j)=0;
    for k=1:size(vehicle,2)% ����ѭ��
        c=vehicle(3,k);
        if k==1%�����j�����k�εĳ���len
            len=index(k)-1;
            path=[0,p(1:index(k))];
        else
            if k==size(vehicle,2)
                len=length(p)-index(k-1)-1;
                path=[p(index(k-1):length(p)),0];
            else
            len=index(k)-index(k-1)-1;
            path=p(index(k-1):index(k));
            end
        end
        %��j�����k�εĳ���Ϊlen
        %��k������Ĺ˿���       
        if length(path)~=2
            f2(j)=f2(j)+1;
        else
            continue
        end
        rest_weight=sum(customer(2,path(2:end-1)));%ʣ�����ػ�ԭ
        arrive_time=0;
        ec=0;
        lc=0;
        for i=2:length(path)% ����·��ѭ��
            if i~=length(path)
                ES=customer(3,path(i));
                LF=customer(4,path(i));%ʱ�䴰
                tran_cost=tran_cost+c*transport_time(path(i-1)+1,path(i)+1)*rest_weight;
                rest_weight=rest_weight-customer(2,path(i));
                arrive_time=arrive_time+transport_time(path(i-1)+1,path(i)+1);
                if arrive_time<ES
                    ec=ec+(ES-arrive_time)*customer(2,path(i))*ec_par;
                end
                if arrive_time>LF&arrive_time<=30
                    lc=lc+(arrive_time-LF)*lc_par;
                end
                if arrive_time>30
                    fun1(j)=100000000;
                end
            else
                ES=0;
                LF=30;
                tran_cost=tran_cost+c*transport_time(path(i-1)+1,path(i)+1)*rest_weight;
                arrive_time=arrive_time+transport_time(path(i-1)+1,path(i)+1);
            end
            % ����·������ɱ�
        end
    end
    f1(j)=tran_cost+ec+lc;
end
fun1=f1;
fun2=f2;

% ����·������ɱ�
% ����·����ǰ�ɱ�
% ����·���ٵ��ɱ�