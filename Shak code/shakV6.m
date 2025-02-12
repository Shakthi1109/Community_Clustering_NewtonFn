function shakV6 % Optimised code

    tic
    clearvars;
    zz = -5:0.1:5;    
    zz = zz(zz ~= 0);
    zz = transpose(zz);

    n = max(size(zz));
    alpha = rand(n, 1);
    m = norm(sum(alpha)) / 2;

    y2 = iteratoverfuncnewton(alpha, zz, m, n);
    figure;
    plot(zz, y2);
    title('zz vs Gprime(h)');

    elapsedTime = toc;
    disp(['Execution time: ' num2str(elapsedTime) ' seconds']);
    elapsedTime = toc / 60;
    fprintf('Time in mins: %.4f minutes\n', elapsedTime);

end

function y = iteratoverfuncnewton(alpha, zz, m, n)

    correctedvs = zeros(n, 1);
    valueArr = zeros(n, 1);
    iter=25;

    for i = 1:max(size(zz))
        disp(zz(i));
        [out, values] = newton(zz(i), alpha, m, iter,zz,i);
        valueArr(i)=out;
        correctedvs(i) = -(imag((values^2) / (n * pi * zz(i))));
    end
    figure;
    plot(zz,valueArr);
    title('zz vs f');
    y = correctedvs;
    
end

function [out, y] = newton(z, alpha, m, iter, zz, i)

    guess = -1i;
    iterArr = zeros(iter, 1);
    fArr = zeros(iter, 1);
    ii = 1;  % Initialize loop counter
    epsilon = 1e-4;  % Set the epsilon value for termination
    f = 1e10;  % Initialize f as a large value
    
    while abs(f(end)) > epsilon
        %disp(abs(f(end)));
        [f, fp] = func1examplenewt(z, alpha, m, guess);
       
        if fp ~= 0  % Avoid division by zero
            current = guess - f / fp;
            guess = current;
        end
        %disp(f(end));
        if i == numel(zz)
            iterArr(ii) = ii;
            tempf = f(end);
            tempf = -imag(tempf^2);
            fArr(ii) = tempf;
        end
        
        ii = ii + 1;  % Increment the loop counter
    end
    out=mean(fArr);
    
    if i == numel(zz)
        figure;
        plot(iterArr(1:ii-1), fArr(1:ii-1));
        title('iter vs f');
    end
    
    y = guess;
end


function [y, dy] = func1examplenewt(z, alpha, m, guess)

    xp = 1;
    xp = xp .* (z - alpha * guess)';
    yp = sum(alpha .* xp ./ (z - alpha * guess));
    y = 2 * m * guess * xp - yp;
    rp = sum(alpha .* alpha .* xp ./ (z - alpha * guess) .* (z - alpha * guess), 1);
    dy = 2 * m * (xp - guess * yp) + rp;
end