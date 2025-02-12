function shakCode %Original Code

    %start
    tic
    clearvars;              % Clear variables
    zz=-5:0.1:5;            % Create a row vector zz from -29 to 30. Size 6000
    zz = zz(zz ~= 0);
    zz=transpose(zz);
    
    n=max(size(zz));        % Alpha size variable
    alpha=randl(1,[n,1]);   % Creates a 1D vector of size n,1 (200,1). Inserts rand value bw 0 & 1. 
    %disp(alpha)            % The first arg just satisfies a condition in the func definition.  
    m=norm(sum(alpha))/2;   % Norm gives Euclidean length. i.e sq root of sum of squares of all elements in a vector.
                            % Sum of alpha gives a single element as output and norm squares and sq.roots the element. 
                            % (Negative is not possible as randl gives nums bw 0 & 1).

    y2=iteratoverfuncnewton(alpha,zz,m,n); % Control transferred to function def
    plot(zz,y2) % final graph plotted

    % Stop the timer and display the elapsed time
    elapsedTime = toc;
    disp(['Execution time: ' num2str(elapsedTime) ' seconds']);
     
    elapsedTime = toc / 60;
    fprintf('Execution time: %.4f minutes\n', elapsedTime);

end

function y = iteratoverfuncnewton(alpha,zz,m,n) 
    % Args (alpha= 200 element vector, zz= 6000 iterations, m= half of euclidean distance)
    
   % n=max(size(alpha)); % Same as previous n. n=200 
    correctedvs =zeros(max(size(zz)),1); % correctedvs is a vector of zeros with same size as zz. 6000,1 zeros.
    
    %guess=-1i;
    for i=1:max(size(zz)) % loop for 6000 iterations
        values = newton(zz(i),alpha, m, 5,n);   
        % Control to newton; Args( Each element of 6000 iteration vector, 200 rand values vector, m=euc dist, 25 = iterations 
        correctedvs(i) = -(imag((values^2)/(n*pi*zz(i)))) ;  % why (n*pi*zz(i)??
        % allvals =[ allvals values];
        %guess=values;
        disp("z="+zz(i))
    end
    disp("val="+values)
    % disp("correctedvs="+correctedvs)

    
    y= correctedvs;
    end

    function [y] =newton(z,alpha, m, iter,n) % iter is 25
    %c=2;
    
    guess =  -1i; %(z-sqrt(z^2-4*c))/(2*c);%z*i+z;
    current = 0;
    for ii=1:iter % iter is 25
        [f,fp]= func1examplenewt(z,alpha,m,guess,n);
        %fp = z-2*c*guess;
        %fp = (-guess)/(z-2*c*guess);
        %fp = 1/8*(z/(sqrt(z^2-8))+1);
      if (fp~=0)
        current = guess - f/fp;
        guess = current;
      end
        
    end
    disp(f);
    y = guess;
    end

    function [y,dy] = func1examplenewt(z, alpha, m, guess,n)
    % n=max(size(zz)); %n=200 
    xp=1; yp=0; %zp=0;
    rp=0;
    for i=1:n % iterates for every value of alpha. 
        % The starting point is computed with every value of alpha. Product is saved in xp
        xp=xp*(z-alpha(i)*guess); % xp = 1*(29.98-0.4354*-sqrt(-1))
    end  

    for i=1:n
        if (z-alpha(i)*guess~=0)
            yp=yp+alpha(i)*(xp/(z-alpha(i)*guess)); % 200 iterations of aplha. Computation's product is stored in yp
        end
        % zp=zp+xp/(z-alpha(i)*guess);
    end
    y=2*m*guess*xp-yp;     % Omit dividing by 2 in the beginning and remove 2 here.
    for i=1:n
        for j=1:n
            if i~=j
                ff=(z-alpha(i)*guess)*(z-alpha(j)*guess);
                if (ff~=0)
                    rp=rp+ alpha(i)*(alpha(j)*xp/ff);
                end
            end
        end
    end
    dy=2*m*(xp-guess*yp) +rp;
    end
