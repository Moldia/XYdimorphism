%% NLGN4 SC female
backimage = imread('Transformed\E31_S56_transformed.tif');
dapi = im2bw(backimage,graythresh(backimage)*0.5);
dapi = imclose(dapi,strel('disk',50));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',80));
dapi = imopen(dapi,strel('disk',70));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E31_S56_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E31_S56 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E31_S56(:,1),lines_E31_S56(:,2),'--');
save('Transformed\boundaries.mat','lines_E31_S56','-append');

%% NLGN4 SC male
backimage = imread('Transformed\E26_S65_transformed.tif');
imshow(backimage,[]);
% h = impoly;
% pos = getPosition(h);
% nuclei_roi = roipoly(backimage,pos(:,1),pos(:,2));
% backimage = backimage.*uint8(nuclei_roi);
dapi = im2bw(backimage,graythresh(backimage)*.5);
dapi = imclose(dapi,strel('disk',60));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',80));
dapi = imopen(dapi,strel('disk',70));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['E26_S65_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E26_S65 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E26_S65(:,1),lines_E26_S65(:,2),'--');
save('boundaries.mat','lines_E26_S65','-append');

%% NLGN4 MO female
backimage = imread('Transformed\E33_S62_transformed.tif');
dapi = im2bw(backimage,graythresh(backimage)*.5);
dapi = imclose(dapi,strel('disk',60));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',60));
dapi = imopen(dapi,strel('disk',70));
dapi = imclose(dapi,strel('disk',100));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E33_S62_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E33_S62 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E33_S62(:,1),lines_E33_S62(:,2),'--');
save('Transformed\boundaries.mat','lines_E33_S62','-append');

%% NLGN4 MO male
backimage = imread('Transformed\E61_S89_transformed.tif');
dapi = im2bw(backimage,graythresh(backimage)*.2);
dapi = imclose(dapi,strel('disk',60));
dapi = imfill(dapi,'holes');
dapi = imdilate(dapi,strel('disk',20));
dapi = imopen(dapi,strel('disk',60));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E61_S89_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E61_S89 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E61_S89(:,1),lines_E61_S89(:,2),'--');
save('Transformed\boundaries.mat','lines_E61_S89','-append');

%% PCDH11 SC female
backimage = imread('Transformed\E27_S44_transformed.tif');
imshow(backimage,[]);
h = impoly;
pos = getPosition(h);
nuclei_roi = roipoly(backimage,pos(:,1),pos(:,2));
backimage = backimage.*uint8(nuclei_roi);
dapi = im2bw(backimage,graythresh(backimage)*0.5);
% dapi = imopen(dapi,strel('disk',12));
dapi = imclose(dapi,strel('disk',40));
dapi = imfill(dapi,'holes');
dapi = imdilate(dapi,strel('disk',20));
dapi = imopen(dapi,strel('disk',70));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E27_S44_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E27_S44 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E27_S44(:,1),lines_E27_S44(:,2),'--');
save('Transformed\boundaries.mat','lines_E27_S44','-append');

%% PCDH11 SC male
backimage = imread('Transformed\E32_S84_transformed.tif');
imshow(backimage,[]);
h = impoly;
pos = getPosition(h);
nuclei_roi = roipoly(backimage,pos(:,1),pos(:,2));
backimage = backimage.*uint8(nuclei_roi);
dapi = im2bw(backimage,graythresh(backimage)*0.5);
dapi = imclose(dapi,strel('disk',60));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',80));
dapi = imopen(dapi,strel('disk',70));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E32_S84_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E32_S84 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E32_S84(:,1),lines_E32_S84(:,2),'--');
save('Transformed\boundaries.mat','lines_E32_S84','-append');

%% PCDH11 MO female
backimage = imread('Transformed\E33_S50_transformed.tif');
imshow(backimage,[]);
dapi = im2bw(backimage,graythresh(backimage)*0.7);
dapi = imclose(dapi,strel('disk',60));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',80));
dapi = imopen(dapi,strel('disk',70));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E33_S50_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E33_S50 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E33_S50(:,1),lines_E33_S50(:,2),'--');
save('Transformed\boundaries.mat','lines_E33_S50','-append');

%% PCDH11 MO male
backimage = imread('Transformed\E45_S50_transformed.tif');
imshow(backimage,[]);
dapi = im2bw(backimage,graythresh(backimage)*0.7);
dapi = imclose(dapi,strel('disk',60));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',120));
dapi = imopen(dapi,strel('disk',70));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E45_S50_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E45_S50 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E45_S50(:,1),lines_E45_S50(:,2),'--');
save('Transformed\boundaries.mat','lines_E45_S50','-append');

%% NLGN4 SC female new
backimage = imread('Transformed\E49_S82_transformed.tif');
imshow(backimage,[]);
h = impoly;
pos = getPosition(h);
nuclei_roi = roipoly(backimage,pos(:,1),pos(:,2));
backimage = backimage.*uint8(nuclei_roi);
dapi = im2bw(backimage,graythresh(backimage));
dapi = imclose(dapi,strel('disk',50));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',70));
dapi = imopen(dapi,strel('disk',70));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E49_S82_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E49_S82 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E49_S82(:,1),lines_E49_S82(:,2),'--');
save('Transformed\boundaries.mat','lines_E49_S82','-append');

%% PCDH11 SC female new
backimage = imread('Transformed\E31_S91_transformed.tif');
imshow(backimage,[]);
dapi = im2bw(backimage,graythresh(backimage)*0.5);
% dapi = imopen(dapi,strel('disk',12));
dapi = imclose(dapi,strel('disk',40));
dapi = imfill(dapi,'holes');
dapi = imdilate(dapi,strel('disk',20));
dapi = imopen(dapi,strel('disk',70));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E31_S91_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E31_S91 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E31_S91(:,1),lines_E31_S91(:,2),'--');
save('Transformed\boundaries.mat','lines_E31_S91','-append');

%% NLGN4 MO male new
backimage = imread('Transformed\E45_S48_transformed.tif');
dapi = im2bw(backimage,graythresh(backimage)*.2);
dapi = imclose(dapi,strel('disk',60));
dapi = imfill(dapi,'holes');
dapi = imdilate(dapi,strel('disk',20));
dapi = imopen(dapi,strel('disk',60));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E45_S48_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E45_S48 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E45_S48(:,1),lines_E45_S48(:,2),'--');
save('Transformed\boundaries.mat','lines_E45_S48','-append');

%% PCDH11 MO male new
backimage = imread('Transformed\E61_S72_transformed.tif');
imshow(backimage,[]);
dapi = im2bw(backimage,graythresh(backimage)*0.3);
dapi = imclose(dapi,strel('disk',30));
dapi = imfill(dapi,'holes');
dapi = imclose(dapi,strel('disk',80));
dapi = imopen(dapi,strel('disk',50));
dapi = imdilate(dapi,strel('disk',20));
imshow(dapi)

bound = uint8((imdilate(dapi,strel('disk',10))-dapi)*255);
Ibound = cat(3,backimage,backimage,backimage);
Ibound = Ibound + cat(3,bound,bound,zeros(size(bound)));
imshow(Ibound);
imwrite(Ibound,['Transformed\E61_S72_boundary.png'],'png');

lines = bwboundaries(imdilate(dapi,strel('disk',10)),'noholes');
lines_E61_S72 = [lines{1}(:,2),lines{1}(:,1)];
imshow(backimage,[]);
hold on;
plot(lines_E61_S72(:,1),lines_E61_S72(:,2),'--');
save('Transformed\boundaries.mat','lines_E61_S72','-append');
