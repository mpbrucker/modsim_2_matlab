function theta = get_sun_angle(sec,lat,long)
    
    dr = pi/180; % conversion from degrees to radians
    
    hour_int = idivide(sec,3600);
    day = mod(idivide(hour_int,24),365); % Gets current day of year
    curr_hour = mod(hour,24); % Gets current hour
    curr_min = curr_hour * 60; % current minute
    declination = 23.45 * sin((360/365)*(284+day)*dr);
    
    standard_long = round(long / 15) * 15; % Standard longitude
    D = (360/365)*(day-81); % Day for the time equation
    time_eq = 9.87*sin(2*D) - 7.53 * cos(D) - 1.5 * sin(D) % time equation
    solar_time = curr_min + 4*(standard_long-long) + time_eq; % solar time
    hour_angle = (solar_time-720)/4; % Hour angle
    
    % Supposed angle in the sky?
    theta = asin((cos(lat)*cos(declination)*cos(hour_angle) + sin(lat)*sin(declination)));
end