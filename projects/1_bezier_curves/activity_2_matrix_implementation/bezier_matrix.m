function bezier_matrix(M)
    axis equal;
    hold on
    t = 0:0.01:1;
    n_rows = size(M, 1);

    for i = 1:n_rows
        x(1) = M(i,1); y(1) = M(i,2);
        x(2) = M(i,3); y(2) = M(i,4);
        x(3) = M(i,5); y(3) = M(i,6);
        x(4) = M(i,7); y(4) = M(i,8);
        
        bx = 3*(x(2)-x(1)); 
        cx = 3*(x(3)-x(2))-bx; 
        dx = x(4)-x(1)-bx-cx; 
        by = 3*(y(2)-y(1)); 
        cy = 3*(y(3)-y(2))-by;
        dy = y(4)-y(1)-by-cy;
        
        xp = x(1)+t.*(bx+t.*(cx+t.*dx));
        yp = y(1)+t.*(by+t.*(cy+t.*dy));
        plot(xp, yp, 'b');
    end

    hold off
end

    