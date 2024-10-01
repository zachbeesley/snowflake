function [new_x1, new_y1, new_x2, new_y2] = get_points(x1, y1, x2, y2)
    new_x1 = (1/3)*x2 + (2/3)*x1;
    new_y1 = (1/3)*y2 + (2/3)*y1;
    new_x2 = (1/3)*x1 + (2/3)*x2;
    new_y2 = (1/3)*y1 + (2/3)*y2;
end

function [xp, yp] = get_point(x1, y1, x2, y2, P)

    dx = x2 - x1;
    dy = y2 - y1;

    alpha = -60./180*pi;
    xp = x1 + cos(alpha)*dx + sin(alpha)*dy;
    yp = y1 + sin(-alpha)*dx + cos(alpha)*dy;
    if isinterior(P, xp, yp)
        alpha = 60./180*pi;
        xp = x1 + cos(alpha)*dx + sin(alpha)*dy;
        yp = y1 + sin(-alpha)*dx + cos(alpha)*dy;
    end
end


%[new_x1, new_y1, new_x2, new_y2] = get_points(2, 1, 4.5, 5.33013);
%[xp, yp] = get_point(new_x1, new_y1, new_x2, new_y2);
%points = [2,1; new_x1, new_y1; xp, yp; new_x2, new_y2; 4.5, 5.33013; 7, 1];


function [] = Snowflake(iterations)
    x0=10;
    y0=10;
    width=800;
    length=1000;
    set(gcf,'position',[x0,y0,width,length]);
    points = [2,1; 4.5, 5.33013; 7, 1];
    P = polyshape();
    %colors = {'red', 'blue', 'green'};
    colors = {'blue'};
    %colors(1)
    %colors(randsample(3, 1))
    %colors(randi(numel(colors)))
    
    for i=1:iterations
    h = height(points)-1;
    buffer = 0;
    for row=1:h
        x1 = points(row + buffer, 1);
        y1 = points(row + buffer, 2);
        x2 = points(row + buffer + 1, 1);
        y2 = points(row + buffer + 1, 2);
        [new_x1, new_y1, new_x2, new_y2] = get_points(x1, y1, x2, y2);
        [xp, yp] = get_point(new_x1, new_y1, new_x2, new_y2, P);
        points = [points(1:row+buffer,:); new_x1, new_y1; xp, yp; new_x2, new_y2; points(row+buffer + 1:end, :)];
        buffer = buffer + 3;
    end
        x1 = points(end, 1);
        y1 = points(end, 2);
        x2 = points(1, 1);
        y2 = points(1, 2);
        [new_x1, new_y1, new_x2, new_y2] = get_points(x1, y1, x2, y2);
        [xp, yp] = get_point(new_x1, new_y1, new_x2, new_y2, P);
        points = [points(1:end,:); new_x1, new_y1; xp, yp; new_x2, new_y2];
    
    P = polyshape(points);
    plot(P, 'FaceColor',colors{randi(numel(colors))})
    pause(1)
    end
end

Snowflake(4) %Example



