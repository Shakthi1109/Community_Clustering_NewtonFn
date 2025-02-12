 function [y] =newton(z,alpha, m, iter)
%c=2;

guess =  -1i;%(z-sqrt(z^2-4*c))/(2*c);%z*i+z;
current = 0;
for(ii=1:iter)
    [f,fp]= func1examplenewt(z,alpha,m,guess);
    %fp = z-2*c*guess;
    %fp = (-guess)/(z-2*c*guess);
  %  fp = 1/8*(z/(sqrt(z^2-8))+1);
  if (fp~=0)
    current = guess - f/fp;
     
    guess = current;
  end
    
end
y = guess;
