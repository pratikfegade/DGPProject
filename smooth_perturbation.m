function smooth_pert = smooth_perturbation(perturbation, h)
    global smooth_iters
    smooth_pert = perturbation;
    for i = 1:smooth_iters
        smooth_pert = filter2(h, smooth_pert, 'same');
    end
end