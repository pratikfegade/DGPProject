function [smooth_surf] = smoothen_surface(surface)
    global smooth_iters
    h = fspecial('gaussian');
    smooth_surf = surface;
    for i = 1:smooth_iters
        tmp = filter2(h, smooth_surf, 'valid');
        ss = size(tmp);
        bs = size(smooth_surf);
        del = (bs - ss) / 2;
        smooth_surf(1+del(1):(ss(1)+del(1)), 1+del(2):(ss+del(2))) = tmp;
    end
end