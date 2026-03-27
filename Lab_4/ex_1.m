% Heat equation
% Exercise 1
% Tasks 2, 3, and 4
% Compute the Fourier sine series approximation,
% animate temperature evolution,
% and highlight instant smoothing at t = 0.001.
clear;
clc;
close all;

L = pi;
N = 200;

x = linspace(0, L, 800);
t = linspace(0, 0.25, 240);

u = @(x, t) analytical_solution(x, t, N);

animate(u, x, t);
draw_surface(u, x, t);
draw_snapshot_with_initial(u, x, 0.001);


function y = initial_condition(x)
  y = zeros(size(x));
  y(x >= pi / 4 & x <= 3 * pi / 4) = 1;
end


function u = analytical_solution(x, t, N)
  u = zeros(size(x));

  for n = 1:N
    bn = fourier_coefficient(n);
    u = u + bn .* sin(n .* x) .* exp(-(n ^ 2) .* t);
  end
end


function bn = fourier_coefficient(n)
  bn = (2 ./ (n .* pi)) .* (cos(n .* pi ./ 4) - cos(3 .* n .* pi ./ 4));
end


function animate(u, x, t)
  figure;
  h = plot(x, u(x, 0), 'LineWidth', 1.5);
  grid on;
  xlabel('x');
  ylabel('u(x,t)');
  title('1D heat equation solution over time');
  xlim([min(x), max(x)]);
  ylim([-0.05, 1.1]);

  for k = 1:numel(t)
    h.YData = u(x, t(k));
    title(sprintf('1D heat equation solution at t = %.4f', t(k)));
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
  title('Heat diffusion of the initial square pulse');
  view(45, 30);
end


function draw_snapshot_with_initial(u, x, t_small)
  figure;
  plot(x, initial_condition(x), 'k--', 'LineWidth', 1.5);
  hold on;
  plot(x, u(x, t_small), 'r-', 'LineWidth', 1.5);
  hold off;
  grid on;
  xlabel('x');
  ylabel('u(x,t)');
  title(sprintf('Instant smoothing: initial pulse vs t = %.3f', t_small));
  legend('u(x,0)', sprintf('u(x, %.3f)', t_small), 'Location', 'best');
  xlim([min(x), max(x)]);
  ylim([-0.05, 1.1]);
end
