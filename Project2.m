path = 'your-image';
img=imread(path);
disp('%%%%%%%%%%%%%%%%%%%%%------------%%%%%%%%%%%%%%%%%%%%');
i3 = img((size(img,1)/2)+1:size(img,1) , 1:size(img,2)/2,:);
%% salt & pepper

img1 = img(1:size(img,1)/2 , 1:size(img,2)/2,:);
sp1 = imnoise(img1,'salt & pepper',0.02);

sp1m = ordfilt2(sp1,5,ones(3,3));
sp1mp = psnr(img1,sp1m);
figure;
subplot(3,3,1),imshow(sp1m);
title('IMG 1 MEDFILT');
fileID = fopen('f.txt','w');
fprintf(fileID,'IMG 1 MEDFILT PSNR: %f\n',sp1mp);
fclose(fileID);

h11 = fspecial('average',[3 3]);
sp1am1 = imfilter(sp1,h11);
sp1am = ordfilt2(sp1am1, 2, ones(3));
sp1amp = psnr(img1,sp1am);
subplot(3,3,2),imshow(sp1am);
title('IMG 1 MEAN');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 1 MEAN PSNR: %f\n',sp1amp);
fclose(fileID);

sp1mi1 = midpoint(sp1);
sp1mi = ordfilt2(sp1mi1, 2, ones(3));
sp1mip = psnr(img1,sp1mi);
subplot(3,3,3),imshow(sp1mi);
title('IMG 1 MIDPOINT');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 1 MIDPOINT PSNR: %f\n',sp1mip);
fclose(fileID);
%% 

if (sp1mp > sp1amp) && (sp1mp > sp1mip)
    I1 = cat(1,sp1m,i3); %Συννένωση ως προς τον άξονα x
    disp('IMG 1 MEDFILT PSNR SELECTED:');
    disp(sp1mp);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 1 MEDFILT PSNR SELECTED: %f\n\n',sp1mp);
    fclose(fileID);
elseif (sp1amp > sp1mp) && (sp1amp > sp1mip)
    I1 = cat(1,sp1am,i3);
    disp('IMG 1 MEAN PSNR SELECTED:');
    disp(sp1amp);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 1 MEAN PSNR SELECTED: %f\n\n',sp1amp);
    fclose(fileID);
else
    I1 = cat(1,sp1mi,i3);
    disp('IMG 1 MIDPOINT PSNR SELECTED:');
    disp(sp1mip);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 1 MIDPOINT PSNR SELECTED: %f\n\n',sp1mip);
    fclose(fileID);
end
%% gaussian

img2 = img(1:size(img,1)/2 , (size(img,2)/2)+1:size(img,2),:); %Αποκοπή της εικόνας
g2 = imnoise(img2,'gaussian',0,0.003);

g2m = ordfilt2(g2,5,ones(3,3));
g2mp = psnr(img2,g2m);
subplot(3,3,4),imshow(g2m);
title('IMG 2 MEDFILT');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 2 MEDFILT PSNR: %f\n',g2mp);
fclose(fileID);

h21 = fspecial('average',[3 3]);
g2am1 = imfilter(g2,h21);
g2am = ordfilt2(g2am1, 2, ones(3));
g2amp = psnr(img2,g2am);
subplot(3,3,5),imshow(g2am);
title('IMG 2 MEAN');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 2 MEAN PSNR: %f\n',g2amp);
fclose(fileID);

g2mi1 = midpoint(g2);
g2mi = ordfilt2(g2mi1, 2, ones(3));
g2mip = psnr(img2,g2mi);
subplot(3,3,6),imshow(g2mi);
title('IMG 2 MIDPOINT');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 2 MIDPOINT PSNR: %f\n',g2mip);
fclose(fileID);
%% 

if (g2mp > g2amp) && (g2mp > g2mip)
    i2 = g2m; 
    disp('IMG 2 MEDFILT PSNR SELECTED:');
    disp(g2mp);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 2 MEDFILT PSNR SELECTED: %f\n\n',g2mp);
    fclose(fileID);
elseif (g2amp > g2mp) && (g2amp > g2mip)
    i2 = g2am;
    disp('IMG 2 MEAN PSNR SELECTED:');
    disp(g2amp);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 2 MEAN PSNR SELECTED: %f\n\n',g2amp);
    fclose(fileID);
else
    i2 = g2mi;
    disp('IMG 2 MIDPOINT PSNR SELECTED:');
    disp(g2mip);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 2 MIDPOINT PSNR SELECTED: %f\n\n',g2mip);
    fclose(fileID);
end
%% salt & pepper & gaussian

img4 = img((size(img,1)/2)+1:size(img,1) , (size(img,2)/2)+1:size(img,2),:);
spg4 = imnoise(img4,'salt & pepper',0.02);
spg4 = imnoise(spg4,'gaussian',0,0.003);

spg4m = ordfilt2(spg4,5,ones(3,3));
spg4mp = psnr(img4,spg4m);
subplot(3,3,7),imshow(spg4m);
title('IMG 4 MEDFILT');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 4 MEDFILT PSNR: %f\n',spg4mp);
fclose(fileID);

h41 = fspecial('average',[3 3]);
spg4am1 = imfilter(spg4,h41);
spg4am = ordfilt2(spg4am1, 2, ones(3));
spg4amp = psnr(img4,spg4am);
subplot(3,3,8),imshow(spg4am);
title('IMG 4 MEAN');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 4 MEAN PSNR: %f\n',spg4amp);
fclose(fileID);

spg4mi1 = midpoint(spg4);
spg4mi = ordfilt2(spg4mi1, 2, ones(3));
spg4mip = psnr(img4,spg4mi);
subplot(3,3,9),imshow(spg4mi);
title('IMG 4 MIDPOINT');
fileID = fopen('f.txt','a');
fprintf(fileID,'IMG 4 MIDPOINT PSNR: %f\n',spg4mip);
fclose(fileID);
%% 

if (spg4mp > spg4amp) && (spg4mp > spg4mip)
    I2 = cat(1,i2,spg4m); %Συννένωση ως προς τον άξονα x
    disp('IMG 4 MEDFILT PSNR SELECTED:');
    disp(spg4mp);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 4 MEDFILT PSNR SELECTED: %f\n\n',spg4mp);
    fclose(fileID);
elseif (spg4amp > spg4mp) && (spg4amp > spg4mip)
    I2 = cat(1,i2,spg4am);
    disp('IMG 4 MEAN PSNR SELECTED:');
    disp(spg4amp);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 4 MEAN PSNR SELECTED: %f\n\n',spg4amp);
    fclose(fileID);
else
    I2 = cat(1,i2,spg4mi);
    disp('IMG 4 MIDPOINT PSNR SELECTED:');
    disp(spg4mip);
    fileID = fopen('f.txt','a');
    fprintf(fileID,'IMG 4 MIDPOINT PSNR SELECTED: %f\n\n',spg4mip);
    fclose(fileID);
end
%% 

I = cat(2,I1,I2); %Συννένωση των 2 εικόνων ως προς τον άξονα y
figure;
imshow(I);
