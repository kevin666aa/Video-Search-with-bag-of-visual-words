function FramesToHist

addpath('./provided_code/');

framesdir = './provided_code/frames/';
siftdir = './provided_code/sift/';

fnames = dir([siftdir '/*.mat']);

load('twoFrameData.mat', "kMeans");
vocab = kMeans;  % get vocabulary

% initialize hist, hist would be a k*1500 matrix where k is num of frames
hist = zeros([length(fnames), 1500]);

for i=1:length(fnames)
    % load that file
    fname = [siftdir fnames(i).name];
    load(fname, 'descriptors');
    
    if size(descriptors,1) == 0
        continue
    end
    
    freq = zeros([1, 1500]);
    
    dist = dist2(descriptors, vocab); % cacluate dist matrix
    [~, x] = max(dist, [], 2) ; % x is the col ind of the max val
    
    [GC,GR] = groupcounts(x);
    freq(GR) = GC;
    hist(i, :) = freq;
    
end

save("hist");





