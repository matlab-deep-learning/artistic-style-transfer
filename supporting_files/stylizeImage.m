function Y = stylizeImage(dlnetTransform,im,miniBatchSize)

%  Copyright 2020 The MathWorks, Inc.

if nargin < 3
    miniBatchSize = 4;
end

numImages = size(im,4);
numIterations = ceil(numImages/miniBatchSize);

for i = 1:numIterations
    idx = ((i-1)*miniBatchSize + 1):min((i*miniBatchSize),numImages);
    
    dlX = dlarray(single(im(:,:,:,idx)),'SSCB');
    
    if canUseGPU
        dlX = gpuArray(dlX);
    end
    
    dlY = dlnetTransform.predict(dlX);
    
    if i == 1
        sz = size(dlY,1:3);
        Y = zeros([sz numImages]);
    end
    
    Y(:,:,:,idx) = gather(extractdata((tanh(dlY)+1)/2));
end

end

