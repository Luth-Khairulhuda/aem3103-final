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

        % For Part 4
        range(:,i) = x(:,4);
        height(:,i) = x(:,3);

    end
    title("Trajectories of 100 Random Initial Velocities and Flight Path Angles")
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid


%   4) Average Trajectory
    time = tspan;
    avg_range = nan*(1:100);
    avg_height = nan*(1:100);

    for i = 1:drl
        avg_range(i) = mean(range(i,:));
        avg_height(i) = mean(height(i,:));
    end

    plot(avg_range,avg_height, "r-", "LineWidth", 5);

    xo		=	[V;Gam;H;R];
    [t,x]	=	ode23('EqMotion',tspan,xo);

    plot(x(:,4),x(:,3), "b-", "LineWidth", 5);


% %	b) Oscillating Glide due to Zero Initial Flight Path Angle
% 	xo		=	[V;0;H;R];
% 	[tb,xb]	=	ode23('EqMotion',tspan,xo);
% 
% %	c) Effect of Increased Initial Velocity
% 	xo		=	[1.5*V;0;H;R];
% 	[tc,xc]	=	ode23('EqMotion',tspan,xo);
% 
% %	d) Effect of Further Increase in Initial Velocity
% 	xo		=	[3*V;0;H;R];
% 	[td,xd]	=	ode23('EqMotion',tspan,xo);
	

% 	figure
% 	subplot(2,2,1)
% 	plot(ta,xa(:,1),tb,xb(:,1),tc,xc(:,1),td,xd(:,1))
% 	xlabel('Time, s'), ylabel('Velocity, m/s'), grid 
% 	subplot(2,2,2)
% 	plot(ta,xa(:,2),tb,xb(:,2),tc,xc(:,2),td,xd(:,2))
% 	xlabel('Time, s'), ylabel('Flight Path Angle, rad'), grid
% 	subplot(2,2,3)
% 	plot(ta,xa(:,3),tb,xb(:,3),tc,xc(:,3),td,xd(:,3))
% 	xlabel('Time, s'), ylabel('Altitude, m'), grid
% 	subplot(2,2,4)
% 	plot(ta,xa(:,4),tb,xb(:,4),tc,xc(:,4),td,xd(:,4))
% 	xlabel('Time, s'), ylabel('Range, m'), grid

% Notes:
% 3) randomly pick velocity and flight path angle in their range
% and simulate all 100
% Other) Can remove the parameter figures (4 subpots)