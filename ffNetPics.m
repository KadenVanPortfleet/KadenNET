catsDir = 'cats\'
dogsDir = 'dogs\'

if ~isdir(catsDir)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', catsDir);
  uiwait(warndlg(errorMessage));
  return;
end

if ~isdir(dogsDir)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', dogsDir);
  uiwait(warndlg(errorMessage));
  return;
end

filePatternC = fullfile(catsDir, "*.jpg");
filePatternD = fullfile(dogsDir, "*.jpg");
jpgFilesC = dir(filePatternC);
jpgFilesD = dir(filePatternD);

disp("Number of Cat Photos: " + length(jpgFilesC))
cCount = length(jpgFilesC);
disp("Number of Dog Photos: " + length(jpgFilesD))
dCount = length(jpgFilesD);

%Input array for net
inputArray = zeros(2500, (dCount + cCount));
test = inputArray(:,1);
targetsP = zeros(2,(dCount + cCount));

for k = 1:cCount
    baseName = jpgFilesC(k).name;
    fullName = fullfile(catsDir,baseName);
    pic = imread(fullName);
    pic = rgb2gray(pic);
    fprintf(1, 'Now reading %s\n', fullName);
    %Target downsample size
    targetSize = [50 50];
    % Normalize image input
    downSample = imresize(pic, targetSize);
    elems = numel(downSample);
    flattened = reshape(downSample,[elems,1]);
    inputArray(:,k) = flattened;
    targetsP(:,k) = [1; 0];
end

for k = (1+cCount):(dCount + cCount)
    baseName = jpgFilesD(k-cCount).name;
    fullName = fullfile(dogsDir,baseName);
    pic = imread(fullName);
    pic = rgb2gray(pic);
    fprintf(1, 'Now reading %s\n', fullName);
    %Target downsample size
    targetSize = [50 50];
    % Normalize image input
    downSample = imresize(pic, targetSize);
    elems = numel(downSample);
    flattened = reshape(downSample,[elems,1]);
    inputArray(:,k) = flattened;
    targetsP(:,k) = [0, 1];
end

net = feedforwardnet(10)
[net,tr] = train(net, inputArray, targetsP)

for i = 1:(cCount + dCount)
    sprintf("Image %d Inference: \n", i)
    net(inputArray(:,i))
end

KadenNet = net;

save KadenNet;






