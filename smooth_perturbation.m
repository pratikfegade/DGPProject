function smooth_pert = smooth_perturbation(perturbation)
    global smooth_iters
    h = fspecial('gaussian',[5,5],1.5);
    smooth_pert = perturbation;
    for i = 1:smooth_iters
        smooth_pert = filter2(h, smooth_pert, 'same');
    end
end