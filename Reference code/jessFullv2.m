function jessFullv2

tic

zz=-25:.01:25;    % Input vector 6001 values
%zz(2501)=[];     % Removes 0 (Explained below)
allvals = [];     % Initialization
correctedvs =[];  % Initialization
c=2;
for i=1:max(size(zz))  % Loop every element in zz
    %disp("z="+zz(i));
    value = newton(zz(i),100);  % Pass each element of zz and iteration value
    correctedvs = [correctedvs -(imag(c*value^2/(pi*zz(i))))]; % Explained below
    %allvals = [allvals value];
end

%y= allvals;
y2 = correctedvs;
plot(zz,y2);


% Stop the timer and display the elapsed time
elapsedTime = toc;
disp(['Execution time: ' num2str(elapsedTime) ' seconds']);

elapsedTime = toc / 60;
fprintf('Execution time: %.4f minutes\n', elapsedTime);

end

function [y] =newton(z,iter)
c=2;
guess =  -i;%(z-sqrt(z^2-4*c))/(2*c);%z*i+z; //starting point
current = 0;

k1=60;  % Alpha
k2=120; % Alpha

for ii=1:iter  % Iterate
    f= func1examplenewt2(z,guess);
    % Explained below
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
y=k1*k2*guess^3-(k1+k2)*z*guess^2+(2*k1*k2/(k1+k2)+z^2)*guess-z;  % Explained below
%y=guess-(1/(z-c*guess));
end