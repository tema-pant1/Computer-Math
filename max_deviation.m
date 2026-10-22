function res = max_deviation(X,Y_poly, Y_func)
       
    if ((length(X) ~= length(Y_poly)) || (length(X) ~= length(Y_func)))
        disp("У входных массивов разный размер!");
    end

    res = zeros(1, 3);

    for i=1:length(X)
        if (abs(Y_poly(i)-Y_func(i)) > res(1))
            res(1) = abs(Y_poly(i)-Y_func(i));
            res(2) = X(i);
            res(3) = Y_poly(i);
        end
    end
    
end
