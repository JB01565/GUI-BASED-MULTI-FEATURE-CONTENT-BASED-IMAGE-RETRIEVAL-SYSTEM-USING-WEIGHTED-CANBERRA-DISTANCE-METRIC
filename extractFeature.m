close all; clear; clc;
imgpath = 'image.orig'; % Folder containing your images
% Only grab valid image files to prevent system file crashes
validFiles = dir(fullfile(imgpath, '*.jpg'));
numFiles = length(validFiles);
raw_fvect = [];
fprintf('Starting Feature Extraction and Normalization...\n');
for i = 1:numFiles
   imgname = fullfile(imgpath, validFiles(i).name);
   img = imread(imgname);
  
   % Use the improved featureVector
   raw_fvect(i, :) = featureVector(img);
   fprintf('Processed %d/%d: %s\n', i, numFiles, validFiles(i).name);
end
% CALCULATE NORMALIZATION PARAMETERS
f_min = min(raw_fvect);
f_max = max(raw_fvect);
% Normalize the whole database (0 to 1 scaling)
fvect = (raw_fvect - f_min) ./ (f_max - f_min + eps);
% Save EVERYTHING for the GUI
save('fvect.mat', 'fvect', 'f_min', 'f_max');
fprintf('Success! fvect.mat created with normalization data.\n');
 