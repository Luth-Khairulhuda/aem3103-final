%	Example 1.3-1 Paper Airplane Flight Path
%	Copyright 2005 by Robert Stengel
%	August 23, 2005

	
% %	a) Equilibrium Glide at Maximum Lift/Drag Ratio
%   [V, Gam, H, R] = setup_sim();
% 	to		=	0;			% Initial Time, sec
% 	tf		=	6;			% Final Time, sec
% 	tspan	=	[to tf];
% 	xo		=	[V;Gam;H;R];
% 	[ta,xa]	=	ode23('EqMotion',tspan,xo);



%   Initial Conditions for 
%   Equilibrium Glide at Maximum Lift/Drag Ratio
    [V, Gam, H, R] = setup_sim();
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
	tspan	=	[to tf];


%   2a) Varying Inital Velocity
    figure
    subplot(2,1,1)
    title("Varying Initial Velocity", 'FontSize',15);
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid
    hold on

    Vo = [2, 3.55, 7.5];
    lines = ["r-", "k-", "g-"];
    for i = 1:length(Vo)
	    xo		=	[Vo(i);Gam;H;R];
	    [t,x]	=	ode23('EqMotion',tspan,xo);
        plot(x(:,4),x(:,3), lines(i), "LineWidth",2);
        hold on
    end

%   2b) Varying Initial Flight Path Angle
    subplot(2,1,2)
    title("Varying Initial Flight Path Angle", 'FontSize',15);
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid
    hold on

    Gam_o = [-0.5, -0.18, 0.4];
    for i = 1:length(Gam_o)
	    xo		=	[V;Gam_o(i);H;R];
	    [t,x]	=	ode23('EqMotion',tspan,xo);
        plot(x(:,4),x(:,3), lines(i), "LineWidth",2);
        hold on
    end
	
%   3) 100 Tests
    V_min = 2;
    V_max = 7.5;
    Gam_min = -0.5;
    Gam_max = 0.4;
    tspan = linspace(to, tf, 100);
    drl = 100;
    range = [];
    height = [];
    time = [];
    
    figure
    hold on
    for i = 1:drl
        rand_V = V_min + (V_max-V_min)*rand(1);
        rand_Gam = Gam_min + (Gam_max-Gam_min)*rand(1);
        xo		=	[rand_V;rand_Gam;H;R];
	    [t,x]	=	ode23('EqMotion',tspan,xo);
        plot(x(:,4),x(:,3), "k-")

        % For Part 4 (following rows)
        R_temp = x(:,4);
        H_temp = x(:,3);
        t_temp = transpose(tspan);
        range = cat(1, range, R_temp);
        height = cat(1, height, H_temp);
        time = cat(1, time, t_temp);

    end
    title(["10th Order Polyfit of 100 Randomized", "Initial Values Trajectories"]...
        , "FontSize", 15)
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid


%   4) Average Trajectory
    ord = 10;
    
    % Range Polyfit
    p_r = polyfit(time, range, ord);
    range_fit = polyval(p_r, tspan);

    % Height Polyfit
    p_h = polyfit(time, height, ord);
    height_fit = polyval(p_h, tspan);


    plot(range_fit, height_fit, "c-", "LineWidth", 5)
    axis([0 25 -3 4]);

%   5) Derivatives
    drange = num_der_central(tspan, range_fit);
    dheight = num_der_central(tspan, height_fit);

    figure
    subplot(2,1,1);
    plot(tspan, drange, "LineWidth", 2);
        xlabel('Time, sec', 'FontSize',15), ...
        ylabel('d(Range)/d(time), m/s', 'FontSize',15), grid
        title("Derivative of Range vs. Time", "FontSize", 15)
    subplot(2,1,2);
    plot(tspan, dheight, "r-", "LineWidth", 2);    
        xlabel('Time, sec', 'FontSize',15), ...
        ylabel('d(Height)/d(time), m', 'FontSize',15), grid
        title("Derivative of Height vs. Time", "FontSize", 15)


%     Extra Stuff

%     plot(avg_range,avg_height, "r-", "LineWidth", 5);

%     xo		=	[V;Gam;H;R];
%     [t,x]	=	ode23('EqMotion',tspan,xo);
% 
%     plot(x(:,4),x(:,3), "b-", "LineWidth", 5);
% 
%     figure
%     subplot(1,2,1)
%     plot(time, avg_range);
% 
%     subplot(1,2,2)
%     plot(time, avg_height);


	


% Notes:
% 3) randomly pick velocity and flight path angle in their range
% and simulate all 100
% Other) Can remove the parameter figures (4 subpots)