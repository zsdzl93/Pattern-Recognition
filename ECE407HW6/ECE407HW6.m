%read the data
data=xlsread('data2.xlsx');
%adjust the data, minus the mean value
data(:,1)=data(:,1)-mean(data(:,1));
data(:,2)=data(:,2)-mean(data(:,2));
plot(data(:,1),data(:,2),'.');
grid on
hold on

sigma=cov(data);
[eigenvector,eigenvalue]=eig(sigma);
%find the principle component
[~,a]=find(eigenvalue==max(max(eigenvalue)));
% x is the projection
x=data*eigenvector(:,a)
quiver( eigenvector(1,a),eigenvector(2,a),6 );
quiver( -eigenvector(1,a),-eigenvector(2,a),4 );
