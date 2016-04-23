function [new_surf, error] = perform_grad_descent(surface, skeleton, error_function, n_iters)
    global descent_multiplier;
    descent_multiplier = 1;
    new_surf = surface;
    error = 0;
    for i = 1:n_iters
        [new_surf, error] = grad_descent(new_surf, skeleton, error_function);
        error
    end
end