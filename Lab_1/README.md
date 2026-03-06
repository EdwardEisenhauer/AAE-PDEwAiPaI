# Laboratory 1

Write an algorithm to solve PDE with the help of ODE.

Transform a Partial Differential Equation to the
system of Ordinary Differential Equations.

Plot the solution in time.

The functions to analyze:

1. f = x
2. f = e^(-x^2/2)
3. f = sin(x)

System of Ordinary Differential Equations:

du/dt = 0,
dx/dt = c, x(0) = x_0

Partial Differential Equation:

u_t + c * u_x = 0,
u(x,0) = f(x)

where u_t = del u / del t and u_x = del u / del x
