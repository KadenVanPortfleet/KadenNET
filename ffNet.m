% x = rand(3,3000)>.3;
% 
% disp("Original Array:")
% disp(x)
% disp("Just 2nd row:")
% disp(x(2,:))
% 
% test1 = [0; 1; 1]
% 
% [h,w] = size(x);
% targets = zeros(1,21);
% 
% for i = 1:w
%     targets(1,i) = (x(1,i) + x(2,i) + x(3,i));
% end
% 
% disp("Targets:")
% disp(targets)
% 
% 
% net = feedforwardnet(10)
% 
% net = train(net, x, targets);
% 
% output = net(test1)

%-----------
targetSize = [512, 512];

pic = imread('cats\cat_2.jpg');
imshow(pic)
resultDS = imresize(pic, [128 128]);
% cropWindow = centerCropWindow2d(size(pic), targetSize);
% 
% 
% result = imcrop(resultDS, cropWindow);



figure
imshow(resultDS)

size(resultDS)

elem = numel(resultDS)

flattened = reshape(resultDS,[elem,1])

