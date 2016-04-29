clear all
close all
clc

I = imread('con8.jpg');
I = I(1:150,:,:);
Igray = rgb2gray(im2double(I));


thresholdRatio = 2.0; % a threshold of 1.9-2.1 seemed giving good results
                       % in out small and limited experiments so far

% Generating a grayscale image with the sky subtracted from it
Ithresh = Igray;
for i = 1:size(Igray,1)
    for j = 1:size(Igray,2);
        if(I(i,j,3)/ I(i,j,1) > thresholdRatio)
            Ithresh(i,j) = 0;
        end
    end
end

% Generating a Binary image of the grayscale image
Ithresh2 = zeros(size(Igray));
for i = 1:size(Igray,1)
    for j = 1:size(Igray,2);
        if(I(i,j,3)/ I(i,j,1) > thresholdRatio)
            Ithresh2(i,j) = 0;
        else
            Ithresh2(i,j) = 1;
        end
    end
end

% line stores the images with individualcontrails from the images
lines = zeros(size(Ithresh,1),size(Ithresh,2),1);
Ithresh3 = Ithresh2;
k = 1;
for i = 1:size(Igray,1)
    for j = 1:size(Igray,2);
        if(Ithresh3(i,j) == 1)
            ret = findLines(Ithresh2, i, j);
            if (sum(ret(:)) ~= 0)
                lines(:,:,k) = ret;
                Ithresh3 = Ithresh3 - lines(:,:,k);
                k = k+1;
                figure(32)
                imshow(Igray.*lines(:,:,k-1));
                pause;
            end
        end
    end
end


%%
% These Calculations are for the con4Height.jpg image for which we were
% able to gather all the needed information

Scale = (198/54) * (12 * 2.54 /100); %Calculated from the aircraft in the image
Area = sum(Ithresh(:)) * Scale^2;
Length = (650 - 275) * Scale;
Dia = 68.3 * 2.54 / 100;
Volume = Area * Dia;
Density = 0.17;
Mass = Volume * Density;
time = Length / (871 / 3.6); % Calculated with the assumed cruising speed of the aircraft
MassFromEngine = 817 * 0.453592 * time * 4; % aircraft has 4 engines

