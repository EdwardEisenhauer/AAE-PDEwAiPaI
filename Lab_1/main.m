clear;
clc;
close all;

functions = [
    struct("name", "f(x) = x", "function", @(x) x),
    struct("name", "f(x) = exp(-x^2/2)", "function", @(x) exp(-x.^2 / 2))
    struct("name", "f(x) = sin(x)", "function", @(x) sin(x))
];

c = 1;
x = linspace(-3, 3);
t = linspace(0, 3);

for i = 1:length(functions)
    f = functions(i);

    X = x(:).';
    T = t(:);
    U = f.function(X - c * T);

    figure("Name", f.name);
    h = plot(x, U(1, :), 'LineWidth', 1.5);
    grid on;
    xlabel('x');
    ylabel('u(x,t)');
    axis([x(1) x(end) min(U(:)) max(U(:))]);

    for k = 1:length(t)
        set(h, 'YData', U(k, :));
        title(sprintf('%s, t = %.2f', f.name, t(k)));
        drawnow;
    end

    draw_surface(f.name, X, T, U)

end

function draw_surface(f_name, X, T, U)
    [Xgrid, Tgrid] = meshgrid(X, T);
    figure('Name', f_name + " surface");
    surf(Xgrid, Tgrid, U, 'EdgeColor', 'none');
    xlabel('x');
    ylabel('t');
    zlabel('u(x,t)');
    title(f_name + " surface");
    view(45, 30);
    colorbar;
end
