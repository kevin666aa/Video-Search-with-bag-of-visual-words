

query = 5;
load("hist.mat", "hist");

query = hist(5, :);



[~,inx]=sort(B(1,:));
out = B(:,inx);