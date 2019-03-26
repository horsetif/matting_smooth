function rgb_refine = filter_matte(rgb,G,matte)
%this function is to filter the rgb image by G, using the mask base
%use the same filter.
if nargin~=3
    error('the input is error!')
end
if size(G,1)~=size(G,2) && rem(size(G,0),2) ~=1
    error('the G is error!');
end
half_G=floor(size(G,1)/2);
%padding the rgb
rgb_padding=zeros(size(rgb,1)+2*half_G,size(rgb,2)+2*half_G,size(rgb,3));
%rgb_padding=im2uint8(rgb_padding);
rgb_padding(half_G+1:half_G+size(rgb,1),half_G+1:half_G+size(rgb,2),:)=rgb;
%test
%figure; imshow(rgb_padding/255);
%padding the mask
matte_padding=zeros(size(rgb,1)+2*half_G,size(rgb,2)+2*half_G);
matte_padding(half_G+1:half_G+size(rgb,1),half_G+1:half_G+size(rgb,2))=matte;
%
%figure;imshow(matte_padding/255);
%get the result
rgb_refine=rgb_padding;
%figure; imshow(rgb_refine);
rgb_padding=double(rgb_padding);
rgb_refine=double(rgb_refine);
%figure; imshow(rgb_refine);
for i = half_G+1 : half_G+size(rgb,1)
    for j = half_G +1 : half_G+size(rgb,2)
        if matte_padding(i,j)~=1
            mask_cur=1-matte_padding(i-half_G:i+half_G,j-half_G:j+half_G);
            G_cur=G.*mask_cur;
            G_sum=sum(sum(G_cur));
            G_cur=G_cur/G_sum;
            sum_R=sum(sum(rgb_padding(i-half_G:i+half_G,j-half_G:j+half_G,1).*G_cur));
            sum_G=sum(sum(rgb_padding(i-half_G:i+half_G,j-half_G:j+half_G,2).*G_cur));
            sum_B=sum(sum(rgb_padding(i-half_G:i+half_G,j-half_G:j+half_G,3).*G_cur));
            rgb_refine(i,j,1)=rgb_refine(i,j,1)*matte_padding(i,j)+(1-matte_padding(i,j))*sum_R;
            rgb_refine(i,j,2)=rgb_refine(i,j,2)*matte_padding(i,j)+(1-matte_padding(i,j))*sum_G;
            rgb_refine(i,j,3)=rgb_refine(i,j,3)*matte_padding(i,j)+(1-matte_padding(i,j))*sum_B;
        end
    end
end
figure; imshow(rgb_refine,[]);
%rgb_refine=im2uint8(rgb_refine);
rgb_refine=rgb_refine(half_G+1:half_G+size(rgb,1),half_G+1:half_G+size(rgb,2),:);
end
