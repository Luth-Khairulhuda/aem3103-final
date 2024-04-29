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
    subplot(1,2,1)
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid
    hold on

    Vo = [2, 3.55, 7.5];
    lines = ["r-", "k-", "g-"];
    for i = 1:length(Vo)
	    xo		=	[Vo(i);Gam;H;R];
	    [t,x]	=	ode23('EqMotion',tspan,xo);
        plot(x(:,4),x(:,3), lines(i));
        hold on
    end

%   2b) Varying Initial Flight Path Angle
    subplot(1,2,2)
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid
    hold on

    Gam_o = [-0.5, -0.18, 0.4];
    for i = 1:length(Gam_o)
	    xo		=	[V;Gam_o(i);H;R];
	    [t,x]	=	ode23('EqMotion',tspan,xo);
        plot(x(:,4),x(:,3), lines(i));
        hold on
    end
	
%   3) 100 Tests
    V_min = 2;
    V_max = 7.5;
    Gam_min = -0.5;
    Gam_max = 0.4;
    tspan = linspace(to, tf, 100);
    drl = 100;

    % For part 4 (following 2 rows)
    range = nan*zeros(100);
    height = nan*zeros(100);
    
    figure
    hold on
    for i = 1:drl
        rand_V = V_min + (V_max-V_min)*rand(1);
        rand_Gam = Gam_min + (Gam_max-Gam_min)*rand(1);
        xo		=	[rand_V;rand_Gam;H;R];
	    [t,x]	=	ode23('EqMotion',tspan,xo);
        plot(x(:,4),x(:,3), "k-")

        % For Part 4 (following 2 rows)
        range(:,i) = x(:,4);
        height(:,i) = x(:,3);

    end
    title("Trajectories of 100 Random Initial Velocities and Flight Path Angles")
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid


%   4) Average Trajectory
    time = tspan;
    ord = 10;
    avg_range = nan*(1:100);
    avg_height = nan*(1:100);

    for i = 1:drl
        avg_range(i) = mean(range(i,:));
        avg_height(i) = mean(height(i,:));
    end

    figure
    hold on
    plot(time, avg_range, "k.")
    p_r = polyfit(time, avg_range, ord);
    range_fit = polyval(p_r, time);
    plot(time, range_fit, "b-");

    plot(time, avg_height, "k.")
    p_h = polyfit(time, avg_height, ord);
    height_fit = polyval(p_h, time);
    plot(time, height_fit, "b-");


%   5) Derivatives
    drange = num_der_central(time, range_fit);
    dheight = num_der_central(time, height_fit);

    figure
    subplot(1,2,1);
    plot(time, drange, "LineWidth", 2);
        xlabel('Time, sec', 'FontSize',15), ...
        ylabel('d(Range)/d(time), m/s', 'FontSize',15), grid
        title("Derivative of Range vs. Time", "FontSize", 15)
    subplot(1,2,2);
    plot(time, dheight, "r-", "LineWidth", 2);    
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