% Method of Characteristics
% Task A (Constant Advection)
% For
% u_t + 10 * u_x = 0,
% write a MATLAB script to plot the parallel characteristic lines
% x(t) = x_0 + 10 * t
% on the x−t plane. Use plot3 or surf to show the initial condition
% u(x, 0) = 1/(1 + x^2)
% sliding along these paths without changing shape.
clear;
clc;
close all;

x = linspace(-10, 100, 1000);
t = linspace(0, 10, 1000);

u = @(x, t) initial_condition(x - 10 .* t);

animate(u, x, t);
draw_surface(u, x, t);


function u = initial_condition(x)
  u = 1 ./ (1 + x.^2);
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
