function MID = midpoint(I)
    pd = padarray(I,[1,1]);
    %MID = zeros(size(I,1),size(I,2));
    [r,c] = size(pd);
    for i=2:r-1
        for j=2:c-1
            out = [pd(i-1,j-1)
                pd(i-1,j)
                pd(i-1,j+1)
                pd(i,j-1)
                pd(i,j)
                pd(i,j+1)
                pd(i-1,j)
                pd(i+1,j-1)
                pd(i+1,j)
                pd(i+1,j+1)];
            a = max(out);
            b = min(out);
            MID(i,j) = (a+b)/2;
        end
    end
end