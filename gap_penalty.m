function [penalty] = gap_penalty(surface, skeleton)
    global grid_resolution
    
    penalty = 0;
    for i = 1:size(skeleton, 2)
        ske_pt = skeleton(:, i);
        p1 = floor(ske_pt(1:2) * grid_resolution / 100) + grid_resolution + 1;
        p2 = ceil(ske_pt(1:2) * grid_resolution / 100) + grid_resolution + 1;
        p3 = [p1(1); p2(2)];
        p4 = [p2(1); p1(2)];
        avg = (surface(p1(1), p1(2)) ...
            + surface(p2(1), p2(2)) ...
            + surface(p3(1), p3(2)) ...
            + surface(p4(1), p4(2))) / 4;
        
        %if avg < ske_pt(3)
            penalty = penalty + abs(ske_pt(3) - avg);
        %end
    end
end