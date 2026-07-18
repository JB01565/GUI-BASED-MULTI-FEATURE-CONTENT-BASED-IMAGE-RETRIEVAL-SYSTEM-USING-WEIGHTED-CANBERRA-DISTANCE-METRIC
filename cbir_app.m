function cbir_app
    % Main Window
    fig = uifigure('Name', 'ECE 414: Improved CBIR System', 'Position', [100 100 1200 750], 'Color', [0.15 0.17 0.2]);

    % Sidebar
    sidebar = uipanel(fig, 'Position', [0 0 280 750], 'BackgroundColor', [0.2 0.23 0.27], 'BorderType', 'none');
    uilabel(sidebar, 'Text', 'CBIR CONTROLS', 'Position', [20 680 240 40], 'FontSize', 20, 'FontColor', 'white', 'HorizontalAlignment', 'center');

    btnLoad = uibutton(sidebar, 'Text', 'LOAD IMAGE', 'Position', [30 580 220 50], 'BackgroundColor', [0.3 0.35 0.4], 'FontColor', 'white', 'ButtonPushedFcn', @(btn,e) loadQuery());
    btnSearch = uibutton(sidebar, 'Text', 'SEARCH', 'Position', [30 510 220 50], 'BackgroundColor', [0.2 0.5 0.2], 'FontColor', 'white', 'Enable', 'off', 'ButtonPushedFcn', @(btn,e) runSearch());
    uibutton(sidebar, 'Text', 'CLEAR', 'Position', [30 440 220 50], 'BackgroundColor', [0.6 0.2 0.2], 'FontColor', 'white', 'ButtonPushedFcn', @(btn,e) clearAll());
    
    lblStatus = uilabel(sidebar, 'Text', 'Ready', 'Position', [20 380 240 30], 'FontColor', [0.7 0.7 0.7], 'HorizontalAlignment', 'center');

    % Query Display Area
    qPanel = uipanel(fig, 'Title', 'QUERY', 'Position', [310 450 300 270]);
    axQuery = uiaxes(qPanel, 'Position', [10 10 280 230]);
    set(axQuery, 'XTick', [], 'YTick', []);

    % Results Grid
    rPanel = uipanel(fig, 'Title', 'TOP RESULTS', 'Position', [310 20 860 410]);
    resAxes = [];
    for i = 1:10
        col = mod(i-1, 5); row = floor((i-1)/5);
        resAxes(i) = uiaxes(rPanel, 'Position', [15 + (col*165), 20 + (1-row)*185, 150, 160]);
        set(resAxes(i), 'XTick', [], 'YTick', []);
    end

    appData = struct('queryImg', []);

    function loadQuery()
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp'});
        if isequal(file, 0), return; end
        appData.queryImg = imread(fullfile(path, file));
        imshow(appData.queryImg, 'Parent', axQuery);
        btnSearch.Enable = 'on';
        lblStatus.Text = 'Image Loaded';
    end

    function runSearch()
        lblStatus.Text = 'Searching...'; drawnow;
        
        % 1. Get raw features
        fRaw = featureVector(appData.queryImg);
        
        % 2. Load database and scales
        load('fvect.mat', 'fvect', 'f_min', 'f_max');
        
        % 3. NORMALIZE QUERY [The Improvement]
        fQuery = (fRaw - f_min) ./ (f_max - f_min + eps);
        
        % 4. Distances
        imgpath = 'image.orig';
        imgFiles = dir(fullfile(imgpath, '*.jpg'));
        validFiles = imgFiles(~startsWith({imgFiles.name}, '.'));
        
        dists = zeros(length(validFiles), 1);
        for j = 1:length(validFiles)
            dists(j) = euclid(fQuery, fvect(j, :));
        end
        
        [~, idx] = sort(dists, 'ascend');
        for k = 1:10
            imshow(imread(fullfile(imgpath, validFiles(idx(k)).name)), 'Parent', resAxes(k));
            title(resAxes(k), sprintf('Dist: %.3f', dists(idx(k))));
        end
        lblStatus.Text = 'Search Complete';
    end

    function clearAll()
        cla(axQuery);
        for k = 1:10, cla(resAxes(k)); end
        btnSearch.Enable = 'off';
        lblStatus.Text = 'Cleared';
    end
end