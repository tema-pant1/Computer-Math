function res=my_polyval(polynom,vals)
    res = zeros(1, length(vals));
    len_poly = length(polynom);

    for i=1:length(vals)
        for k=1:length(polynom)
            res(i) = res(i)+polynom(k)*(vals(i)^(len_poly-k));
        end
    end
end

