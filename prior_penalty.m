function [penalty] = prior_penalty(surface, skeleton)
    penalty = 0;
    global grid_resolution;
    sofa = zeros(2*grid_resolution + 1);
    x1 = -floor(grid_resolution / 10 * 5); x2 = floor(grid_resolution / 10); x3 = -floor(grid_resolution / 10 * 4);
    y1 = -floor(grid_resolution / 10 * 5); y2 = floor(grid_resolution / 10 * 5);
    sofa(x1+grid_resolution:x2+grid_resolution, y1+grid_resolution:y2+grid_resolution) = 1;
    sofa(x1+grid_resolution:x3+grid_resolution, y1+grid_resolution:y2+grid_resolution) = 3;
    
    v = surface .* sofa;
    penalty = max(-sum(v(:))/(norm(surface(:)) * norm(sofa(:))), -0.85); % 0.85 is a tuned parameter
end