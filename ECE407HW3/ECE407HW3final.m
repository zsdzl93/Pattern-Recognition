IM = loadMNISTImages ('train-images.idx3-ubyte');
Labels = loadMNISTLabels('train-labels.idx1-ubyte');
Labels = Labels';% to get the label transpose

%Split the training set into two pieces :
%a training set of size 50000, and a separate validation set of size 10000
trainIM=IM(1:50000,1:784);
trainLabels=Labels(1,1:50000);
validationIM=IM(50001:60000,1:784);
validationLabels=Labels(1,50001:60000);

% choose the value of c on the validation set
accurate_rate=0;
c_final=0;
for c=0.02:0.001:0.09
    %training
    for i = 0:9
        pi(i+1) = sum(trainLabels()==i)/50000;%Determine the class probabilities
        u(i+1,:)= mean( trainIM(trainLabels()==i,:) );%the mean of the corresponding data
        sigma{i+1} = cov( trainIM(trainLabels()==i,:) ) + c*eye(784);%the covariance of the corresponding data
    end
    %validation
    for k = 0:9  %Y is 10000*10
        Y(:,k+1)=pi(k+1)*mvnpdf( validationIM(:,:),u(k+1,:),sigma{k+1} );
    end
    [~,class] = max(Y,[],2); %extract the column#
    class = class-1;      %(column#-1) equals to the actual class#
    correct=class'-validationLabels;
    if (sum(correct()==0)/10000)>accurate_rate
       c_final=c;
       accurate_rate=sum(correct()==0)/10000;
    end
end
c_final

%test
testIM = loadMNISTImages ('t10k-images.idx3-ubyte');
testLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
testLabels = testLabels';% to get the label transpose

for i = 0:9
    sigma{i+1} = cov( trainIM(trainLabels()==i,:) ) + c_final*eye(784);%the covariance of the corresponding data
end
for k = 0:9  %Y is 10000*10
    Y(:,k+1)=pi(k+1)*mvnpdf( testIM(:,:),u(k+1,:),sigma{k+1} );
end
[~,class] = max(Y,[],2); %extract the column#
class = class-1;      %(column#-1) equals to the actual class#
correct=class'-testLabels;
accurate_rate=sum(correct()==0)/10000

%Out of the misclassified test digits, pick five at random and display them. 
[~,error]=find(correct()~=0);
randerror=randperm(length(error));
outerror=error(randerror(1:5));

subplot(1,5,1);
imshow(reshape(testIM(outerror(1),:),28,28));
title(['label:',num2str(outerror(1))]);
xlabel({['P0=',num2str(Y(outerror(1),1))];['P1=',num2str(Y(outerror(1),2))];['P2=',num2str(Y(outerror(1),3))];['P3=',num2str(Y(outerror(1),4))];['P4=',num2str(Y(outerror(1),5))];['P5=',num2str(Y(outerror(1),6))];['P6=',num2str(Y(outerror(1),7))];['P7=',num2str(Y(outerror(1),8))];['P8=',num2str(Y(outerror(1),9))];['P9=',num2str(Y(outerror(1),10))]});

subplot(1,5,2);
imshow(reshape(testIM(outerror(2),:),28,28));
title(['label:',num2str(outerror(2))]);
xlabel({['P0=',num2str(Y(outerror(2),1))];['P1=',num2str(Y(outerror(2),2))];['P2=',num2str(Y(outerror(2),3))];['P3=',num2str(Y(outerror(2),4))];['P4=',num2str(Y(outerror(2),5))];['P5=',num2str(Y(outerror(2),6))];['P6=',num2str(Y(outerror(2),7))];['P7=',num2str(Y(outerror(2),8))];['P8=',num2str(Y(outerror(2),9))];['P9=',num2str(Y(outerror(2),10))]});

subplot(1,5,3);
imshow(reshape(testIM(outerror(3),:),28,28));
title(['label:',num2str(outerror(3))]);
xlabel({['P0=',num2str(Y(outerror(3),1))];['P1=',num2str(Y(outerror(3),2))];['P2=',num2str(Y(outerror(3),3))];['P3=',num2str(Y(outerror(3),4))];['P4=',num2str(Y(outerror(3),5))];['P5=',num2str(Y(outerror(3),6))];['P6=',num2str(Y(outerror(3),7))];['P7=',num2str(Y(outerror(3),8))];['P8=',num2str(Y(outerror(3),9))];['P9=',num2str(Y(outerror(3),10))]});

subplot(1,5,4);
imshow(reshape(testIM(outerror(4),:),28,28));
title(['label:',num2str(outerror(4))]);
xlabel({['P0=',num2str(Y(outerror(4),1))];['P1=',num2str(Y(outerror(4),2))];['P2=',num2str(Y(outerror(4),3))];['P3=',num2str(Y(outerror(4),4))];['P4=',num2str(Y(outerror(4),5))];['P5=',num2str(Y(outerror(4),6))];['P6=',num2str(Y(outerror(4),7))];['P7=',num2str(Y(outerror(4),8))];['P8=',num2str(Y(outerror(4),9))];['P9=',num2str(Y(outerror(4),10))]});

subplot(1,5,5);
imshow(reshape(testIM(outerror(5),:),28,28));
title(['label:',num2str(outerror(5))]);
xlabel({['P0=',num2str(Y(outerror(5),1))];['P1=',num2str(Y(outerror(5),2))];['P2=',num2str(Y(outerror(5),3))];['P3=',num2str(Y(outerror(5),4))];['P4=',num2str(Y(outerror(5),5))];['P5=',num2str(Y(outerror(5),6))];['P6=',num2str(Y(outerror(5),7))];['P7=',num2str(Y(outerror(5),8))];['P8=',num2str(Y(outerror(5),9))];['P9=',num2str(Y(outerror(5),10))]});

