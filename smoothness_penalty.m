function [penalty] = smoothness_penalty(surface, skeleton)
    global grid_resolution;
    padded_surface = padarray(surface, [2,2], 'replicate', 'both');
    padded_surface = padarray(padded_surface, [2,1], 'replicate', 'both');
    vert_c = conv2(padded_surface, [-1,0,1;-2,0,2;-1,0,1]);
    horz_c = conv2(padded_surface, [-1, -2, -1; 0,0,0; 1,2,1]);
    penalty = sum(sum(abs(vert_c(4:2*grid_resolution+4, 4:2*grid_resolution+4,1)))) + sum(sum(abs(norm(horz_c(4:2*grid_resolution+4, 4:2*grid_resolution+4),1))));
end