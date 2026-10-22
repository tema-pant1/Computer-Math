a=0;
h=0.0 1;
b=3;

dynamic(a,b, @cos, @sin, @IV_agregat);

% x = a:h:b;
% y = sin(x);  
% y_deriv = cos(x);
% f = I1_agregat(x,y);
% constants(x(1:length(x)-1), y_deriv(1:length(x)-1), f, h, 1);

% f1 = II1_agregat(x,y);
% f2 = II2_agregat(x,y);
% constants(x(1:length(x)-2), y_deriv(1:length(x)-2), f1, h, 2);
% constants(x(2:length(x)-1), y_deriv(2:length(x)-1), f2, h, 2);

%plot(x,y_deriv,x(1:(length(x)-1)),f,'red'); grid;

%plot(x,y_deriv, x(1:length(x)-2),f, 'red'); grid;

%plot(x,y_deriv, x(2:length(x)-1),f, 'red'); grid;

%plot(x,y_deriv, x(2:length(x)-2),f, 'red'); grid;

%plot(x,y_deriv, x(3:length(x)-2),f, 'red'); grid;


function res = I1_agregat(x,y_func)
    n = length(x);
    res = zeros(1, n-1);
    h = x(2)-x(1);

    for i=1:(n-1)
        res(i) = (y_func(i+1)-y_func(i))/h;
    end

end

function res = II1_agregat(x, y_func)
    n = length(x);
    res = zeros(1, n-2);
    h = x(2)-x(1);
    
    for i=1:(n-2)
        res(i) = (4*y_func(i+1)-3*y_func(i)-y_func(i+2))/(2*h);
    end

end

function res = II2_agregat(x, y_func)
    n = length(x);
    res = zeros(1, n);
    h = x(2)-x(1);
    
    for i=2:(n-1)
        res(i) = (y_func(i+1) - y_func(i-1))/(2*h);
    end

    res = res(2:(n-1));

end

function res = III_agregat(x, y_func)
    n = length(x);
    res = zeros(1, n);
    h = x(2)-x(1);
    
    for i=2:(n-2)
        res(i) = (6*y_func(i+1) - 3*y_func(i)-2*y_func(i-1)-y_func(i+2))/(6*h);
    end

    res = res(2:(n-2));

end

function res = IV_agregat(x, y_func)
    n = length(x);
    res = zeros(1, n);
    h = x(2)-x(1);
    
    for i=3:(n-2)
        res(i) = (y_func(i-2)-8*y_func(i-1)+8*y_func(i+1)-y_func(i+2))/(12*h);
    end

    res = res(3:(n-2));

end

function constants(X, y_agregat, y_deriv, h, alpha)
    deviation = max_deviation(X, y_agregat, y_deriv);
    deviation = deviation(1);
    my_alfa = log(deviation)/log(h);
    c = deviation/(h^alpha);
    fprintf('h = %.6f     alfa = %.6f      c = %.6f\n', h, my_alfa,c);
end

function dynamic(a, b, deriv, funct, agregat)
    for n=1:5

    x_dev = 10^(-(n+1)):10^(-(n+1)):10^(-n);
    y_dev = zeros(1, length(x_dev));
    step = 1;

        for h=10^(-(n+1)):10^(-(n+1)):10^(-n)
           
            x = a:h:b;
            y_func = funct(x);
            y_deriv = deriv(x);
            y_agregat = agregat(x, y_func);
            deviation = max_deviation(x(3:length(x)-2), y_agregat, y_deriv(3:length(y_deriv)-2));
            y_dev(step) = deviation(1);
            step = step+1;

        end

        grid on;
        plot(x_dev, y_dev);
        pause;
        
    end
end