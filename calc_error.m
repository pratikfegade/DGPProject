function [error] = calc_error(surface, skeleton)
    % Global variables
    global gap_penalty_multiplier collision_penalty_multiplier
    global smoothness_penalty_multiplier concavity_penalty_multiplier prior_penalty_multiplier

    error = 0;
    
    error = error + gap_penalty_multiplier * gap_penalty(surface, skeleton);
    error = error + collision_penalty_multiplier * collision_penalty(surface, skeleton);
    error = error + smoothness_penalty_multiplier * smoothness_penalty(surface, skeleton);
    error = error + concavity_penalty_multiplier * concavity_penalty(surface, skeleton);
    error = error + prior_penalty_multiplier * prior_penalty(surface, skeleton);
end