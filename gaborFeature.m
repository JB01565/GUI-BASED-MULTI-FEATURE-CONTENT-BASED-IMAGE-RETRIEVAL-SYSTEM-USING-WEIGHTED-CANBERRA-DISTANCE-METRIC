function gaborVect = gaborFeature(image)
    % 1. Convert to grayscale if needed
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    
    % 2. Standardize size for consistent signal response
    image = imresize(image, [256 256]); 
    
    % 3. Create Filter Bank (2 scales, 4 angles)
    gaborArray = gabor([4 8], [0 45 90 135]);
    
    % 4. Apply filters
    [gaborMag, ~] = imgaborfilt(image, gaborArray);
    
    % 5. Extract Mean and Std Dev for each of the 8 filters
    gaborVect = zeros(1, length(gaborArray)*2);
    for i = 1:length(gaborArray)
        gaborVect(2*i-1) = mean(mean(gaborMag(:,:,i)));
        gaborVect(2*i) = std(std(gaborMag(:,:,i)));
    end
end