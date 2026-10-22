function Lagrange = lagrange(x,y)
    
    if (length(x) ~= length(y))
        disp("У входных массивов разный размер!");
    end
    
    len = length(x);
    Lagrange = zeros(1, len);
    
    for i=1:len
        A = 1;
        for j=1:len
            if j~= i
            A = my_conv(A, [1/(x(i)-x(j)), -x(j)/(x(i)-x(j))]);
            end
        end
        A = A*y(i);
        Lagrange = Lagrange + A;
    end
end

