function flows = get_flows(t, U, heat_in_coeff, heat_cap_air, heat_cap_wall, heat_cap_glass, heat_cap_tm, ...
    heat_out_coeff, A_out, A_in, therm_cond, wall_thick, emis, insol, win_area, T_out_avg, T_var)
    theta = get_sun_angle(t,42.2809,71.2378); % Angle of the sun for Needham, MA
    % Get energy and temperature of inside air and wall
    U_air = U(1);
    U_wall = U(2);
    U_win = U(3);
    U_tm = U(4);
    
    T_air = energyToTemperature(U_air,heat_cap_air);
    T_wall = energyToTemperature(U_wall,heat_cap_wall);
    T_win = energyToTemperature(U_win,heat_cap_glass);
    T_tm = energyToTemperature(U_tm,heat_cap_tm);
    T_out = get_out_temp(t,T_out_avg,T_var);
    % Equivalent thermal resistances
    R_in = 1/(1/(heat_in_coeff*A_in) + (wall_thick/(therm_cond*A_in)));
    R_out = 1/(1/(heat_out_coeff*A_out) + (wall_thick/(therm_cond*A_out)));
    % Compute flows
    dWalldt = (R_in*(T_air-T_wall))-(R_out*(T_wall-T_out));
    if (theta > 0 && theta < 90)
        radiation_energy = (insol*emis*win_area)*(theta/90); % Account for angle of sun
    else
        radiation_energy = 0;
    end
    dWindt = radiation_energy - (heat_out_coeff*win_area*(T_win-T_out)) - (heat_in_coeff*win_area*(T_win-T_air));
    dAirdt = (heat_in_coeff*win_area*(T_win-T_air)) - (R_in*(T_air-T_wall)) - heat_cap_tm*(T_air - T_tm);
    dTMdt = heat_cap_tm*(T_air - T_tm);
    flows = [dAirdt;dWalldt;dWindt;dTMdt];
end