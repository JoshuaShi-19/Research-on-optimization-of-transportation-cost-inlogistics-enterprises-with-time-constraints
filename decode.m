function [path_form,path_ne]=decode(indi)
global vehicle;
global customer;
path_form=[];
path_ne=[];
for k=1:size(vehicle,2)% ³µÁ¾Ñ­»·
    index=find(indi==0);
    path=[];
    if k==1
        path=indi(1:index(k)-1);
    else
        if k==size(vehicle,2)
            path=indi(index(k-1)+1:end);
        else
            path=indi(index(k-1)+1:index(k)-1);
        end
    end
    path_form(k,:)=[path,zeros(1,size(customer,2)-length(path))];
    if ~isempty(path)
        path_ne(size(path_ne,1)+1,:)=[path,zeros(1,size(customer,2)-length(path))];
    end
end