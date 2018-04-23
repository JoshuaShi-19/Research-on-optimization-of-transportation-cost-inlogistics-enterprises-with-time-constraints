function child=crossover(father,pcrossover,ec_par,lc_par)
global vehicle;
global customer;
if rand<pcrossover
    pick_path=[];
    for i=1:2
        fa=father(i,:);
        path_ne=[];
        for k=1:size(vehicle,2)% 车辆循环
            % c=vehicle(3,k);
            index=find(fa==0);
            if k==1%计算第j个体第k段的长度len
                path=fa(1:index(k)-1);
            else
                if k==size(vehicle,2)
                    path=fa(index(k-1)+1:end);
                else
                    path=fa(index(k-1)+1:index(k)-1);
                end
            end
            if ~isempty(path)
                path_ne(size(path_ne,1)+1,:)=[path,zeros(1,size(customer,2)-length(path))];
            end
        end
        %解码工作，将fahter拆成7个车的路径矩阵path，取出非空路径用0补到长度10，形成路径矩阵path_ne
        pick=ceil(rand*size(path_ne,1));
        pick_path(i,:)=path_ne(pick,:);
        %在父代1和2中随机选择一段长度超过2的路径，分别为pick_path1 2
    end
    use_path1=setdiff(pick_path(1,:),0,'stable');
    use_path2=setdiff(pick_path(2,:),0,'stable');
    fa1=father(1,:);
    for i=1:length(use_path2)
        fa1(fa1==use_path2(i))=[];
    end
    info1=fa1;
    fa2=father(2,:);
    for i=1:length(use_path1)
        fa2(fa2==use_path1(i))=[];
    end
    info2=fa2;
    %父代1中删选中除路径pick_path2中的元素，赋值给info1，同样赋值info2
    pop1=[];
    pop2=[];
    while size(pop1,1)<100
        ini2=randperm(length(use_path2));
        up2=use_path2(1,ini2);%将use_path2随机排序
        in1=info1;
        for i=1:length(up2)
            index=ceil(rand*length(in1));
            in1=[in1(1:index),up2(i),in1(index+1:end)];
        end
        [path,path_ne]=decode(in1);
        j=1;
        while j<=size(path,1)
            dc=setdiff(path(j,:),0,'stable');
            weight=sum(customer(2,dc));
            if weight>vehicle(2,j)
                break
            end
            j=j+1;
        end
        if j==8
            pop1(size(pop1,1)+1,:)=in1;
        end
    end
    
    while size(pop2,1)<100
        ini1=randperm(length(use_path1));
        up1=use_path1(1,ini1);%将use_path2随机排序
        in2=info2;
        for i=1:length(use_path1)
            index=ceil(rand*length(in2));
            in2=[in2(1:index),up1(i),in2(index+1:end)];
        end
        [path,path_ne]=decode(in2);
        j=1;
        while j<=size(path,1)
            dc=setdiff(path(j,:),0,'stable');
            weight=sum(customer(2,dc));
            if weight>vehicle(2,j)
                break
            end
            j=j+1;
        end
        if j==8
            pop2(size(pop2,1)+1,:)=in2;
        end
    end
    % use_path2元素随机插入info1，use_path1元素随机插入info2
    % 计算条件是否满足，若满足，放入pop1和pop2
    rank1=pareto_rank(pop1,ec_par,lc_par);
    [y1, index1] = sort(rank1(2,:));
    n1=rank1(1,index1(1));
    child(1,:)=pop1(n1,:);
    
    rank2=pareto_rank(pop2,ec_par,lc_par);
    [y2, index2] = sort(rank2(2,:));
    n2=rank2(1,index2(1));
    child(2,:)=pop2(n2,:);
else
    child=father;
end


% 计算fun1，取最小一组赋值给child
% 否则，直接将father复制给child