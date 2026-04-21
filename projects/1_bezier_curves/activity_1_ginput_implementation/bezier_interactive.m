function bezier_interactive
    plot([-1 1],[0,0],'b',[0 0],[-1 1],'b'); 
    hold on
    t = 0:0.01:1;
    [x,y] = ginput(1);

    while(0 == 0)
        [xnew, ynew] = ginput(3);
        
        if length(xnew) < 3
            break
        end

        x = [x; xnew];
        y = [y; ynew];

        plot([x(1) x(2)], [y(1) y(2)], 'r:', x(2), y(2), 'rs');
        plot([x(3) x(4)], [y(3) y(4)], 'r:', x(3), y(3), 'rs');
        plot(x(1), y(1), 'bo', x(4), y(4), 'bo');

        bx = 3*(x(2)-x(1));
        cx = 3*(x(3)-x(2))-bx;
        dx = x(4)-x(1)-bx-cx;
        by = 3*(y(2)-y(1));
        cy = 3*(y(3)-y(2))-by;
        dy = y(4)-y(1)-by-cy;

        xp = x(1)+t.*(bx+t.*(cx+t*dx));
        yp = y(1)+t.*(by+t.*(cy+t*dy));
        plot(xp,yp)
        x = x(4);
        y = y(4);
    end

    hold off
end
