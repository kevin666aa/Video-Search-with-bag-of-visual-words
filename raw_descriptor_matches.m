function raw_descriptor_matches
    addpath('./provided_code/');
    load("twoFrameData.mat");
    
    figure(1);
    selectinds = selectRegion(im1, positions1);
    selectdes = descriptors1(selectinds, :);
    edists = dist2(selectdes, descriptors2);
    %disp(min(edists, [], 2));
    
    edists = edists < 0.15;
    [row, col] = find(edists == 1);
    col = unique(col);
    
    figure(2);
    imshow(im2)
    displaySIFTPatches(positions2(col, :), scales2(col), orients2(col), im2);