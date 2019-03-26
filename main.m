%% step 0(option). rotate the image based on the information of image.
% rgb=imread('IMG_2031.JPG');
% info=imfinfo('IMG_2031.JPG');
% if info.Orientation==8
%     rgb=imrotate(rgb,-270);
% else
%     rgb=imrotate(rgb,-90);
% end
% figure;imshow(rgb);
% imwrite(rgb,'IMG_2031_1.JPG');
%% step 1. version 2 matte smooth vector based.
rgb=imread('test/2.jpg');
matte=imread('test/2_mask.png');
matte=double(matte)/255.;
G=fspecial('gaussian',[81,81],81);
t1=clock;
rgb_matte_smooth=filter_matte_version2(rgb,G,matte);
t2=clock;
etime(t2,t1)
figure;
imshow(rgb_matte_smooth/256);
%% step 2.  save the image.
imwrite(uint8(rgb_matte_smooth),'test/result.png');
%%  (option very slow, just for Comparative Experiment)  matte pixel-wise
% rgb=imread('test/2.jpg');
% matte=imread('test/2_mask.png');
% matte=double(matte)/255.;
% G=fspecial('gaussian',[81,81],81);
% t1=clock;
% rgb_matte_smooth=filter_matte(rgb,G,matte);
% t2=clock;
% etime(t2,t1)
% figure;
% imshow(rgb_matte_smooth/256);
% imwrite(uint8(rgb_matte_smooth),'test/result_slow_version.png');