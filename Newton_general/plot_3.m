clearvars;
zz=-29.99:.01:30; %x-axis
n=200;
alpha=randl(1,[n,1]);
m=norm(sum(alpha))/2;
y2=iteratoverfuncnewton(alpha,zz,m);
plot(zz,y2)
%axis equal