function [y y2] = iteratoverfuncnewton2()
zz=-25:.01:25;
zz(2501)=[];
allvals = [];
correctedvs =[];
c=2
for(i=1:max(size(zz)))
   
    values = newton2(zz(i),100);
    correctedvs = [correctedvs -(imag(c*values^2/(pi*zz(i)))) ];
    allvals =[ allvals values];
    
end

y= allvals;
y2 = correctedvs;