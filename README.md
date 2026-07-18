# GUI-BASED-MULTI-FEATURE-CONTENT-BASED-IMAGE-RETRIEVAL-SYSTEM-USING-WEIGHTED-CANBERRA-DISTANCE-METRIC
## Technical Abstract & System Architecture

This final project details the design, evolution, and implementation of an enhanced Content-Based Image Retrieval (CBIR) system engineered in MATLAB. Building upon a foundational baseline proposed by Choudhary et al. (2014) that only integrated Color Moments (CM) and Local Binary Patterns (LBP), this improved framework integrates deep structural shape and spatial-statistical features to solve thematic inaccuracies.

The system operates via a dual-phase workflow consisting of an **offline database update pipeline** and an **online real-time query processing engine**. Rather than executing raw pixel calculations dynamically, the system pre-analyzes a localized image database (`image.orig`) and extracts a comprehensive, high-dimensional numerical signature for every image. These signatures are scaled via standard normalization techniques and stored inside a centralized `.mat` file for high-speed retrieval deployment.

---

## Key System Enhancements

### 1. 2048-Dimensional Multi-Feature Extraction Pipeline

The system expands the original ~264-element feature vector to a **2048-dimensional vector** by combining five specialized mathematical descriptors across three core visual groups:

* **Color Group (9 Dimensions):** Uses **Color Moments (CM)** calculated across the HSV (Hue, Saturation, Value) color space to compute the mean, standard deviation, and skewness of color channels.


* **Texture Group (275 Dimensions):** Combines **Local Binary Patterns (LBP)** (255 dimensions) to extract uniform pixel intensity relationships with **Gabor Filters** (16 dimensions spanning 2 scales and 4 orientation angles) and a **Gray-Level Co-occurrence Matrix (GLCM)** (4 dimensions tracking Contrast, Correlation, Energy, and Homogeneity) to capture spatial and directional surface regularities.


* **Shape Group (1764 Dimensions):** Integrates a **Histogram of Oriented Gradients (HOG)** descriptor by resizing images to a standard $64\times64$ grayscale matrix and analyzing localized vector edge magnitudes across an $8\times8$ pixel cell block array.



### 2. Similarity Metric & Explicit Feature Weighting

While the original baseline mistakenly allowed the high-dimensional HOG vector to numerically dominate distance equations, the improved system divides the feature vector indexes and introduces a **Weighted Canberra Distance Metric**. The Canberra calculation treats feature groups equitably by normalizing individual deviations against value magnitudes. Explicit visual weights are enforced via the following criteria:


$$\text{Importance Weighting} = 40\% \text{ Color } (w_{\text{color}}=0.40) + 30\% \text{ Texture } (w_{\text{texture}}=0.30) + 30\% \text{ Shape } (w_{\text{shape}}=0.30)$$

### 3. Min-Max Global Feature Normalization

To prevent disparate value ranges (e.g., small Gabor filter outputs vs. large LBP histogram distributions) from skewing calculations, global **Min-Max Normalization** scales all extracted numerical signatures strictly to a $[0, 1]$ range. Query target images loaded in real-time undergo this identical scale transformation using saved minimum/maximum parameters to maintain mathematical parity.

### 4. Interactive MATLAB App Designer GUI

The project completely replaces obsolete command-line execution and back-end script tracking with a point-and-click graphical interface. The UI introduces dynamic sequence locks to minimize operational errors and provides five dedicated controls:

* **Update Database:** Triggers automatic feature vector indexing, normalization, and file mapping with a live progress dialog.


* **Load Image:** Initiates a visual file browser to instantly render query choices within a preview axis.


* **Search:** Computes distances and returns the top 10 most similar database matches displayed cleanly in a ranked results grid.


* **Clear:** Resets the workspace layout and completely wipes application cache memory matrices.


* **Save Recommendation:** Spawns a dedicated confirmation window featuring a preview icon to duplicate the optimal Rank 1 result directly into a local folder (`img_ext`).
