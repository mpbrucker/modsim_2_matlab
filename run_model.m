function [t,U,variance] = run_model(tm_amount, input_time)
    time = input_time*60*60*24; %1 day in seconds
    clf;
    % Parameters
    win_area = 30; % m^2
    in_H = 4.572; % m
    in_L = 19.812; % m
    in_W = 12.192; % m
    wall_thick = .15; % m
    wall_density = 600; % kg/m^3
    air_density = 1.225; % kg/m^3
    therm_cond = .1; % Thermal conductivity of walls; W/(m K)
    c_wall = 1200; % Specific heat of walls; J/(kg K)
                    %0.23
    c_tm = 960; % J/(kg K)
    tm = tm_amount; % kg

    % Prescribed values
    win_thick = .0032; % Window thickness (m)
    win_density = 2500; % Window density (kg/m^3)
    insol = 1000; % W/m^2
    emis = .93; % Unitless
    heat_in_coeff = 5; % W/(m^2 K)
    heat_out_coeff = 20; % W/(m^2 K)

    T_out_avg = 282.039; % K
    T_var = 15; % K
    c_air = 1005; % Specific heat of inside air; J/(kg K)
                    %0.005
    c_glass = 670; % Specific heat of glass; J/(kg K)
                    
    % Derived values
    [m_wall,m_air,m_glass,A_out,A_in] = derive_values(win_area, ...
        in_H, in_L, in_W,wall_thick,wall_density, air_density, win_thick, win_density);

    heat_cap_air = m_air*c_air; % J/K
    heat_cap_wall = m_wall*c_wall; % J/K
    heat_cap_glass = m_glass*c_glass;
    heat_cap_tm = tm*c_tm;
    
    T_air_init = 271.5; % K
    T_wall_init = 271.5; % K
    T_win_init = 271.5; % K
    T_tm_init = 271.5;
    U_air_init = T_air_init * heat_cap_air;
    U_wall_init = T_wall_init * heat_cap_wall;
    U_win_init = T_win_init * heat_cap_glass;
    U_tm_init = T_tm_init * heat_cap_tm;
    
    flows_func = @(Ti,Ui) get_flows(Ti,Ui, heat_in_coeff, heat_cap_air, heat_cap_wall, heat_cap_glass, heat_cap_tm, ...
        heat_out_coeff, A_out, A_in, therm_cond, wall_thick, emis, insol, win_area, ...
        T_out_avg, T_var);

    hold on;
    [t,U] = ode23s(flows_func,[0 time],[U_air_init U_wall_init U_win_init U_tm_init]);

    T_air = U(:,1) ./ heat_cap_air;
    %T_air = T_air(2825:2995);
    %t = t(2825:2995);
    %variance = compute_soi(T_air, 291.483, 297.039);

    plot(t ./ (60*60*24),T_air*(9/5)-459.67);
    %xlabel('Time (days)')
    %xlim([0 365])
    %ylabel('Temperature (°F)')
    %title('Inside Temperature over Time')
    
end
