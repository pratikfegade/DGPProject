function [penalty] = concavity_penalty(surface, skeleton)
    global grid_resolution
    penalty = 0;
    max_concavity = 100000;
    mask = zeros(size(surface));
    p1s = floor(skeleton(1:2, :) * grid_resolution / 100) + grid_resolution + 1;
    p2s = ceil(skeleton(1:2, :) * grid_resolution / 100) + grid_resolution + 1;
    
    points_1 = p1s(1,:) + (p1s(2,:) - 1) * size(surface, 1);
    points_2 = p2s(1,:) + (p2s(2,:) - 1) * size(surface, 1);
    points_3 = p1s(1,:) + (p2s(2,:) - 1) * size(surface, 1);
    points_4 = p2s(1,:) + (p1s(2,:) - 1) * size(surface, 1);
    
    mask(points_1) = 1;
    mask(points_2) = 1;
    mask(points_3) = 1;
    mask(points_4) = 1;
    
    f = [0.5,1,0.5;1,-6,1;0.5,1,0.5];
    concavity = filter2(f, surface, 'same');
    concavity = concavity .* mask;
    penalty = max([1000-sum(sum(concavity)), 0]);
    
end