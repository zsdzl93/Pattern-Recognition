%get MNIST data
IM = loadMNISTImages ('train-images.idx3-ubyte');
Labels = loadMNISTLabels('train-labels.idx1-ubyte');
Labels = Labels';% to get the label transpose

% trainIM(:,1) corresponds to the intercept item
% and then the dimension becomes 60000*785
trainIM=IM(1:60000,1:784);%60000*784
trainLabels=Labels(1,1:60000);%1*60000
trainIM = [ ones(60000,1) trainIM ];%60000*785

%training process
theta= zeros(10,785) ;%10*785 initialize theta
J_new=1000;

h=0;% h times of the circulation
while 1
    %initialize all variables
    p_sum=zeros(60000,1);
    a=0;
    b=0;
    %calculate the probabilities p(m,j+1)
    for m=1:60000
        for j=0:9
            p_sum(m)=p_sum(m)+exp(theta(j+1,:)*trainIM(m,:)');
        end
    end
    for m=1:60000
        for j=0:9
            p(m,j+1)= exp(theta(j+1,:)*trainIM(m,:)')/p_sum(m);
        end
    end
    %calculate the gradient of J. And then update the theta
    J_Gradient=zeros(10,785);
    for j=0:9
        for m=1:60000
            J_Gradient(j+1,:) = J_Gradient(j+1,:) + trainIM(m,:)*((trainLabels(m)==j)-p(m,j+1));
        end
        J_Gradient(j+1,:)= -J_Gradient(j+1,:)/60000 + 0.2*theta(j+1,:);%calculate J_Gradient,0.2 is lamda
        theta(j+1,:) = theta(j+1,:) - 0.1*J_Gradient(j+1,:);%update theta,2 is alpha
    end
    
    J_old=J_new;
    %calculate J_new
    for j=0:9
        for m=1:60000
            a = a + (trainLabels(m)==j)*log(p(m,j+1));
        end
        for n=1:785
            b = b + theta(j+1,n)*theta(j+1,n);
        end
    end
    J_new = -a/60000+b*0.1;  % 0.1 is lamda/2
            
    
    if abs(J_new-J_old)<0.00001
        break;
    end
    h=h+1;
end   %end of training process
h


%test
testIM = loadMNISTImages ('t10k-images.idx3-ubyte');
testLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
testLabels = testLabels';% to get the label transpose

testIM = [ ones(10000,1) testIM ];%10000*785

%calculate the probabilities p_test(m,j+1)
p_testsum=zeros(10000,1);
p_test=zeros(10000,10);
for m=1:10000
    for j=0:9
        p_testsum(m)=p_testsum(m)+exp(theta(j+1,:)*testIM(m,:)');
    end
end
for m=1:10000
    for j=0:9
        p_test(m,j+1)= exp(theta(j+1,:)*testIM(m,:)')/p_testsum(m);
    end
end
[~,class] = max(p_test,[],2); %extract the column#
class = class-1;      %(column#-1) equals to the actual class#
correct=class'-testLabels;
accurate_rate=sum(correct()==0)/10000



