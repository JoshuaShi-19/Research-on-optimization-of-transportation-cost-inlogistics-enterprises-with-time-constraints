function pop=inipop(popsize)
global customer;
global vehicle;
global transport_time;
for j=1:popsize
    cust_number=[1:size(customer,2)];%�ͻ����
    Z=vehicle(2,:);%����ʣ��������
    R=ones(1,size(vehicle,2)).*30;%����ʣ��ʱ��
    beta=zeros(size(vehicle,2),10);%��������·��
    [y, index] = sort(customer(2,:));
    cust=[index;y];%�����µĿͻ�������Ϊ�ֲ�����������Ӱ��ȫ�ֱ���
    cod=[];
    while 1% ��ѭ��
        ka=[];%���ka���������������ĳ���
        max_cust=cust(:,end);
        % �ҵ����ͻ�
        for i=1:size(vehicle,2)% ����ѭ��
            b=beta(i,:);%ȡ����i�ų�������·��
            bk=b(end)+1;%ȡ��i�ų�Ŀǰ��������һ���˿͵����
            time=transport_time(max_cust(1,1)+1,b(end)+1);%i�ų��ӵ�ǰ���һ���˿͵�λ�õ����˿͵�λ�ã�������ʱ��
            if max_cust(2,1)<=Z(i) &time<=R(i)% ���ó��Ƿ���������
                ka=[ka,i];% �����㣬�Ѹó�����ka
            end
        end
        pick=ka(ceil(rand*length(ka)));%���ȡ��ka��һ�����ı��
        beta(pick,find(beta(pick,:)==0,1,'first'))=max_cust(1,1);%���ÿͻ��ı�Ų��뵽��������·��������
        % ��ka�������һ�������͸ÿͻ�
        Z(pick)=Z(pick)-max_cust(2,1);
        R(pick)=R(pick)-time;
        % �ó���Z��R��ȥ��Ӧ����
        cust=cust(:,1:(size(cust,2)-1));
        % �ͻ�����ɾ���ÿͻ�
        if isempty(cust)
            break
        end
        % ���ͻ����ﻹ�м����ͻ������û�У�������ѭ��
    end
    for i=1:size(vehicle,2)% ����ѭ��
        b=beta(i,:);%ȡ����i�ų�������·��
        index=randperm(length(b));
        beta(i,:)=b(:,index);
        b=beta(i,:);
        info=b(:,find(beta(i,:)));
        cod=[cod,0,info];
    end
    % ������г���������·�����õ�����
    pop(j,:)=cod(2:end);
    % ����
end