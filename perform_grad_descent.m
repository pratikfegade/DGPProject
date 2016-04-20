function [new_surf, error] = perform_grad_descent(surface, skeleton)
    global descent_iters
    new_surf = surface;
    for i = 1:descent_iters
        [new_surf, error] = grad_descent(new_surf, skeleton);
    end
end