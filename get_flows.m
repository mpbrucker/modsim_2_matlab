function flows = get_flows(~, U, heat_in_coeff, heat_cap_air, heat_cap_wall, ...
    heat_out_coeff, A_out, A_in, therm_cond, T_out, emis, insol, win_area)
    % Get energy and temperature of inside air and wall
    U_air = U(1);
    U_wall = U(2);
    T_air = energyToTemperature(U_air,heat_cap_air);
    T_wall = energyToTemperature(U_wall,heat_cap_wall);
    
    % Equivalent thermal resistances
    R_in = 1/(1/(heat_in_coeff*A_in)+1/(therm_cond*A_in));
    R_out = 1/(1/(heat_out_coeff*A_out)+1/(therm_cond*A_out));
    
    % Compute flows
    dWalldt = (R_in*(T_air-T_wall))-(R_out*(T_wall-T_out));
    %dAirdt = (emis*insol*win_area) - (R_in*(T_air-T_wall));
    dAirdt = (R_in*(T_wall-T_air));
    flows = [dAirdt;dWalldt];

end