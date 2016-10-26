function flows = get_flows(t, U, heat_in_coeff, heat_cap_air, heat_cap_wall, ...
    heat_out_coeff, A_out, A_in, therm_cond, T_out, wall_thick, emis, insol, win_area)
    theta = get_sun_angle(t,33.43,112); % Angle of the sun
    % Get energy and temperature of inside air and wall
    U_air = U(1);
    U_wall = U(2);
    T_air = energyToTemperature(U_air,heat_cap_air);
    T_wall = energyToTemperature(U_wall,heat_cap_wall);
    
    % Equivalent thermal resistances
    R_in = 1/(1/(heat_in_coeff*A_in)+ (wall_thick/(therm_cond*A_in)));
    R_out = 1/(1/(heat_out_coeff*A_out)+ (wall_thick/(therm_cond*A_out)));
    % Compute flows
    dWalldt = (R_in*(T_air-T_wall))-(R_out*(T_wall-T_out));
    
    radiation_energy = 0; % Energy from radiation
    if (theta > 0 && theta < 90)
        radiation_energy = (insol*emis*win_area)*(theta/90); % Account for angle of sun
    else
        radiation_energy = 0;
    end
    dAirdt = radiation_energy - (R_in*(T_air-T_wall));
    flows = [dAirdt;dWalldt];
    display(flows);

end