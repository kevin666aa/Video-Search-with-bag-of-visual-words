function full_frame_queries
    addpath('./provided_code/');
    framesdir = './provided_code/frames/';
    siftdir = './provided_code/sift/';
    fnames = dir([siftdir '/*.mat']);
    load("hist_frames.mat", "hist_frames");


    qs = [5 56 567];

    for j = 1 : 3
        q = qs(j);
        query = hist_frames(q, :);
        load([siftdir fnames(q).name], 'imname');

        
        dist = dist2(query, hist_frames)';
        [~,inx]=sort(dist(:, 1));


        fig = figure(j);
        for i = 1 : 6
           curind = inx(i);
           load([siftdir fnames(curind).name], 'imname');
           subplot(3, 2, i);
           imshow([framesdir imname]);
           if i == 1
               title(["query image" j]);
           end

           if i ~= 1
               title(["match image" i - 1]);
           end

        end
        saveas(fig, ['(3)fig' j '.jpg']);

    end
end