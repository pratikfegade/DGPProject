function [penalty] = gap_penalty(surface, skeleton)
    global grid_resolution
    
    p1s = floor(skeleton(1:2, :) * grid_resolution / 100) + grid_resolution + 1;
    p2s = ceil(skeleton(1:2, :) * grid_resolution / 100) + grid_resolution + 1;
    
    points_1 = sub2ind(size(surface), p1s(1,:), p1s(2,:));
    points_2 = sub2ind(size(surface), p2s(1,:), p2s(2,:));
    points_3 = sub2ind(size(surface), p1s(1,:), p2s(2,:));
    points_4 = sub2ind(size(surface), p2s(1,:), p1s(2,:));
    
    avg_vals = (surface(points_1) + surface(points_2) + surface(points_3) + surface(points_4)) / 4;
    
    penalty = sum(abs(avg_vals - skeleton(3,:)));
end