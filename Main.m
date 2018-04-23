clear all;
global customer;
global vehicle;
global transport_time;
transport_time = [0,2,3,2,3,3,3,4,4,5,3;...
    2,0,3,3,2,2,3,3,5,5,3;...
    3,3,0,4,3,2,1,2,4,3,2;...
    2,3,4,0,4,4,5,5,6,6,4;...
    3,2,3,4,0,2,2,3,5,5,2;...
    3,2,2,4,2,0,2,2,5,5,1;...
    3,3,1,5,2,2,0,1,4,4,1;...
    4,3,2,5,3,2,1,0,5,3,1;...
    4,5,4,6,5,5,4,5,0,5,5;...
    5,5,3,6,5,5,4,3,5,0,4;...
    3,3,2,4,2,1,1,1,5,4,0];%�����ʱ
customers_time = [1,2;2,4;3,5;4,8;3,10;11,15;3,6;7,12;4,10;2,7]'; % �ͻ���������̵�ʱ�䴰Լ��
demand=[3 10 5 2 2 10 8 5 7 20];%�ͻ�����
customer=[1:length(demand);demand;customers_time];%�ͻ���Ϣ����
veh_load=[15 15 2 25 25 40 40];%��������
vehicle_number=[1:length(veh_load)];%���ӱ��
vehicle_cost=[200 200 300 150 150 100 100];
vehicle=[vehicle_number;veh_load;vehicle_cost];
ec_par=0.44;%��ǰ���ѣ�ÿ��ÿ��
lc_par=4000;%�ٵ��ͷ�
popsize=50;%��Ⱥ����
Generationnmax=5;  %������
pcrossover=0.90; %�������
pmutation=0.09; %�������
pop=zeros(popsize,size(demand,2)-1+10);
pop=inipop(popsize);
generation=1;
rank=pareto_rank(pop,ec_par,lc_par);%������Ӧ�Ⱦ���rank�У���1-5�зֱ��ʾ����Ⱥ���кţ���Ӧ�Ⱥ���fun1��fun2��pareto��ѡ�����P
best_f=100000;
minpop=[];%ÿһ��fun1��С�ĸ���ı���ľ���
while generation<=Generationnmax
    for i=1:2:popsize-1
        seln=selection(rank);
        father=pop(seln,:);
        %ѡ�񸸴�
        child=crossover(father,pcrossover,ec_par,lc_par);
        %���������Ӵ�
        new=mutation(child,pmutation);
        %����
        pop_new(i,:)=new(1,:);
        pop_new(i+1,:)=new(2,:);
    end
    pop=pop_new;
    rank=pareto_rank(pop,ec_par,lc_par);%������Ӧ�Ⱦ���rank�У���1-5�зֱ��ʾ����Ⱥ���кţ���Ӧ�Ⱥ���fun1��fun2��pareto��ѡ�����P
    [fmin,nmin]=min(rank(2,:));
    minpop_number=rank(1,nmin);
    if fmin<best_f
        best_f=fmin;
        best_pop_number=rank(1,nmin);
        best_pop=pop(best_pop_number,:);
    end
    fmean=mean(rank(2,:));
    ymin(generation)=fmin;
    minpop(generation,:)=pop(minpop_number,:);
    ymean(generation)=fmean;
    generation=generation+1;
end
figure(1);
hand1=plot(1:generation-1,ymin);
set(hand1,'linestyle','-','linewidth',1.8,'marker','*','markersize',6)
hold on;
hand2=plot(1:generation-1,ymean);
set(hand2,'color','r','linestyle','-','linewidth',1.8,...
'marker','h','markersize',6)
xlabel('��������');ylabel('��С/ƽ������');xlim([1 Generationnmax]);
legend('��С����','ƽ������');
box off;hold off;
load handel;
sound(y,Fs)