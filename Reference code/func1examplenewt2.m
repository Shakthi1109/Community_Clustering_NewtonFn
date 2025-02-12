function [y] = func1examplenewt2(z, guess)
k1=60;
k2=120;
y=k1*k2*guess^3-(k1+k2)*z*guess^2+(2*k1*k2/(k1+k2)+z^2)*guess-z;
%y=guess-(1/(z-c*guess));