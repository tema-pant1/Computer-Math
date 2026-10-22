function res=my_conv(a,b)

conv_deg = length(a)+length(b)-1;
res = zeros(1, conv_deg);

for i=1:conv_deg
    c = 0;
    for j=1:length(a)
        if (j >= 1 && j <= length(a) && i-j+1 >= 1 && i-j+1 <= length(b))
        c = c + a(j)*b(i-j+1);
        end
    end
    res(i) = c;
end


