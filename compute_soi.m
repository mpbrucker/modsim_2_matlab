% compute_soi (T,low,high)
% Given a range of temperatuers T (in Kelvin), computes the deviation
% outside a particular range
function dev = compute_soi(T,low,high)
    total_diff = 0;
    for i=1:length(T)
        en = T(i);
        if (sign((en-high)*(en-low)) == 1) % If the number is outside the range
            dev = min([abs(en-high) abs(en-low)])^2; % Compute the closer deviation squared
            total_diff = total_diff + dev;
        end        
    end
    dev = sqrt(total_diff/length(T)); % Standardize for number of values