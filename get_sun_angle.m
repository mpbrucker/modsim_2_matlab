function theta = get_sun_angle(sec,lat,long)
    
    dr = pi/180; % conversion from degrees to radians
    rd = 180/pi;
    
    hour_int = sec/3600; % Current hour
    day = mod(floor(hour_int/24),365) + 1; % Gets current day of year
    hour_now = mod(hour_int,24); % Gets current hour
    curr_min = hour_now * 60; % current minute
    
    % Find values of things.  Note that everything is in degrees.
    declination = 23.45 * sin((360/365)*(284+day)*dr); % Declination
    standard_long = round(long / 15) * 15; % Standard longitude
    D = (360/365)*(day-81); % Day for the time equation
    time_eq = (9.87*sin(2*D*dr)) - (7.53 * cos(D*dr)) - (1.5 * sin(D*dr)); % time equation
    solar_time = curr_min + 4*(standard_long-long) + time_eq; % solar time
    hour_angle = ((solar_time-720)/4); % Hour angle
    
    % Angle in the sky (in degrees) - convert everything to radians, then
    % convert the answer back to decimals
    theta = asin((cos(dr*lat)*cos(dr*declination)*cos(dr*hour_angle) + sin(dr*lat)*sin(dr*declination)))*rd;
end