clear;
x = 1:5;
y = sin(x);

f = newtone(x,y);

X = 1:0.1:10;
Y = polyval(f,X);

y = sin(X);

d = max_deviation(X, Y, y);

disp(d);

plot(X,Y,X,y, 'red'); grid;


