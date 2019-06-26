%read the data
data=xlsread('Q1-DATA.xlsx');

%initialize
u=zeros(5,2);
u_old=ones(5,2);
cov=zeros(2,2,5);
pie=0.2*ones(1,5);
for i=1:5
    u(i,:)=[-50+100*rand,-50+100*rand];
    cov(:,:,i)=10*eye(2);
end

while (sum(abs(u_old(:)-u(:)))>0.1)%stop when the result stop changing
    u_old=u;
    w=zeros(200,5);
    for i=1:200
        denominator=0;
        for j=1:5
            denominator=denominator+pie(j)*mvnpdf( data(i,:),u(j,:),cov(:,:,j) );
        end
        for j=1:5
            w(i,j)=pie(j)*mvnpdf( data(i,:),u(j,:),cov(:,:,j) )/denominator;
        end
    end
    
    for j=1:5
        sum_w=0;
        sum_wx=zeros(1,2);
        sum_wxu=zeros(2);
        for i=1:200
            sum_w=sum_w+w(i,j);
            sum_wx=sum_wx+w(i,j)*data(i,:);
            sum_wxu=sum_wxu+w(i,j)*(data(i,:)-u(j,:))'*(data(i,:)-u(j,:));
        end
        pie(j)=sum_w/200;
        u(j,:)=sum_wx/sum_w;
        cov(:,:,j)=sum_wxu/sum_w;
    end
end
for i=1:200
    label(i)=find(w(i,:)==max(w(i,:)),2);
end
cluster1_x=data( label==1,1 );cluster1_y=data( label==1,2 );
cluster2_x=data( label==2,1 );cluster2_y=data( label==2,2 );
cluster3_x=data( label==3,1 );cluster3_y=data( label==3,2 );
cluster4_x=data( label==4,1 );cluster4_y=data( label==4,2 );
cluster5_x=data( label==5,1 );cluster5_y=data( label==5,2 );
plot(cluster1_x,cluster1_y,'r*',cluster2_x,cluster2_y,'y+',cluster3_x,cluster3_y,'b+',cluster4_x,cluster4_y,'k^',cluster5_x,cluster5_y,'g+');
