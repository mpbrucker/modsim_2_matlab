function val = get_out_temp(t, avg_temp, var)
    
    dr = pi/180; % conversion from degrees to radians
    
    hour_int = t ./ 3600; % Current hour
    day = mod(floor(hour_int ./ 24),365) + 1; % Gets current day of year
    
    day_angle = (360/365)*day*dr;
    val = avg_temp + var .* (-1*cos(day_angle)); 
    % Angle in the sky (in degrees) - convert everything to radians, then
    % convert the answer back to decimals

end