function [penalty] = smoothness_penalty(surface, ~)
    global grid_resolution;
    filt = fspecial('laplacian') * 100;
    padded_surface = padarray(surface, [2,2], 'replicate', 'both');
    padded_surface = padarray(padded_surface, [2,1], 'replicate', 'both');
    lapl = conv2(padded_surface, filt);
    penalty = sum(sum(abs(lapl(4:2*grid_resolution+4, 4:2*grid_resolution+4,1))));
end