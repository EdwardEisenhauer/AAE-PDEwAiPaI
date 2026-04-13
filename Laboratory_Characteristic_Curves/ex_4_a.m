% Shock waves
% Task A
% For
% u_t + u^2 * u_x = 0
% with the given step down from 2 to 1,
% calculate the shock speed s manually.
clear;
clc;
close all;

% u(x, 0) = 2 for x <= 0, 1 for x > 0

u_L = 2;
u_R = 1;

s = shock_speed(u_L, u_R);

fprintf('f(u) = u^3 / 3\n');
fprintf('Shock speed s = (f(uR) - f(uL)) / (uR - uL) = %.6f\n', s);

function y = flux(u)
  y = (u.^3) ./ 3;
end

function s = shock_speed(uL, uR)
  s = (flux(uR) - flux(uL)) / (uR - uL);
end

