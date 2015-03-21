clc; close all; clear;

count = 9;
length = 9;

% Initialize origin
for ii = 1 : count
    primitives(ii).x = 0;
    primitives(ii).y = 0;
    primitives(ii).a = 0;
end

% Set parameters
v = 1;
wmax = 0.05;
w = -wmax : 2 * wmax / (count - 1) : wmax;

% Generate motion primitives
for ii = 1 : count
    for jj = 1 : length
        
        o = w(ii);
        
        % Make sure to handle case when there is zero curvature
        if (o == 0)
            x = v * jj * cos(primitives(ii).a(1));
            y = v * jj * sin(primitives(ii).a(1));
            a = primitives(ii).a(1);
        else
            x = v / o * (sin(o * jj + primitives(ii).a(1)) - sin(primitives(ii).a(1)));
            y = v / o * (cos(primitives(ii).a(1)) - cos(o * jj + primitives(ii).a(1)));
            a = o * jj;
        end
        
        primitives(ii).x = [primitives(ii).x, x + primitives(ii).x(1)];
        primitives(ii).y = [primitives(ii).y, y + primitives(ii).y(1)];
        primitives(ii).a = [primitives(ii).a, a + primitives(ii).a(1)];
    
    end
end

% Plot motion primitives
c = hsv(count+6);
f = figure; hold on; box on; grid on; axis equal;
for ii = count : -1 : 1
    text = ['\omega = ', sprintf('%1.2f',w(ii)), ' rad \cdot s^{-1}'];
    plot(primitives(ii).x, primitives(ii).y, 'color', c(ii+3,:), 'displayname', text, 'linewidth', 2);
end
legend(gca, 'show', 'location', 'southeastoutside');
xlabel('x (m)', 'interpreter', 'latex');
ylabel('y (m)', 'interpreter', 'latex');
xlim([-1 10]);
ylim([-2.5 2.5]);
