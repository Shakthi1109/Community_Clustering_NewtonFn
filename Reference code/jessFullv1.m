function jessFull

zz=-29:.01:29;
zz(2501)=[];   
allvals = [];
correctedvs =[];
c=2;
for i=1:max(size(zz))
    %disp("z="+zz(i));
    values = newton2(zz(i),100);
    correctedvs = [correctedvs -(imag(c*values^2/(pi*zz(i))))];
    allvals = [allvals values];
    
end

y= allvals;
y2 = correctedvs;

plot(zz,y2);

end


function [y] =newton2(z,iter)
c=2;

guess =  -i;%(z-sqrt(z^2-4*c))/(2*c);%z*i+z; //starting point
current = 0;

k1=60;
k2=120;

for(ii=1:iter)
    f= func1examplenewt2(z,guess);
    fp = k1*k2*guess^2*3-(k1+k2)*z*guess*2+(2*k1*k2)/(k1+k2)+z^2; %z-2*c*guess;
    %  y=k1*k2*guess^3-(k1+k2)*z*guess^2+(2*k1*k2/(k1+k2)+z^2)*guess-z;

    %fp = (-guess)/(z-2*c*guess);
    %fp = 1/8*(z/(sqrt(z^2-8))+1);
    current = guess - f/fp;
     
    guess = current;
    
end
y = current;
end

function [y] = func1examplenewt2(z, guess)
k1=60;
k2=120;
y=k1*k2*guess^3-(k1+k2)*z*guess^2+(2*k1*k2/(k1+k2)+z^2)*guess-z;
%y=guess-(1/(z-c*guess));
end