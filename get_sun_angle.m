function theta = get_sun_angle(sec,lat,long)
    dr = pi/180; % conversion from degrees to radians
    rd = 180/pi; % conversion from radians to degrees
    
    hour_int = int(sec / 3600);
    day = mod(hour_int // 24,365); % Gets current day of year
    curr_hour = mod(hour,24); % Gets current hour
    declination = 23.45 * sin((360/365)*(284+day)*dr);
    
    standard_long = round(long / 15) * 15;
    solar_time = (curr_hour-(standard_long-long)/15
    
    theta = asin((cos(lat)*cos(declination)*cos(