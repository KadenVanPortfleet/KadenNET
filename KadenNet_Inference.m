load('KadenNet.mat', 'KadenNet');


testCat = "testdata\dog";
testDog = "testdata\dog";

filePatternC = fullfile(testCat, "*.jpg");
filePatternD = fullfile(testDog, "*.jpg");
jpgFilesC = dir(filePatternC);
jpgFilesD = dir(filePatternD);

disp("Number of Cat Photos: " + length(jpgFilesC))
cCount = length(jpgFilesC);
disp("Number of Dog Photos: " + length(jpgFilesD))
dCount = length(jpgFilesD);
positives = 0;

for k = 1:cCount
    baseName = jpgFilesC(k).name;
    fullName = fullfile(testCat, baseName);
    t = imread(fullName);
    t = rgb2gray(t);
    tempArray = zeros(2500,1);
    t = imresize(t, [50 50]);
    elems = numel(t);
    tReshape = reshape(t, [elems,1] );
    imshow(t);
    tempArray(:,1) = tReshape;
    result = KadenNet(tempArray);
    disp(result);
    if result(1,1) > result(2,1)
        positives = positives + 1;
    end
end

disp("Accuracy: " + positives/cCount);






