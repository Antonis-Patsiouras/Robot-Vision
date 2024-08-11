function PSNR = psnr(i1,i2)
    arith = 0;
    R = max(i2(:,:));
    R = max(R);
    i1 = double(i1);
    i2 = double(i2);
    R = double(R);
    
    for i = 1:size(i1,1)
        for j = 1:size(i1,2)
            arith=arith+((i1(i,j)-i2(i,j))^2);
        end
    end
    
    MSE = arith/(size(i1,1)*size(i1,2));
      
    PSNR = 10 * log10((R^2)/MSE);
end
            