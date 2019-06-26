%input data
x=[ 15.6 26.8 37.8 36.4 35.5 18.6 15.3 7.9 0 ];
y=[ 5.2 6.1 8.7 8.5 8.8 4.9 4.5 2.5 1.1 ];
data=[ x;y ];
%calculate the correlation coefficient
coefft=cov(data');
%draw the scatterplot
plot( x,y,'*' );
hold on
%input design matrix f
f=[ 1 15.6;
    1 26.8;
    1 37.8;
    1 36.4;
    1 35.5;
    1 18.6;
    1 15.3;
    1 7.9;
    1 0 ];
%solving the weights b
b = inv( f'*f+0.001*eye(2) )*f'*y';
%draw the regression line
syms m n
m=-5:0.1:40;
n=b(2)*m+b(1);
plot( m,n );