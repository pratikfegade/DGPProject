function [penalty] = smoothness_penalty(surface, ~)
    global grid_resolution;
    padded_surface = padarray(surface, [2,2], 'replicate', 'both');
    padded_surface = padarray(padded_surface, [2,1], 'replicate', 'both');
    lapl = conv2(padded_surface, [0,1,0;1,-4,1;0,1,0]);
    penalty = sum(sum(abs(lapl(4:2*grid_resolution+4, 4:2*grid_resolution+4,1))));
end