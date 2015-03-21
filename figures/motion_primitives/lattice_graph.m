clc; close all; clear;

count = 4;
length = 9;
levels = 2;

% Initialize origin
for ii = 1 : count
    primitives(ii).x = 0;
    primitives(ii).y = 0;
    primitives(ii).a = 0;
end

% Set parameters
v = 1;
wmax = 0.15;
w = -wmax : 2 * wmax / (count - 1) : wmax;

% Generate motion primitives
for ii = count : -1 : 1
    for jj = 1 : length
        
        o = w(ii);
        
        % Make sure to handle case when there is zero curvature
        if (o == 0)
            x = v * jj * cos(primitives(ii).a(1));
            y = v * jj * sin(primitives(ii).a(1));
            a = 0;
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

leaves = primitives;

% Build tree
for ii = 1 : levels
    
    begin = numel(primitives) + 1;
    for jj = 1 : numel(leaves)
        new = numel(primitives) + 1;
        leaf_root = leaves(jj);
  
        if jj == 9
            yo = 5;
        end
        % Initialize origin
        for kk = 1 : count
            primitives(new + kk - 1).x = leaf_root.x(end);
            primitives(new + kk - 1).y = leaf_root.y(end);
            primitives(new + kk - 1).a = leaf_root.a(end);
        end
        
        for kk = 1 : count
            for ll = 1 : length
                
                o = w(kk);
                
                if (o == 0)
                    x = v * ll * cos(leaf_root.a(end));
                    y = v * ll * sin(leaf_root.a(end));
                    a = 0;
                else
                    x = v / o * (sin(o * ll + leaf_root.a(end)) - sin(leaf_root.a(end)));
                    y = v / o * (cos(leaf_root.a(end)) - cos(o * ll + leaf_root.a(end)));
                    a = o * ll;
                end
                
                primitives(new + kk - 1).x = [primitives(new + kk - 1).x, x + leaf_root.x(end)];
                primitives(new + kk - 1).y = [primitives(new + kk - 1).y, y + leaf_root.y(end)];
                primitives(new + kk - 1).a = [primitives(new + kk - 1).a, a + leaf_root.a(end)];
            end
        end
    end
    
    leaves = primitives(begin : end);
end

% Plot motion primitives
f = figure; hold on; box on; grid on; axis equal;
cs = hsv(7);
for ii = 1 : numel(primitives)
    if ii <= count
        c = cs(3,:);
        hs(1) = plot(primitives(ii).x, primitives(ii).y, 'linewidth', 1, 'color', c);
    elseif ii <= count^2 + count
        c = cs(5,:);
        hs(2) = plot(primitives(ii).x, primitives(ii).y, 'linewidth', 1, 'color', c);
    elseif ii <= count^3 + count^2 + count
        c = cs(6,:);
        hs(3) = plot(primitives(ii).x, primitives(ii).y, 'linewidth', 1, 'color', c);
    else
        c = cs(7,:);
        hs(4) = plot(primitives(ii).x, primitives(ii).y, 'linewidth', 1, 'color', c);
    end
end
xlabel('x (m)', 'interpreter', 'latex');
ylabel('y (m)', 'interpreter', 'latex');
l = legend(hs, 'Level 0', 'Level 1', 'Level 2', 'Level 3');
set(l, 'fontsize', 14);
%set(l, 'xcolor', [1 1 1], 'ycolor', [1 1 1]);
axis off;
view(-90, 90)