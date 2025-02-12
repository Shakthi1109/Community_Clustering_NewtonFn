function shakCodev3 % Optimised code

    tic
    clearvars;
    zz = -15:0.1:15;    
    zz = zz(zz ~= 0);
    zz = transpose(zz);

    n = max(size(zz));
    alpha = rand(n, 1);
    m = norm(sum(alpha)) / 2;

    y2 = iteratoverfuncnewton(alpha, zz, m, n);
    plot(zz, y2)

    elapsedTime = toc;
    disp(['Execution time: ' num2str(elapsedTime) ' seconds']);
    elapsedTime = toc / 60;
    fprintf('Time in mins: %.4f minutes\n', elapsedTime);

end

function y = iteratoverfuncnewton(alpha, zz, m, n)

    correctedvs = zeros(n, 1);

    for i = 1:max(size(zz))
        disp(zz(i));
        values = newton(zz(i), alpha, m, 25);
        correctedvs(i) = -(imag((values^2) / (n * pi * zz(i))));
    end

    y = correctedvs;
end

function [y] = newton(z, alpha, m, iter)

    guess = -1i;
    for ii = 1:iter
        [f, fp] = func1examplenewt(z, alpha, m, guess);
        if (fp ~= 0)
            current = guess - f / fp;
            guess = current;
        end
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