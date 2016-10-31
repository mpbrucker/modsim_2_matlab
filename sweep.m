function vars = sweep(min_tm, max_tm, input_time)
    n = 100;
    tm_amounts = linspace(min_tm, max_tm, n);
    vars = zeros(1, n);
    
    for i = 1:n
        [~,~,variance] = run_model(tm_amounts(i), input_time);
        vars(i) = variance;
    end
    plot(tm_amounts, vars,'LineWidth',2)
    xlabel('Thermal mass (kg)');
    ylabel('Temperature variation');
    title('Solar house temperature variation with various thermal masses');
end