function d = euclid(u, v)
   % PHASE 5 UPGRADE: Weighted Feature Blending
   % We split the 2048 numbers into their 3 categories so HOG cannot bully Color.
  
   % Ensure vectors are rows
   u = u(:)';
   v = v(:)';
  
   % 1. Split the vectors based on your exact array sizes
   % Color = Indices 1 to 9
   u_color = u(1:9);       v_color = v(1:9);
  
   % Texture (LBP+Gabor+GLCM) = Indices 10 to 284
   u_text  = u(10:284);    v_text  = v(10:284);
  
   % Shape (HOG) = Indices 285 to the end (2048)
   u_shape = u(285:end);   v_shape = v(285:end);
  
   % 2. Calculate independent distances for each group
   d_color = sum(abs(u_color - v_color)) / (sum(abs(u_color) + abs(v_color)) + eps);
   d_text  = sum(abs(u_text - v_text))  / (sum(abs(u_text) + abs(v_text)) + eps);
   d_shape = sum(abs(u_shape - v_shape))/ (sum(abs(u_shape) + abs(v_shape)) + eps);
  
   % 3. Apply Explicit Weights! (The Secret Sauce)
   % We force the system to respect color and texture!
   w_color = 0.40;  % 40% Importance to Color
   w_text  = 0.30;  % 30% Importance to Texture
   w_shape = 0.30;  % 30% Importance to Shape
  
   % 4. Final Combined Score
   d = (w_color * d_color) + (w_text * d_text) + (w_shape * d_shape);
end
