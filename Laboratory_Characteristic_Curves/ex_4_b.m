% Shock waves
% Task B
% Write a MATLAB script to plot the x---t plane.
% Plot the characteristic lines emerging from x < 0 (speed 4) and x > 0 (speed 1).
% Overlay a thick red line representing the analytical shock trajectory x_s(t) = st.

clear;
clc;
close all;

% u(x, 0) = 2 for x <= 0, 1 for x > 0
uL = 2;
uR = 1;

x = linspace(-8, 30, 700);
x0_left = linspace(-8, 0, 12);
x0_right = linspace(0, 8, 12);
t = linspace(0, 6, 300);

aL = uL^2;
aR = uR^2;
s = shock_speed(uL, uR);

[X, T] = meshgrid(x, t);
U = solve_shock(X, T, s, uL, uR);

fig_xt = draw_xt_plane(x0_left, x0_right, t, aL, aR, s);
fig_surface = draw_surface(X, T, U, s);

output_dir = fullfile(get_script_dir(), 'figures');
if ~exist(output_dir, 'dir')
  mkdir(output_dir);
end

export_pdf(fig_xt, fullfile(output_dir, 'ex_4_b_xt_plane'));
export_png(fig_surface, fullfile(output_dir, 'ex_4_b_surface'));


function y = flux(u)
  y = (u.^3) ./ 3;
end


function s = shock_speed(uL, uR)
  s = (flux(uR) - flux(uL)) / (uR - uL);
end


function fig = draw_xt_plane(x0_left, x0_right, t, aL, aR, s)
  fig = figure;
  hold on;

  for i = 1:numel(x0_left)
    x_left = x0_left(i) + aL .* t;
    plot(x_left, t, 'b-', 'LineWidth', 1);
  end

  for i = 1:numel(x0_right)
    x_right = x0_right(i) + aR .* t;
    plot(x_right, t, 'g-', 'LineWidth', 1);
  end

  plot(s .* t, t, 'r-', 'LineWidth', 3);

  grid on;
  xlabel('x');
  ylabel('t');
  title(sprintf('Characteristics and shock line x_s(t) = s t, s = %.3f', s));
  legend('x < 0 characteristics (speed 4)', 'x > 0 characteristics (speed 1)', 'Shock trajectory', 'Location', 'northwest');
  xlim([-8, 30]);
  ylim([min(t), max(t)]);
  hold off;
end


function U = solve_shock(X, T, s, uL, uR)
  U = zeros(size(X));

  for i = 1:size(X, 1)
    for j = 1:size(X, 2)
      if X(i, j) < s * T(i, j)
        U(i, j) = uL;
      elseif X(i, j) > s * T(i, j)
        U(i, j) = uR;
      else
        U(i, j) = 0.5 * (uL + uR);
      end
    end
  end
end


function fig = draw_surface(X, T, U, s)
  fig = figure;
  surf(X, T, U, 'EdgeColor', 'none');
  hold on;
  plot3(s .* T(:, 1), T(:, 1), max(U(:)) * ones(size(T(:, 1))), 'k--', 'LineWidth', 1.5);
  hold off;
  colormap('parula');
  colorbar;
  xlabel('x');
  ylabel('t');
  zlabel('u(x,t)');
  title('Shock solution surface for u_t + u^2 u_x = 0');
  view(45, 30);
end


function export_pdf(fig, output_base)
  set(fig, 'Color', 'w');
  drawnow;

  try
    exportgraphics(fig, [output_base, '.pdf'], 'ContentType', 'vector');
  catch
    try
      print(fig, [output_base, '.pdf'], '-dpdf', '-painters');
    catch
      error('Could not export PDF for %s.', output_base);
    end
  end
  fprintf('Exported PDF for %s\n', output_base);
end


function export_png(fig, output_base)
  set(fig, 'Color', 'w');
  drawnow;

  try
    exportgraphics(fig, [output_base, '.png'], 'Resolution', 300);
  catch
    try
      print(fig, [output_base, '.png'], '-dpng', '-r300');
    catch
      error('Could not export PNG for %s.', output_base);
    end
  end
  fprintf('Exported PNG for %s\n', output_base);
end


function script_dir = get_script_dir()
  script_path = mfilename('fullpath');
  if isempty(script_path)
    script_dir = pwd;
  else
    script_dir = fileparts(script_path);
  end
end
