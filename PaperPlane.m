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
    xlabel('Range, m'), ylabel('Height, m'), grid
    hold on

    Vo = [2, 3.55, 7.5];
    lines = ["r-", "k-", "g-"];
    for i = 1:length(Vo)
	    xo		=	[Vo(i);Gam;H;R];
	    [ta,xa]	=	ode23('EqMotion',tspan,xo);
        plot(xa(:,4),xa(:,3), lines(i));
        hold on
    end

%   2b) Varying Initial Flight Path Angle
    subplot(1,2,2)
    xlabel('Range, m'), ylabel('Height, m'), grid
    hold on

    Gam_o = [-0.5, -0.18, 0.4];
    for i = 1:length(Gam_o)
	    xo		=	[V;Gam_o(i);H;R];
	    [ta,xa]	=	ode23('EqMotion',tspan,xo);
        plot(xa(:,4),xa(:,3), lines(i));
        hold on
    end
	



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