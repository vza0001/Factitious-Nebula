function [ imgRet ] = findLines( img, row, col )
%FINDLINES Summary of this function goes here
%   Detailed explanation goes here

imgRet = zeros(size(img));
imgRettemp = imgRet;
s = 0;

for i = 0:179
    for rows = 1:size(img,1)
        if (i>86 && i<94)
            cols = col;
        else
            cols = (rows - row) / cot(i*pi/180) + col;
        end
        if(floor(cols)>0 && ceil(cols) < size(img,2))
            imgRettemp(rows, ceil(cols)) = 1;
            imgRettemp(rows, floor(cols)) = 1;
        end        
    end
    imgRettest = img.*imgRettemp;
    if(s<sum(imgRettest(:)))
        s = sum(imgRettest(:));
        imgRet = imgRettest;
    end
    imgRettemp = zeros(size(img));
end

p = 10;

for i = 1:size(img,1)
    temp = imgRet(i,:);
    [~,j] = max(temp);
    if(temp(j)>0)
        if(j-p>0)
            j1 = j-p;
        else
            j1 = 1;
        end
        if (j+p>size(img,2))
            j2 = size(img,2);
        else
            j2 = j + p;
        end
        imgRet(i,j1:j2) = 1;
    end
end

imgRet = imgRet.*img;

if(s < min(size(img,1),size(img,2)))
    imgRet = zeros(size(img));
end
end

