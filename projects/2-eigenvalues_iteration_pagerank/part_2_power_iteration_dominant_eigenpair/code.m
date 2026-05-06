%% Task 2
clear; clc;

% Data
B = [4 1 0; 1 3 1; 0 1 2];
max_iter = 30;
x0 = [1; 1; 1];

% Estimated way
[lambda_approx, v_approx, v_hist] = powerit(B, x0, max_iter);

% Correct way
[V_exact, D_exact] = eig(B);    % 'V_exact' contains the eigenvectors as columns and 'D_exact¡ is a diagonal matrix of the eigenvalues
eigenvalues = diag(D_exact);  

% Finding abs(lambda_1) and abs(lambda_2) := two bigger eigenvalues in
% absolute form
sorted_abs_eigvals = sort(abs(eigenvalues), 'descend');
abs_lambda1 = sorted_abs_eigvals(1);
abs_lambda2 = sorted_abs_eigvals(2);

% Theoretical convergence
S = abs_lambda2 / abs_lambda1;

% Exact dominant eigenvector
[lambda_exact, idx] = max(eigenvalues); 
v_exact = V_exact(:, idx);

% Align signs for calculating the error between the exact and approximated
% values
if sign(v_approx(1)) ~= sign(v_exact(1))
    v_exact = -v_exact;
end

fprintf('Approximated dominant eigenvalue: %f\n', lambda_approx);
fprintf('Exact dominant eigenvalue: %f\n', lambda_exact);

fprintf('\nApproximated eigenvector:\n'); disp(v_approx);
fprintf('Exact eigenvector:\n'); disp(v_exact);

fprintf('Theoretical convergence rate S = |λ2/λ1| (where λ1 and λ2 are the greatest eigenvalues): %f\n', S);
fprintf('Empirical error ratio (Eigenvector ||e_{k+1}|| / ||e_k||):\n');

% Calculating the empirical error ratio
errors = zeros(max_iter, 1);
for k = 1:max_iter
    errors(k) = norm(v_hist(:, k) - v_exact);   % 'norm' function calculates the Euclidean length (magnitude) of a vector
end
for k = 1:(length(errors)-1)
    ratio = errors(k+1) / errors(k);
    if k > max_iter - 6
        fprintf('   Iter %2d to %2d: Error ratio = %.5f\n', k, k+1, ratio);
    end
end

% Description: Power Iteration implementation which computes dominant 
% eigenvector of square matrix
% Input: matrix A, initial (nonzero) vector x, number of steps 
% Output: dominant eigenvalue lam, eigenvector u
function[lam, v, v_hist] = powerit(A, x, k)
    v_hist = zeros(length(x), k); % array to track history
    for i = 1:k
        v = x / norm(x);
        x = A * v;
        lam = v' * x;
        v_hist(:, i) = v;
    end
    v = x / norm(x);
end
