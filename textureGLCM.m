function glcmFeatures = textureGLCM(img)
   % 1. Convert to grayscale if the image is RGB
   if size(img, 3) == 3
       grayImg = rgb2gray(img);
   else
       grayImg = img;
   end
  
   % 2. Create the GLCM
   % We scale the image down to 8 gray levels to speed up computation
   % 'Offset' [0 1] means we are looking at horizontal pixel relationships
   [glcm, ~] = graycomatrix(grayImg, 'Offset', [0 1], 'NumLevels', 8, 'Symmetric', true);
  
   % 3. Extract the 4 main statistical texture properties
   stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
  
   % 4. Combine them into a single 1D array (vector)
   % This will output an array of 4 numbers
   glcmFeatures = [stats.Contrast, stats.Correlation, stats.Energy, stats.Homogeneity];
end
