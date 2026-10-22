function N = newtone(X,Y)
    
if (length(X) ~= length(Y))
    disp("У входных массивов разный размер!");
end

delta = Y;
len = length(X)-1;
N = zeros(1, len+1);
h = X(2)-X(1);

for k=1:len+1
    n_k = 1;
    
    for i=1:k-1
        n_k = conv(n_k, [1, -X(i)]);
        n_k = n_k/(i*h);
    end

    n_k = [zeros(1, len+1-length(n_k)), n_k];
    n_k = n_k*delta(1);
    N = N + n_k;

    for j=1:len+1-k
        delta(j) = delta(j+1)-delta(j);
    end

end
  
end
                                                                                                        
