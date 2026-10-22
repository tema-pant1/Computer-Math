a = 1;
b = 20;
n = 15;

x = chebyshov_nodes(a,b,n, "cos");
y = sin(x);

interpoly = lagrange(x,y);

disp(interpoly);

X=a:0.01:b;
Y_poly=polyval(interpoly,X);
Y_funct = sin(X);

deviation = max_deviation(X, Y_poly, Y_funct);
disp(deviation);

plot(X, Y_poly); grid;
plot(X,Y_poly,'k', X, Y_funct, "red", deviation(2), deviation(3), "-o"); grid;

% deviation_dynamic(a,b,20, "cheb");

function res=chebyshov_poly(n)
    T0=1;
    T1=[1, 0];
    
    if (n == 1)
        cheb_poly = T0;
    elseif (n == 2)
        cheb_poly = T1;
    else
        for i=2:n
        cheb_poly = conv([2,0],T1);
        cheb_poly = cheb_poly - [zeros(1, length(cheb_poly)-length(T0)), T0];
        T0 = T1;
        T1 = cheb_poly;
        end
    end

    cheb_poly = cheb_poly / (2^(n-1));
    res = roots(cheb_poly)';
    
end

function res=chebyshov_roots(n)
    
    res = zeros(1,n);
    
    for k=1:n
        res(k) = cos((2*k-1)*pi/(2*n));
    end

end

function res=chebyshov_nodes(a,b,n,parametr)
    
    if (parametr == "poly")
        res = chebyshov_poly(n);
    elseif (parametr == "cos")
        res = chebyshov_roots(n);
    else
        disp("Неправильный аргумет!");
        return;
    end
    
    res = ((b-a)/2)*res+(b+a)/2;

end

function deviation_dynamic(a,b,finish,param)
    X_dyn = 1:finish;
    Y_dyn = zeros(1, finish);

    for i=1:finish
        
        if (param == "cheb")
            x = chebyshov_nodes(a,b,i, "poly");
        elseif (param == "ravn")
            x = linspace(a,b,i);
        else 
            disp("Неправильный аргумент!");
            return;
        end

        y = sin(x);
        interpoly = lagrange(x,y);

        X=a:0.01:b;
        Y_poly=polyval(interpoly,X);
        Y_funct = sin(X);

        deviation = max_deviation(X, Y_poly, Y_funct);
        Y_dyn(i) = deviation(1);
    end

    plot(X_dyn, Y_dyn); grid;

end