function vars = sweep(min_tm, max_tm, input_time)
    n = 100;
    tm_amounts = linspace(min_tm, max_tm, n);
    vars = zeros(1, n);
    lowest_tm = 0;
    
    for i = 1:n
        [~,~,variance] = run_model(tm_amounts(i), input_time);
        vars(i) = variance;
        if (vars(i) < 0.01 && lowest_tm ~= 0)
            lowest_tm = vars(i);
        end
    end
    plot(tm_amounts, vars,'LineWidth',2)
    hold on;
    line([lowest_tm lowest_tm],[0 1]);
    xlabel('Thermal mass (kg)');
    ylabel('Temperature variation');
    title('Solar house temperature variation with various thermal masses');
end