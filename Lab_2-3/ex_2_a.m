% Initial-Boundary Value Problems
% Task A (Linear Shift)
% For
% u_t + c * u_x = 0, with c > 0,
% plot the x-t plane.
% Draw the dividing characteristic line
% x = c * t.
% Write a script that uses a conditional statement
% to evaluate u(x, t) using
% PHI(x - c * t) if x > c * t, and
% phi(t - x / c) if x < c * t.
clear;
clc;
close all;

c = 2;
x = linspace(0, 20, 500);
t = linspace(0, 10, 400);

[X, T] = meshgrid(x, t);

for c = -10:10:5
        
    U = solve_ibvp(X, T, c);
    
    draw_xt_plane(c, x, t);
    draw_surface(X, T, U, c);
end

function y = PHI(x)
  y = exp(-(x.^2));
end


function y = phi(t)
  y = exp(-(t.^2));
end


function U = solve_ibvp(X, T, c)
  U = zeros(size(X));

  for i = 1:size(X, 1)
    for j = 1:size(X, 2)
      xij = X(i, j);
      tij = T(i, j);

      if xij > c * tij
        U(i, j) = PHI(xij - c * tij);
      elseif xij < c * tij
        U(i, j) = phi(tij - xij / c);
      else
        U(i, j) = PHI(0);
      end
    end
  end
end


function draw_xt_plane(c, x, t)
  figure;
  plot(c .* t, t, 'r--', 'LineWidth', 2);
  grid on;
  xlabel('x');
  ylabel('t');
  title('x-t plane with dividing characteristic x = c t');
  xlim([min(x), max(x)]);
  ylim([min(t), max(t)]);
end


function draw_surface(X, T, U, c)
  figure;
  surf(X, T, U, 'EdgeColor', 'none');
  hold on;
  plot3(c .* T(:, 1), T(:, 1), max(U(:)) * ones(size(T(:, 1))), 'k--', 'LineWidth', 1.5);
  hold off;
  colormap('parula');
  colorbar;
  xlabel('x');
  ylabel('t');
  zlabel('u(x,t)');
  title('Piecewise solution of the linear shift IBVP');
  view(45, 30);
end
