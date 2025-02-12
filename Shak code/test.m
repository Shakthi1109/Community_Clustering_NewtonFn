% zz=-5:1:5;
% zz=transpose(zz);
% n=11;
% alpha=rand(n, 1);
% for i=1:max(size(zz))
% correctedvs(i) = -(((alpha(i)^2)/(zz(i)))) ;
% disp(correctedvs(i));
% end
% 
% ctd=alpha.^2./zz;
% disp(ctd);
% %disp(k);
% 
% 
% 

function test()

% Create a range of x-values
x = linspace(-5, 5, 100);

% Create a flat line y-values
y = 4*ones(100);

% Plot the x and y values
plot(x, y, 'Color', 'blue')

% Set the x-axis range
xlim([-5, 5])

% Show the graph
show()

end
