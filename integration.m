clear;
format short;

% f = lejandr_diff(5);
% f1 = lejandr_recur(5);
% f2 = lejandr_ortog(5);
% 
% disp(f);
% disp(f1);
% disp(f2);

% f = interpolation_integral(1, 10, @sin, 9);
% disp(f)

dynamic_interpolation(9);

function res=integral_poly(a,b,polynom)
    res = 0;
    n = length(polynom);
    deg = n;
    for i=1:n
        res = res + (polynom(i)/deg)*(b^deg - a^deg);
        deg = deg - 1;
    end
end

function res=lejandr_recur(n)
     if (n == 0)
        res = [0 0 1];
        return;
     elseif (n == 1)
         res = [0 2 0];
         return;
     else
       
        L0 = 1;
        L1 = [2 0];

        for i=2:n
        
            alfa_0 = coef_lejandr(i-2)/coef_lejandr(i-1);
            alfa_0 = alfa_0*(integral_poly(-1,1, conv(L1, L1))/(integral_poly(-1,1,conv(L0,L0))));
            alfa_2 = L1(1)/coef_lejandr(i);

            L0 = [0 0 L0];
            L2 = conv([1/alfa_2 0], L1) - (alfa_0/alfa_2)*L0;
            L0 = L1;
            L1 = L2;
        end
     end
    
     res = L2;

end

function res = coef_lejandr(n)
    res = 1;
    for i=(n+1):(2*n)
        res = res*i;
    end
end

function res = different_poly(polynom)
    deg = length(polynom)-1;
    res = zeros(1, deg);
    
    for i=1:length(polynom)-1
        res(i) = polynom(i)*deg;
        deg = deg-1;
    end

end

function res = lejandr_diff(n)
    
    if (n==0)
        res = 1;
        return;
    end

    res = [1 0 -1];

    for i=2:n
        res = conv(res, [1 0 -1]);
    end
    
    for i=1:n
        res = different_poly(res);
    end

end

function res=lejandr_ortog(n)

    all_lejandr = zeros(n+1, n+1);
    all_lejandr(1, :) = [zeros(1, n) 1];
  

    for k=1:n
        sum = zeros(1, n+1);
        for i=0:(k-1)
            Li = all_lejandr(i+1, :);
            coef = (integral_poly(-1,1, conv([1 zeros(1,k)], Li)))/(integral_poly(-1,1,conv(Li,Li)));
            sum = sum+coef*Li;
        end
        Lk = [zeros(1, (n+1)-(k+1)) 1 zeros(1, k)] - sum;
        all_lejandr(k+1, :) = Lk;
    end
    res = all_lejandr(n+1, :)*coef_lejandr(n);
end

function res = coeff_Ak(a, b, n)
    nodes = roots(lejandr_recur(n));
    
    for i=1:n
        nodes(i) = ((b-a)/2)*nodes(i) + (a+b)/2;
    end
    
    res = zeros(2, n);
    
    for k=1:n
        poly = 1;
        for i=1:n
            if (i ~= k)
                coef = nodes(k)-nodes(i);
                poly = conv(poly, [1 -nodes(i)]);
                poly = poly/coef;
            end
        end
        res(1, k) = integral_poly(a, b, poly);
    end

    res(2, :) = nodes;
end

function res=interpolation_integral(a, b, func, n)
    Ak = coeff_Ak(a, b, n);
    res = 0;
    for k=1:n
        res = res+Ak(1, k)*func(Ak(2, k));
    end
end

function dynamic_interpolation(n)
    reference = cos(1)-cos(10);
    X = 1:n;
    Y = zeros(1, n);

    for i=1:n
        integral = interpolation_integral(1, 10, @sin, i);
        Y(i) = abs(integral - reference);
    end

    plot(X,Y); grid;

end