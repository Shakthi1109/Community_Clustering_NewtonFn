function shakCodev2 % optimization failed

    tic
    clearvars;

    zz=-15:0.1:15;
    zz = zz(zz ~= 0);
    zz=transpose(zz);
    
    n=max(size(zz));
    alpha=rand(n, 1);
    
    m=norm(sum(alpha))/2; % removing sum lowers the probability
    
    y2=iteratoverfuncnewton(alpha,zz,m,n);
     disp(y2);
    plot(zz,y2)
    elapsedTime = toc;
    disp(['Execution time: ' num2str(elapsedTime) ' seconds']);
    fprintf('Execution time: %.4f minutes\n', elapsedTime/60);
end
    function y = iteratoverfuncnewton(alpha,zz,m,n)
    %OG code
    %correctedvs =zeros(max(size(zz)),1);
    % for i=1:max(size(zz))
    %     values = newton(zz(i),alpha, m, 25);
    %     correctedvs(i) = -(imag((values^2)/(n*pi*zz(i))));
    %     disp("z="+zz(i))
    % end

    % Assuming zz is a vector
    values = newton(zz, alpha, m, 25, n);
    correctedvs = -(imag((values.^2) ./ (n * pi * zz)));
    %disp(zz);

    y= correctedvs;
end

function [y] =newton(z,alpha, m, iter, n)
    guess =  -1i;
    for ii=1:iter
        [f,fp]= func1examplenewt(z,alpha,m,guess,n);
        if (fp~=0)
            current = guess - f/fp;
            guess = current;
        end
    end
    y = guess;
end

% function [y, dy] = func1examplenewt(z, alpha, m, guess,~)
% 
%     xp = 1;
%     rp = 0;
%     yp = 0;
% 
%     xp = xp .* (z - alpha) .* guess;
%     non_zero_indices = (z - alpha .* guess ~= 0);
%     yp = yp + alpha .* (xp ./ (z - alpha) ./ guess);
% 
%     y = 2 * m * guess .* xp - yp;
% 
%     ff = (z - alpha) .* guess;
%     non_zero_indices_ff = (ff ~= 0);
%     rp = rp + sum(alpha(non_zero_indices_ff) .* (alpha(non_zero_indices_ff) .* xp(non_zero_indices_ff) ./ ff(non_zero_indices_ff)));
% 
%     dy = 2 * m * (xp - guess .* yp) + rp;
% end
% 

%OG code
function [y,dy] = func1examplenewt(z, alpha, m, guess,n)

    xp=1; rp=0; yp=0;
    for i=1:n
        xp=xp*(z(i)-alpha(i)*guess);
    end
    for i=1:n
        if (z(i)-alpha(i)*guess~=0)
            yp=yp+alpha(i)*(xp/(z(i)-alpha(i)*guess));
        end
    end

    y=2*m*guess*xp-yp;

    for i=1:n
        for j=1:n
            if i~=j
                ff=(z(i)-alpha(i)*guess)*(z(i)-alpha(j)*guess);
                if (ff~=0)
                    rp=rp+ alpha(i)*(alpha(j)*xp/ff);
                end
            end
        end
    end
    dy=2*m*(xp-guess*yp) +rp;
end


% function [y,dy] = func1examplenewt(z, alpha, m, guess,~)
% 
%     xp=1; rp=0; yp=0;
%     xp=xp.*((z-alpha).*guess);
%     % if (z-alpha.*guess~=0)
%     yp=yp+alpha.*(xp./((z-alpha).*guess));
% 
% 
%     y=2*m*guess*xp-yp;
% 
%     % for i=1:n
%     %     for j=1:n
%     %         if i~=j
%     ff=((z-alpha).*guess).*((z-alpha).*guess);
%     rp=rp+ alpha.*(alpha.*xp./ff);
% 
%     dy=2*m*(xp-guess*yp) +rp;
% end
% 
