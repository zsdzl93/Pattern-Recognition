%read the data
data=xlsread('Q1-DATA.xlsx');
data=data';
x=data(1,:);y=data(2,:);

%randomly assign a cluster label and report
for i=1:200
    r=rand;
    if r<0.2
        label(i)=1;
    elseif r<0.4
        label(i)=2;
    elseif r<0.6
        label(i)=3;
    elseif r<0.8
        label(i)=4;
    else
        label(i)=5;
    end
end

%compute the initial cluster center
cluster1_x=x( label==1 );cluster1_y=y( label==1 );
cluster2_x=x( label==2 );cluster2_y=y( label==2 );
cluster3_x=x( label==3 );cluster3_y=y( label==3 );
cluster4_x=x( label==4 );cluster4_y=y( label==4 );
cluster5_x=x( label==5 );cluster5_y=y( label==5 );
center1_x=sum( cluster1_x )/ length(cluster1_x);center1_y=sum( cluster1_y )/ length(cluster1_y);
center2_x=sum( cluster2_x )/ length(cluster2_x);center2_y=sum( cluster2_y )/ length(cluster2_y);
center3_x=sum( cluster3_x )/ length(cluster3_x);center3_y=sum( cluster3_y )/ length(cluster3_y);
center4_x=sum( cluster4_x )/ length(cluster4_x);center4_y=sum( cluster4_y )/ length(cluster4_y);
center5_x=sum( cluster5_x )/ length(cluster5_x);center5_y=sum( cluster5_y )/ length(cluster5_y);


%assign each observation for the first time
for i=1:200
    distance(1)=(x(i)-center1_x)^2+(y(i)-center1_y)^2;
    distance(2)=(x(i)-center2_x)^2+(y(i)-center2_y)^2;
    distance(3)=(x(i)-center3_x)^2+(y(i)-center3_y)^2;
    distance(4)=(x(i)-center4_x)^2+(y(i)-center4_y)^2;
    distance(5)=(x(i)-center5_x)^2+(y(i)-center5_y)^2;
    
    [~,column]=find(distance==min(distance));
    newlabel(i)= column;
end

%repeat these 2 steps: compute the centroid and assign the observation
%until the answers obtained stop changing
k=0;
while(k<3)%k is to make sure the result does stop changing at least after repeating 3 times.
    label=newlabel;
    cluster1_x=x( label==1 );cluster1_y=y( label==1 );
    cluster2_x=x( label==2 );cluster2_y=y( label==2 );
    cluster3_x=x( label==3 );cluster3_y=y( label==3 );
    cluster4_x=x( label==4 );cluster4_y=y( label==4 );
    cluster5_x=x( label==5 );cluster5_y=y( label==5 );
    center1_x=sum( cluster1_x )/ length(cluster1_x);center1_y=sum( cluster1_y )/ length(cluster1_y);
    center2_x=sum( cluster2_x )/ length(cluster2_x);center2_y=sum( cluster2_y )/ length(cluster2_y);
    center3_x=sum( cluster3_x )/ length(cluster3_x);center3_y=sum( cluster3_y )/ length(cluster3_y);
    center4_x=sum( cluster4_x )/ length(cluster4_x);center4_y=sum( cluster4_y )/ length(cluster4_y);
    center5_x=sum( cluster5_x )/ length(cluster5_x);center5_y=sum( cluster5_y )/ length(cluster5_y);


    %assign each observation for the firs time
    for i=1:200
        distance(1)=(x(i)-center1_x)^2+(y(i)-center1_y)^2;
        distance(2)=(x(i)-center2_x)^2+(y(i)-center2_y)^2;
        distance(3)=(x(i)-center3_x)^2+(y(i)-center3_y)^2;
        distance(4)=(x(i)-center4_x)^2+(y(i)-center4_y)^2;
        distance(5)=(x(i)-center5_x)^2+(y(i)-center5_y)^2;
    
        [~,column]=find(distance==min(distance));
        newlabel(i)= column;
    end
    if newlabel==label
        k=k+1;
    end
end

cluster1_x=x( newlabel==1 );cluster1_y=y( newlabel==1 );
cluster2_x=x( newlabel==2 );cluster2_y=y( newlabel==2 );
cluster3_x=x( newlabel==3 );cluster3_y=y( newlabel==3 );
cluster4_x=x( newlabel==4 );cluster4_y=y( newlabel==4 );
cluster5_x=x( newlabel==5 );cluster5_y=y( newlabel==5 );
%plot the obsevation
subplot(1,2,1)
plot(x,y,'r*');
% plot the result
subplot(1,2,2)
plot(cluster1_x,cluster1_y,'r*',cluster2_x,cluster2_y,'y+',cluster3_x,cluster3_y,'b+',cluster4_x,cluster4_y,'k^',cluster5_x,cluster5_y,'g+');