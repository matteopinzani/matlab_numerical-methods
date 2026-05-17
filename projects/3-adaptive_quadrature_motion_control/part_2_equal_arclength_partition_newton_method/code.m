%% Task 2 - Equal arc-length partition via Newton's method
clear; clc;

% matrix data of 'H' drawing in Activity 6 for project 1
H = [85 565 95 575 120 575 130 570;
    130 570 140 560 180 570 190 580;
    190 580 195 555 210 425 215 410;
    215 410 225 370 230 240 225 220;
    225 220 215 180 170 130 150 165;
    150 165 140 180 140 235 160 260;
    160 260 180 280 255 330 280 340;
    280 340 320 360 435 475 450 500;
    450 500 460 530 465 580 460 590;
    460 590 445 600 410 560 400 520;
    400 520 390 485 385 280 390 210;
    390 210 395 185 460 190 480 220];

% select 4 points casually from the matrix data
row = 10;
P0 = H(row, 1:2); P1 = H(row, 3:4); P2 = H(row, 5:6); P3 = H(row, 7:8);

% define curve functions and their derivatives
x = @(t) (1-t).^3*P0(1) + 3*(1-t).^2.*t*P1(1) + 3*(1-t).*t.^2*P2(1) + t.^3*P3(1);
y = @(t) (1-t).^3*P0(2) + 3*(1-t).^2.*t*P1(2) + 3*(1-t).*t.^2*P2(2) + t.^3*P3(2);

x_prime = @(t) 3*(1-t).^2*(P1(1)-P0(1)) + 6*(1-t).*t*(P2(1)-P1(1)) + 3*t.^2*(P3(1)-P2(1));
y_prime = @(t) 3*(1-t).^2*(P1(2)-P0(2)) + 6*(1-t).*t*(P2(2)-P1(2)) + 3*t.^2*(P3(2)-P2(2));

% integrand of arc length function
arc_len_int = @(t) sqrt(x_prime(t).^2 + y_prime(t).^2);

% total length
L_tot = adapquad(arc_len_int, 0, 1, 10^-8);

% Newton method for finding t*(s)
tol_newton = 0.5*10^-8;
n_vals = [4, 20];

for k = 1:length(n_vals)
    n = n_vals(k);
    s_vals = 0:1/n:1;
    t_stars = zeros(size(s_vals));

    for i = 1:length(s_vals)
        s = s_vals(i);
        t_curr = s; % initial guess
        err_newton = inf;
    
        while err_newton > tol_newton
            f_val = adapquad(arc_len_int, 0, t_curr, 1e-8) - s*L_tot;
            f_prime = arc_len_int(t_curr);

            t_new = t_curr - f_val/f_prime;
            err_newton = abs(t_new - t_curr);
            t_curr = t_new;
        end
        t_stars(i) = t_curr;
    end

    % plot results
    figure;
    t_plot = linspace(0, 1, 200);
    plot(x(t_plot), y(t_plot), 'b-', 'DisplayName', 'Parametric Curve');
    hold on;
    plot(x(t_stars), y(t_stars), 'ro', 'DisplayName', 'Partition Points');
    grid on; 
    axis equal;

    xlabel('x');
    ylabel('y');
    legend('Location', 'best');
end
