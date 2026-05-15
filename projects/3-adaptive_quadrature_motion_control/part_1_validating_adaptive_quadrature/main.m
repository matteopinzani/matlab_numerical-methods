%% Part 1 - Validating adaptive quadrature
clear; clc;

% initial data
R = 4;
a0 = 0;
b0 = 2*pi;
tol0 = 10^-6;

% derivatives for x(t) = R*cos(t) and y(t) = R*sin(t)
x_prime = @(t) -R * sin(t);
y_prime = @(t) R * cos(t);

% integrand of arc length function
arc_len_int = @(t) sqrt(x_prime(t).^2 + y_prime(t).^2);

% approx. integral value calculated numerically using adapquad.m
L_num = adapquad(arc_len_int, a0, b0, tol0);

% exact solution value calculated analitically
L_exact = 2 * pi * R;

% error calculation
err = abs(L_exact - L_num);

fprintf('--- ADAPQUAD VALIDATION ---\n');
fprintf('Chosen radius R = %g\n', R);
fprintf('Interval t = [%g, %g]\n', a0, b0);
fprintf('Calculated length (adapquad): %.10f\n', L_num);
fprintf('Exact length (2*pi*R):        %.10f\n', L_exact);
fprintf('Absolute error:               %.10e\n', err);
fprintf('Set tolerance:                %.10e\n\n', tol0);