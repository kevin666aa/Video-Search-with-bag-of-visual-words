function visualize_vocabulary
    addpath('./provided_code/');
    framesdir = './provided_code/frames/';
    siftdir = './provided_code/sift/';
    fnames = dir([siftdir '/*.mat']);

    subf  = fnames(randi(6612, 2000, 1));
    subdes = [];
    subpos = [];
    subscl = [];
    subori = [];
    subimn = [];
    
    for i=1:length(subf)
        % load that file
        fname = [siftdir '/' subf(i).name];
        disp(i);
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
        if (size(descriptors, 1)) > 200
            indicies = randi(size(descriptors, 1), 200, 1);
            subdes = [subdes; descriptors(indicies, :)];
            subpos = [subpos; positions(indicies, :)];
            subscl = [subscl; scales(indicies, :)];
            subori = [subori; orients(indicies, :)];
            subimn = [subimn; repmat(imname, [200, 1])];
        end
    end
    
    subdes = subdes';
    
    %disp
    disp(size(subdes, 2));
    
    [membership,kMeans,~] = kmeansML(1500, subdes);
    kMeans = kMeans';
    save("kMeans.mat", "kMeans");
    w = randi(1500, 2, 1);
    ind1 = find(membership == w(1));
    ind2 = find(membership == w(2));
    
    
    fig1 = figure(1);
    for i = 1:25
        gscale = rgb2gray(imread([framesdir subimn(ind1(i), :)]));
        patch = getPatchFromSIFTParameters(subpos(ind1(i), :), subscl(ind1(i), :), subori(ind1(i), :), gscale);
        subplot(5, 5, i);
        imshow(patch);
    end
    saveas(fig1, '(2)fig_1.jpg');
    
    fig2 = figure(2);
    for i = 1:25
        gscale = rgb2gray(imread([framesdir subimn(ind2(i), :)]));
        patch = getPatchFromSIFTParameters(subpos(ind2(i), :), subscl(ind2(i), :), subori(ind2(i), :), gscale);
        subplot(5, 5, i);
        imshow(patch);
    end
    saveas(fig2, '(2)fig_2.jpg');
    
    
    %means = kMeans(randi);
    
    