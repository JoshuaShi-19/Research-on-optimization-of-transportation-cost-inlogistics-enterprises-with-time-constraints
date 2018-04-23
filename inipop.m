function pop=inipop(popsize)
global customer;
global vehicle;
global transport_time;
for j=1:popsize
    cust_number=[1:size(customer,2)];%客户编号
    Z=vehicle(2,:);%车辆剩余载重量
    R=ones(1,size(vehicle,2)).*30;%车辆剩余时间
    beta=zeros(size(vehicle,2),10);%车辆运输路径
    [y, index] = sort(customer(2,:));
    cust=[index;y];%创建新的客户集，此为局部变量，不会影响全局变量
    cod=[];
    while 1% 死循环
        ka=[];%清空ka集，即符合条件的车集
        max_cust=cust(:,end);
        % 找到最大客户
        for i=1:size(vehicle,2)% 车辆循环
            b=beta(i,:);%取出第i号车的运输路径
            bk=b(end)+1;%取出i号车目前运输的最后一个顾客的序号
            time=transport_time(max_cust(1,1)+1,b(end)+1);%i号车从当前最后一个顾客的位置到最大顾客的位置，的运输时间
            if max_cust(2,1)<=Z(i) &time<=R(i)% 检查该车是否满足条件
                ka=[ka,i];% 若满足，把该车放入ka
            end
        end
        pick=ka(ceil(rand*length(ka)));%随机取出ka中一个车的编号
        beta(pick,find(beta(pick,:)==0,1,'first'))=max_cust(1,1);%将该客户的编号插入到车辆运输路径矩阵中
        % 从ka中随机找一辆车运送该客户
        Z(pick)=Z(pick)-max_cust(2,1);
        R(pick)=R(pick)-time;
        % 该车的Z和R减去相应的量
        cust=cust(:,1:(size(cust,2)-1));
        % 客户集中删除该客户
        if isempty(cust)
            break
        end
        % 检查客户集里还有几个客户，如果没有，跳出死循环
    end
    for i=1:size(vehicle,2)% 车辆循环
        b=beta(i,:);%取出第i号车的运输路径
        index=randperm(length(b));
        beta(i,:)=b(:,index);
        b=beta(i,:);
        info=b(:,find(beta(i,:)));
        cod=[cod,0,info];
    end
    % 随机排列车辆的运送路径，得到个体
    pop(j,:)=cod(2:end);
    % 编码
end