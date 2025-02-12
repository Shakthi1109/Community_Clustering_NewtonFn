function [y,dy] = func1examplenewt(z, alpha, m, guess)
n=max(size(alpha));
xp=1; yp=0; %zp=0;
rp=0;
for (i=1:n)
    xp=xp*(z-alpha(i)*guess);
end
for (i=1:n)
    if (z-alpha(i)*guess~=0)
        yp=yp+alpha(i)*(xp/(z-alpha(i)*guess));
    end
   % zp=zp+xp/(z-alpha(i)*guess);
end
y=2*m*guess*xp-yp;
for (i=1:n)
    for(j=1:n)
        if(i~=j)
            ff=(z-alpha(i)*guess)*(z-alpha(j)*guess);
            if (ff~=0)
                rp=rp+ alpha(i)*(alpha(j)*xp/ff);
            end
        end
    end
end
dy=2*m*(xp-guess*yp) +rp;
