x = 1:10;
y = sin(x);

% spline = calculate_spline(x,y);
% 
% zavod(x, spline);

deviation(1,10, @sin, 100);

function deviation(a, b, func, n)
   
    X_dev = 5:n;
    Y_dev = zeros(1,n-4);

    for i=5:n

        x = linspace(a,b,i);
        y = func(x);
        spline = calculate_spline(x,y);

        X_spline = []; Y_spline = [];
        
        for k=1:length(x)-1

            X_part = x(k):0.01:x(k+1); 
            t = X_part - x(k);
            Y_part = polyval(spline(k, :), t);
            
            X_spline = [X_spline, X_part];
            Y_spline = [Y_spline, Y_part];

        end
       
        deviation = max_deviation(X_spline,Y_spline,func(X_spline));
        Y_dev(i-4) = deviation(1);

    end
    
    plot(X_dev, Y_dev); grid;
    
end


function zavod(x,spline)
    n = length(x);
    h = x(2)-x(1);
    X_func = 1:0.01:h*n;
    Y_func = sin(X_func);
    X = [];
    Y = [];

    for k=1:(n-1)

        X_part=x(k):0.01:x(k+1);
        t = X_part-x(k);

        Y_part=polyval(spline(k,:),t);
        plot(1:0.01:2, Y_part, 'b' ); hold on;
        plot(X, Y, 'red', 'LineWidth', 2);
        plot(X_func, Y_func, 'k'); grid; hold off;
        pause;
        
        X = [X, X_part];
        Y = [Y, Y_part];

    end
    
    plot(X, Y, 'red', 'LineWidth', 2); hold on;
    plot(X_func, Y_func, 'k'); grid; hold off;

end

function res = calculate_spline(x,y)
    n = length(x);
    h = x(2)-x(1);
    res = zeros(n-1, 4);

    d = y(1:(n-1))';
    
    Y = calculate_delta(y);
    Y(3,:) = Y(3,:)*(3/h^2);
    k = calculate_coef(n);

    b = k\Y(3,1:(n-2))';
    b = [0;b;0];

    a = zeros(n-1,1); c = zeros(n-1,1);

    for i=1:(n-1)
        a(i) = (b(i+1)-b(i))/(3*h);
        c(i) = Y(2,i)/h - (b(i+1)+2*b(i))*h/3;
    end
    
    b = b(1:n-1);

    res(:,1) = a; 
    res(:, 2) = b; 
    res(:, 3) = c; 
    res(:, 4) = d;

end

function res = calculate_delta(y)
    
    n = length(y);
    res = zeros(3,n);
    res(1,:) = y;

    for i=2:3
        for j=1:(n-i+1)
            res(i, j) = res(i-1,j+1)-res(i-1,j);
        end
    end

end

function res=calculate_coef(n)
    res = zeros(n-2, n-2);
    
    res(1,1) = 4; res(1,2) = 1;
    for i=2:(n-3)
        res(i,i-1) = 1;
        res(i,i) = 4;
        res(i,i+1) = 1;
    end
    res(n-2,n-3) = 1; res(n-2, n-2) = 4;

end