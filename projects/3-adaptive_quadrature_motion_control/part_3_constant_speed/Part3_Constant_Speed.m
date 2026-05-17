%% Part 3 - Constant-Speed Animation
% =========================================================
% Moves a marker along the Bezier curve from Part 2 at
% constant speed by using equal arc-length steps.
%
% REQUIRES: adapquad.m in the same folder / on the path.
% =========================================================
clear; clc; close all;

% ── 1. Curve definition (copied exactly from Part 2) ─────
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

row = 10;
P0 = H(row, 1:2); P1 = H(row, 3:4);
P2 = H(row, 5:6); P3 = H(row, 7:8);

x = @(t) (1-t).^3*P0(1) + 3*(1-t).^2.*t*P1(1) + 3*(1-t).*t.^2*P2(1) + t.^3*P3(1);
y = @(t) (1-t).^3*P0(2) + 3*(1-t).^2.*t*P1(2) + 3*(1-t).*t.^2*P2(2) + t.^3*P3(2);

x_prime = @(t) 3*(1-t).^2*(P1(1)-P0(1)) + 6*(1-t).*t*(P2(1)-P1(1)) + 3*t.^2*(P3(1)-P2(1));
y_prime = @(t) 3*(1-t).^2*(P1(2)-P0(2)) + 6*(1-t).*t*(P2(2)-P1(2)) + 3*t.^2*(P3(2)-P2(2));

arc_len_int = @(t) sqrt(x_prime(t).^2 + y_prime(t).^2);

% ── 2. Total arc length (same tolerance as Part 2) ───────
tol = 1e-8;
L_tot = adapquad(arc_len_int, 0, 1, tol);
fprintf('Total arc length: %.6f\n', L_tot);

% ── 3. Compute N+1 equally-spaced arc-length positions ───
% s_k = k/N are equal fractions of arc length.
% For each s_k we find t*(s_k) via Newton's method,
% then evaluate the curve at that parameter value.
% This guarantees the marker covers the same arc length
% between any two consecutive frames → constant speed.

N        = 150;          % number of animation frames
tol_newt = 0.5e-8;       % same stopping criterion as Part 2
s_vals   = linspace(0, 1, N+1);
t_stars  = zeros(1, N+1);

fprintf('Computing %d arc-length positions via Newton...\n', N+1);
for i = 1:length(s_vals)
    s      = s_vals(i);
    t_curr = s;           % initial guess: linear interpolation (same as Part 2)
    err_newton = inf;

    while err_newton > tol_newt
        % F(t)  = integral_0^t ||gamma'|| du - s*L = 0
        % F'(t) = ||gamma'(t)||    (Fundamental Theorem of Calculus)
        if t_curr <= 0
            f_val = -s * L_tot;
        else
            f_val = adapquad(arc_len_int, 0, t_curr, tol) - s * L_tot;
        end
        f_prime    = arc_len_int(t_curr);
        t_new      = t_curr - f_val / f_prime;
        t_new      = max(0, min(1, t_new));  % clamp to valid range
        err_newton = abs(t_new - t_curr);
        t_curr     = t_new;
    end
    t_stars(i) = t_curr;
end

px = x(t_stars);   % x-coordinates of the N+1 animation frames
py = y(t_stars);   % y-coordinates

% ── 4. Set up the figure ──────────────────────────────────
fig = figure('Name', 'Part 3 - Constant Speed', 'Color', 'w');

t_plot = linspace(0, 1, 500);
plot(x(t_plot), y(t_plot), 'b-', 'LineWidth', 2, ...
     'DisplayName', 'Bezier curve');
hold on; grid on; axis equal;
xlabel('x'); ylabel('y');
title('Part 3: Constant-Speed Animation');
legend('Location', 'best');

% Marker and trailing path, initialised at frame 1
h_marker = plot(px(1), py(1), 'ro', ...
                'MarkerSize', 12, 'MarkerFaceColor', 'r', ...
                'DisplayName', 'Marker');
h_trail  = plot(px(1), py(1), 'r-', 'LineWidth', 1.5, ...
                'HandleVisibility', 'off');

% ── 5. Animate ───────────────────────────────────────────
% Each frame advances by exactly L_tot/N units of arc length,
% so the visual speed along the curve is constant.
pause(1);
for k = 2:N+1
    set(h_marker, 'XData', px(k),   'YData', py(k));
    set(h_trail,  'XData', px(1:k), 'YData', py(1:k));
    drawnow;
    pause(0.03);   % seconds per frame - decrease for faster animation
end

fprintf('Done. Marker travelled %.4f units at constant speed.\n', L_tot);
