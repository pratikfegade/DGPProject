function [fin_surface, fin_error] = grad_descent(surface, skeleton, error_function)
    global descent_multiplier;
    h = fspecial('gaussian',[5,5],1.5);
    prev_error = error_function(surface, skeleton);
    base_error = prev_error;
    grad = get_gradient(surface, skeleton, error_function);
    current_error = error_function(surface - descent_multiplier * grad, skeleton);
    while current_error < prev_error
        descent_multiplier = descent_multiplier * 2;
        prev_error = current_error;
        current_error = error_function(surface - descent_multiplier * grad, skeleton);
    end
    
    while current_error > base_error
        descent_multiplier = descent_multiplier / 2;
        current_error = error_function(surface - descent_multiplier * grad, skeleton);
    end
    
    fin_surface = surface - smooth_perturbation(descent_multiplier * grad, h);
    fin_error = current_error;
end