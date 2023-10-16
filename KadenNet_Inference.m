load('KadenNet.mat', 'KadenNet');

t = imread('testdata\Cat_November_2010-1a.jpg');
tempArray = zeros(3072,1);

t = imresize(t, [32 32]);
elems = numel(t);
tReshape = reshape(t, [elems,1] );
imshow(t);
tempArray(:,1) = tReshape;


KadenNet(tempArray)