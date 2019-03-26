function result = filter_matte_version2(rgb,G,matte)
%this function is to filter the rgb image by G, using the mask base
%use the same filter.
if nargin~=3
    error('the input is error!')
end
if size(G,1)~=size(G,2) && rem(size(G,0),2) ~=1
    error('the G is error!');
end
rgb=double(rgb);
rgb_front=rgb.*matte;
matte_back=1-matte;
kernel_size=size(G,1)*size(G,2);
kernel_n=ones(size(G,1),size(G,2));
%caculate the total weight to divide.
matte_back_num=imfilter(matte_back,kernel_n);
G_big=kernel_size.*G;
rgb_back=rgb.*matte_back;
rgb_back=imfilter(rgb_back,G_big);
rgb_back=rgb_back./double(matte_back_num);
rgb_back(isnan(rgb_back))=0;
result=rgb_front+matte_back.*rgb_back;
end
