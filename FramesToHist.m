function FramesToHist

addpath('./provided_code/');

framesdir = './provided_code/frames/';
siftdir = './provided_code/sift/';

fnames = dir([siftdir '/*.mat']);

load('kMeans.mat', "kMeans");
vocab = kMeans;  % get vocabulary

% initialize hist, hist would be a k*1500 matrix where k is num of frames
hist_frames = zeros([length(fnames), 1500]);

for i=1:length(fnames)
    % load that file
    fname = [siftdir fnames(i).name];
    load(fname, 'descriptors');
    disp(i);
    if size(descriptors,1) == 0
        continue
    end
    
    freq = zeros([1, 1500]);
    
    dist = dist2(descriptors, vocab); % cacluate dist matrix
    [~, x] = min(dist, [], 2) ; % x is the col ind of the max val
    
    [GC,GR] = groupcounts(x);
    freq(GR) = GC;
    hist_frames(i, :) = freq;
    
end

save("hist_frames");





