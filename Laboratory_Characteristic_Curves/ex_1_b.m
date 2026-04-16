% Method of Characteristics
% Task B (Variable Speed & Damping)
% For
% u_t + 2 * t * u_x = -u,
% analytically find the characteristic paths
% x(t) = x_0 + t^2
% and the solution u(t) = u_0 * e^-t. Create a 3D MATLAB plot showing
% the initial Gaussian e^{-x^2} traveling along these curved paths
% while its amplitude decays exponentially over time.
clear;
clc;
close all;

x = linspace(-10, 100, 1000);
t = linspace(0, 10, 1000);

u = @(x, t) exp(-t) .* initial_condition(x - t.^2);

animate(u, x, t);
draw_surface(u, x, t);


function y = initial_condition(x)
  y = exp(-(x.^2));
end


function animate(u, x, t)
  figure;
  h = plot(x, u(x, 0), 'LineWidth', 1.5);
  grid on;
  xlabel('x');
  ylabel('u(x,t)');
  title('u(x,t) over time');
  xlim([min(x), max(x)]);
  ylim([0, 1.05]);

  for k = 1:numel(t)
    h.YData = u(x, t(k));
    title(sprintf('u(x,t) at t = %.3f', t(k)));
    drawnow;
  end
end


function draw_surface(u, x, t)
  [X, T] = meshgrid(x, t);
  U = u(X, T);

  figure;
  surf(X, T, U, 'EdgeColor', 'none');
  colormap('parula');
  colorbar;
  xlabel('x');
  ylabel('t');
  zlabel('u(x,t)');
  title('u(x,t)');
  view(45, 30);
end