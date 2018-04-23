function new=mutation(child,pmutation)
global vehicle;
global customer;
if rand<pmutation
    new=zeros(2,16);
    for i=1:2
        while sum(new(i,:))==0
            fa=child(i,:);
            index1=0;
            index2=0;
            while index1==index2
                index1=ceil(rand*length(fa));
                index2=ceil(rand*length(fa));
            end
            index=[index1,index2];
            index=sort(index);
            cus1=fa(index(1));
            cus2=fa(index(2));
            fa(index(2))=cus1;
            fa(index(1))=cus2;
            [path,path_ne]=decode(fa);
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
                new(i,:)=fa;
            end
        end
    end
else
    new=child;
end
