function [] = MohrsCirclePlaneStress(nx,ny,tau)
% Curran Robertson
% This function produces Mohr's Circle given normal stress in x (nx), normal
% stress in y (ny), and shear xy (tau).
% Requires principal_stresses.m to be in the same folder

% Declare variables
syms sigma_xprime tau_xyprime Eqn;

%Calculate average normal
sigma_avg = (nx+ny)/2;
%Calculate Radius
R = sqrt(((nx-ny)/2)^2 + tau^2);
%Equation of circle
Eqn = (sigma_xprime - sigma_avg)^2 + tau_xyprime^2 - R^2;
%Solve for shear
y = solve(Eqn, tau_xyprime);

% Call principal stress Function to get principal stresses
[p1, p2, p_avg, tau_max, theta_p, theta_s] = principal_stresses(nx, ny, tau);

% Plot Circle
fplot(y, [-2.5*abs(tau_max) 2.5*abs(tau_max)]);
hold on
grid on
title('Mohr s Circle')
xlabel('sigma (normal stress)');
ylabel('-tau (shear stress)');
ylim([-2.5*abs(tau_max) 2.5*abs(tau_max)]);

% Plot important points
plot(p1,0, '.', 'MarkerSize', 20);
plot(p2,0, '.', 'MarkerSize', 20);
plot(p_avg,0, '.', 'MarkerSize', 20);
plot(p_avg,-tau_max, '.', 'MarkerSize', 20);
plot(p_avg,tau_max, '.', 'MarkerSize', 20);
plot(nx, tau,'.', 'MarkerSize', 20);
plot(ny, tau,'.', 'MarkerSize', 20);
legend('shear(normal)','shear(normal)','principal stress 1','principal stress 2','average normal stress', '(p avg, -tau max)','(p avg, tau max)','REF1(nx, tau)','REF2(ny, tau)')
axis equal

hold off

end