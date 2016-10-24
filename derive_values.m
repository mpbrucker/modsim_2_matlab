% Calculate derived values based on parameters
function [m_wall,m_air,A_out,A_in] = derive_values (...
    win_area, in_H, in_L, in_W,wall_thick,wall_density, air_density)
    
    % Volume and mass of internal air and walls
    V_wall = ((in_L * in_H) + ((in_L*in_H)-win_area)  ...
        + 2*((in_W+2*wall_thick) *in_H) + (in_L*in_H)) * wall_thick; % m^3
    m_wall = V_wall * wall_density; % kg
    V_air = in_L*in_H*in_W; % m^3
    m_air = V_air*air_density; % kg
    
    %Outside/inside surface area
    A_out = 2*((in_W+2*wall_thick)*(in_H+wall_thick))+((in_L+2*wall_thick) ...
        *(in_H+wall_thick)) + ((in_L+2*wall_thick)*(in_H+wall_thick)) + ...
        ((in_L+2*wall_thick)*(in_W+2*wall_thick)); % m^2
    A_in = 2*(in_L*in_H + in_W*in_H + in_L*in_W); % m^2
end