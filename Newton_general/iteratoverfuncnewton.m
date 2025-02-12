function y = iteratoverfuncnewton(alpha,zz,m)
%zz=10:10;
%zz(1001)=[];
%allvals = [];
%c=2;
n=max(size(alpha));
correctedvs =zeros(max(size(zz)),1);
%guess=-1i;
for(i=1:max(size(zz)))
   
    values = newton(zz(i),alpha, m, 25); % Values Has corrected guess [h(zz(i))]
    correctedvs(i) = -(imag((values^2)/(n*pi*zz(i)))) ; % rho(z) in paper eq 28
   % allvals =[ allvals values];
    %guess=values;
    disp("z="+zz(i))
    
end

y= correctedvs;