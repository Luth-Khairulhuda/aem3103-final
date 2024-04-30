%	Paper Plane Velocity and Flight Path Angle at
%	Max Lift to Drag Ratio Simulations
%   By Luth Khairulhuda
%	April 30, 2024


%   Initial Conditions for 
%   Equilibrium Glide at Maximum Lift/Drag Ratio
    [V, Gam, H, R] = setup_sim();
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
	tspan	=	[to tf];


%   2a) Varying Inital Velocity
    figure
    subplot(2,1,1)
    title("Varying Paper Plane Initial Velocity", 'FontSize',17);
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
    legend("Low, 2 m/s", "Nominal, 3.55 m/s", "High, 7.5 m/s")

%   2b) Varying Initial Flight Path Angle
    subplot(2,1,2)
    title("Varying Paper Plane Initial Flight Path Angle", 'FontSize',17);
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
    legend("Low, -0.5 rad", "Nominal, -0.18 rad", "High, 0.4 rad")
	
    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperSize', [8 10]);
    set(gcf,'PaperPosition',[0.5 0.5 7 9]);
    set(gcf,'PaperPositionMode','Manual');
    set(gcf,'color','w');
   

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
        plot(x(:,4),x(:,3), "k-", 'HandleVisibility','off')

        % For Part 4 (following rows)
        R_temp = x(:,4);
        H_temp = x(:,3);
        t_temp = transpose(tspan);
        range = cat(1, range, R_temp);
        height = cat(1, height, H_temp);
        time = cat(1, time, t_temp);

    end
    title(["10th Order Polyfit of 100 Randomized", "Initial Values Trajectories"]...
        , "FontSize", 18)
    xlabel('Range, m', 'FontSize',15), ...
        ylabel('Height, m', 'FontSize',15), grid
        set(gcf,'PaperUnits','inches');
    
    set(gcf,'PaperSize', [8 8]);
    set(gcf,'PaperPosition',[0.5 0.5 7 7]);
    set(gcf,'PaperPositionMode','Manual');
    set(gcf,'color','w');


%   4) Average Trajectory
    ord = 10;
    
    % Range Polyfit
    p_r = polyfit(time, range, ord);
    range_fit = polyval(p_r, tspan);

    % Height Polyfit
    p_h = polyfit(time, height, ord);
    height_fit = polyval(p_h, tspan);


    plot(range_fit, height_fit, "c-", "LineWidth", 5,'DisplayName','Average Trajectory')
    axis([0 25 -3 4]);
    legend

%   5) Derivatives
    drange = num_der_central(tspan, range_fit);
    dheight = num_der_central(tspan, height_fit);

    figure
    subplot(2,1,1);
    plot(tspan, drange, "LineWidth", 2);
        xlabel('Time, sec', 'FontSize',12), ...
        ylabel('Range Time Derivative, m/s', 'FontSize',14), grid
        title("Average Trajectory Derivative of Range vs. Time", "FontSize", 17)
    subplot(2,1,2);
    plot(tspan, dheight, "r-", "LineWidth", 2);    
        xlabel('Time, sec', 'FontSize',12), ...
        ylabel('Height Time Derivative, m/s', 'FontSize',14), grid
        title("Average Trajectory Derivative of Height vs. Time", "FontSize", 17)

    set(gcf,'PaperUnits','inches');
    set(gcf,'PaperSize', [8 10]);
    set(gcf,'PaperPosition',[0.5 0.5 7 9]);
    set(gcf,'PaperPositionMode','Manual');
    set(gcf,'color','w');