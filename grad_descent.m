function [fin_surface, fin_error] = grad_descent(surface, skeleton)
    global descent_multiplier;
    prev_error = calc_error(surface, skeleton);
    base_error = prev_error;
    grad = get_gradient(surface, skeleton);
    current_error = calc_error(surface - smooth_perturbation(descent_multiplier * grad), skeleton);
    while current_error < prev_error
        descent_multiplier = descent_multiplier * 2;
        prev_error = current_error;
        current_error = calc_error(surface - smooth_perturbation(descent_multiplier * grad), skeleton);
    end
    
    while current_error > base_error
        descent_multiplier = descent_multiplier / 2;
        prev_error = current_error;
        current_error = calc_error(surface - smooth_perturbation(descent_multiplier * grad), skeleton);
    end
    
    fin_surface = surface - smooth_perturbation(descent_multiplier * grad);
    fin_error = current_error;
end