function hogFeat = shapeHOG(img)
   % 1. Convert to grayscale (HOG only cares about edges, not colors)
   if size(img, 3) == 3
       grayImg = rgb2gray(img);
   else
       grayImg = img;
   end
  
   % 2. Resize the image before extraction
   % This is CRITICAL. HOG vectors change length based on image size.
   % We must force all images to be the exact same size so the math works.
   imgResized = imresize(grayImg, [64 64]);
  
   % 3. Extract HOG features
   % CellSize [8 8] is standard for balancing speed and accuracy
   hogFeat = extractHOGFeatures(imgResized, 'CellSize', [8 8]);
end
