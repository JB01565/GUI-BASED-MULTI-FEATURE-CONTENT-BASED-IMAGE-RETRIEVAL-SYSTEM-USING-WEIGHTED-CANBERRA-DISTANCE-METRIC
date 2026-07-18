function f = featureVector(image)
   % 1. Color Moments
   imag_cm = colorMoment(image);
   % 2. LBP (Texture)
   imag_lbp = lbp(image, 3);
   imag_lbp = imag_lbp(:)';
   % 3. Gabor (Texture/Orientation)
   imag_gabor = gaborFeature(image);
   imag_gabor = imag_gabor(:)';
  
   % 4. GLCM (Phase 1 texture feature)
   imag_glcm = textureGLCM(image);
   % 5. HOG (NEW Phase 2 shape feature)
   imag_hog = shapeHOG(image);
   % 6. Final combined vector (Color + Texture + Shape!)
   f = [imag_cm, imag_lbp, imag_gabor, imag_glcm, imag_hog];
end
