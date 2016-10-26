function [t,U] = run_model(input_time)
    time = input_time*60*60*24; %1 day in seconds

    clf;
    % Parameters
    win_area = 30; % m^2
    in_H = 3; % m
    in_L = 10; % m
    in_W = 3; % m
    wall_thick = .25; % m
    wall_density = 2400; % kg/m^3
    air_density = 1.225; % kg/m^3
    therm_cond = .55; % Thermal conductivity of walls; W/(m K)
    c_wall = 960; % Specific heat of walls; J/(kg K)
                    %0.23
    

    % Prescribed values
    win_thick = .0032; % Window thickness (m)
    win_density = 2500; % Window density (kg/m^3)
    insol = 1000; % W/m^2
    emis = .93; % Unitless
    heat_in_coeff = 5; % W/(m^2 K)
    heat_out_coeff = 20; % W/(m^2 K)

    T_out = 293; % K
    c_air = 1005; % Specific heat of inside air; J/(kg K)
                    %0.005
    c_glass = 670; % Specific heat of glass; J/(kg K)
                    
    % Derived values
    [m_wall,m_air,m_glass,A_out,A_in] = derive_values(win_area, ...
        in_H, in_L, in_W,wall_thick,wall_density, air_density, win_thick, win_density);

    heat_cap_air = m_air*c_air; % J/K
    heat_cap_wall = m_wall*c_wall; % J/K
    heat_cap_glass = m_glass*c_glass;
    
    T_air_init = 273; % K
    T_wall_init = 273; % K
    T_win_init = 273; % K
    U_air_init = T_air_init * heat_cap_air;
    U_wall_init = T_wall_init * heat_cap_wall;
    U_win_init = T_win_init * heat_cap_glass;
    
    flows_func = @(Ti,Ui) get_flows(Ti,Ui, heat_in_coeff, heat_cap_air, heat_cap_wall, heat_cap_glass, ...
        heat_out_coeff, A_out, A_in, therm_cond, T_out, wall_thick, emis, insol, win_area);

    [t,U] = ode45(flows_func,[0 time],[U_air_init U_wall_init U_win_init]);
    T_wall = U(:,2) ./ heat_cap_wall;
    T_air = U(:,1) ./ heat_cap_air;
    %display(T_air(1));
    %display (T_wall(1));
    plot(t ./ (60*60*24),T_air-273);
    soi = compute_soi(T_air,0,10);
    display(soi);
    hold on
   % plot(t,U_air);
    
end
