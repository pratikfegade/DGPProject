function [penalty] = prior_penalty(surface, skeleton)
    penalty = 0;
    global grid_resolution;
    sofa = zeros(2*grid_resolution + 1);
    offset = floor(2 * grid_resolution / 10);
    width = floor((2 * grid_resolution / 10) * 8);
    sofa(offset:(offset+width), offset:(offset+width)) = 1;
    sofa(offset:(offset+floor(width/4)), offset:(offset+width)) = 4;
    
    v = surface .* sofa;
    penalty = max([-100000-sum(sum(v)), 0]);
end