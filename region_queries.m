function region_queries
    addpath('./provided_code/');
    framesdir = './provided_code/frames/';
    siftdir = './provided_code/sift/';
    fnames = dir([siftdir '/*.mat']);
    load("hist_frames.mat", "hist_frames");
    load('kMeans.mat', "kMeans");
    vocab = kMeans;  % get vocabulary

    qs = [2383 1542 5572];
% 76 562 567
    for j = 1 : 3
        % load image & data
        q = qs(j);
        load([siftdir fnames(q).name], 'imname', 'positions', 'descriptors');
        im = imread([framesdir imname]);
        
        % select region, get descriptors
        fig = figure(j);
        subplot(3, 2, 1);
        title(["query image" j]);
        selectinds = selectRegion(im, positions);
        selectdes = descriptors(selectinds, :);

        % caculate histogram of the region
        freq = zeros([1, 2000]);
        dist = dist2(selectdes, vocab); % cacluate dist matrix
        [~, x] = min(dist, [], 2) ; % x is the col ind of the max val
        [GC,GR] = groupcounts(x);
        freq(GR) = GC;
        
        disp([size(freq,1), size(freq, 2)]);
        % compare freq with hist of all frames, sort score
        dist = abs(normprod(freq, hist_frames') - normprod(freq, freq'))';
        [~,inx]=sort(dist(:, 1));

        for i = 1 : 5
           curind = inx(i);
           load([siftdir fnames(curind).name], 'imname');
           subplot(3, 2, i+1);
           imshow([framesdir imname]);
           
           title(["match image" i]);
        end
        saveas(fig, ['(4)fig' j '.jpg'])

    end

end