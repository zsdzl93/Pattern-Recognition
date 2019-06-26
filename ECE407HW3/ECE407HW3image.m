Xtrain = fopen('train-images.idx3-ubyte','r','b'); % to open the binary file
MN=fread(Xtrain,1,'int32')
Im_num= fread(Xtrain,1,'int32')% to read the number of images

% Note: for this file the data pixels of the image stored from byte 16th to the end
% [800 (16+28*28)]
% Since the data images started at byte 16th you can find it and start reading the data by
% using the following commands:
fseek(Xtrain,16,'bof');
img= fread(Xtrain,28*28,'uchar'); % each image has 28*28 pixels in unsigned byte formatY=zeros(28,28);
Y = zeros(28,28);
for i=1:28
    Y(i,:)=img( (i-1)*28+1 : i*28 );
end
imshow(Y); % to show the first image in the training file