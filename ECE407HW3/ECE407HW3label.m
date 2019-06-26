Trainl_l = fopen('train-labels.idx1-ubyte','r','b'); % first we have to open the binary file
MagicNumber=fread(Trainl_l,1,'int32')
Labels_num= fread(Trainl_l,1,'int32')% Read the number of labels
% The first label is stored in 8th byte of file in unsigned byte format:
fseek(Trainl_l,8,'bof');
fread(Trainl_l,1,'uchar')

IM = loadMNISTImages ('train-images.idx3-ubyte');
Labels = loadMNISTLabels('train-labels.idx1-ubyte');
% Also, you can show some examples from the MNIST by writing the following
% code
figure
colormap();
for i=1:49 % to show the first 50 images from the chosen file
    subplot( 7, 7, i )
    X=reshape(IM(i,:),28,28);
    imshow(X);
    title(num2str(Labels(i)));
end