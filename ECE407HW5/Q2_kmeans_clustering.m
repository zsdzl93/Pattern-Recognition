%input the observation
x=[1 1 0 5 6 4];
y=[4 3 4 1 2 0];

%randomly assign a cluster label and report
for i=1:6
    if rand<0.5
        label(i)=1;
    else
        label(i)=2;
    end
end

%compute the initial cluster center
cluster1_x=x( label==1 );cluster1_y=y( label==1 );
cluster2_x=x( label==2 );cluster2_y=y( label==2 );
center1_x=sum( cluster1_x )/ length(cluster1_x);
center1_y=sum( cluster1_y )/ length(cluster1_y);
center2_x=sum( cluster2_x )/ length(cluster2_x);
center2_y=sum( cluster2_y )/ length(cluster2_y);

%assign each observation for the firs time
for i=1:6
    distance1=(x(i)-center1_x)^2+(y(i)-center1_y)^2;
    distance2=(x(i)-center2_x)^2+(y(i)-center2_y)^2;
    if distance1>distance2
        newlabel(i)=2;
    else
        newlabel(i)=1;
    end
end

%repeat these 2 steps: compute the centroid and assign the observation
%until the answers obtained stop changing
k=0;
while(k<3)%k is to make sure the result does stop changing at least after repeating 3 times.
    label=newlabel;
    cluster1_x=x( label==1 );cluster1_y=y( label==1 );
    cluster2_x=x( label==2 );cluster2_y=y( label==2 );

    center1_x=sum( cluster1_x )/ length(cluster1_x);
    center1_y=sum( cluster1_y )/ length(cluster1_y);
    center2_x=sum( cluster2_x )/ length(cluster2_x);
    center2_y=sum( cluster2_y )/ length(cluster2_y);

    for i=1:6
         distance1=(x(i)-center1_x)^2+(y(i)-center1_y)^2;
         distance2=(x(i)-center2_x)^2+(y(i)-center2_y)^2;
         if distance1>distance2
             newlabel(i)=2;
         else
             newlabel(i)=1;
         end
    end
    if newlabel==label
        k=k+1;
    end
end

cluster1_x=x( newlabel==1 );cluster1_y=y( newlabel==1 );
cluster2_x=x( newlabel==2 );cluster2_y=y( newlabel==2 );
%plot the obsevation
subplot(1,2,1)
plot(x,y,'r*');
%plot the result
subplot(1,2,2)
plot(cluster1_x,cluster1_y,'r*',cluster2_x,cluster2_y,'b+');








