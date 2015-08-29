close all
clear all
clc

%reading and converting the image
inImage=imread('C:\Users\zia ali\Desktop\Linear Algebra\pic.jpg');
inImage=rgb2gray(inImage);
imshow(inImage);
inImageD=double(inImage);

% decomposing the image using singular value decomposition
[U,S,V]=svd(inImageD);

% Using different number of singular values (diagonal of S) to compress and
% reconstruct the image
dispEr = [];
numSVals = [];
for N=1:50:300
    % store the singular values in a temporary var
    C = S;

    % discard the diagonal values not required for compression
    C(N+1:end,:)=0;
    C(:,N+1:end)=0;

    % Construct an Image using the selected singular values
    D=U*C*V';


    % display and compute error
    figure;
    buffer = sprintf('Image output using %d singular values', N)
    imshow(uint8(D));
    %imwrite(D,'final.jpg');
    title(buffer);
    error=sum(sum((inImageD-D).^2));

    % store vals for display
    dispEr = [dispEr; error];
    numSVals = [numSVals; N];
end

% dislay the error graph
figure; 
title('Error in compression');
plot(numSVals, dispEr);

grid on
xlabel('Number of Singular Values used');
ylabel('Error between compress and original image');