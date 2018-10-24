
%% NLGN4 SC female
I = imread('E:\PROOOJECTS\10_XY_dimorphism\Nuclei_full\E31_S56_c1.tif');
Isize = size(I);
ang = 195;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 1500;
xleft = 1500;
Irot = Irot(yup+1:5700,xleft+1:6100);
imshow(Irot,[]);

posfile = importdata('E31_S56_SC.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E31_S56' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E31_S56' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E31_S56' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% NLGN4 SC male
I = imread('E:\PROOOJECTS\10_XY_dimorphism\Nuclei_full\E26_S65_c1.tif');
Isize = size(I);
ang = -160;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 750;
xleft = 1200;
Irot = Irot(yup+1:5280,xleft+1:5750);
imshow(Irot,[]);

posfile = importdata('E:\PROOOJECTS\10_XY_dimorphism\Coordinates\E26_S65_SC.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['E26_S65' '_transformed_plot']);

imwrite(Irot,['E26_S65' '_transformed.tif'],'tif');
fid = fopen(['E26_S65' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% NLGN4 MO female
I = imread('Nuclei_full\E33_S62_c1.tif');
Isize = size(I);
imshow(I,[]);
ang = 16;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 2500;
xleft = 1200;
Irot = Irot(yup+1:12500,xleft+1:18200);
imshow(Irot,[]);

posfile = importdata('E33_S62_MO.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E33_S62' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E33_S62' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E33_S62' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% NLGN4 MO male
I = imread('Nuclei_full\E61_S89_c1.tif');
Isize = size(I);
imshow(I,[]);
ang = 182;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 0;
xleft = 0;
Irot = Irot(yup+1:end,xleft+1:end);
imshow(Irot,[]);

posfile = importdata('E61_S89_MO.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E61_S89' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E61_S89' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E61_S89' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% PCDH11 SC female
I = imread('Nuclei_full\E27_S44_c1.tif');
Isize = size(I);
ang = 198;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 1100;
xleft = 1000;
Irot = Irot(yup+1:5700,xleft+1:6800);
imshow(Irot,[]);

posfile = importdata('E27_S44_SC.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E27_S44' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E27_S44' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E27_S44' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% PCDH11 SC male
I = imread('Nuclei_full\E32_S84_c1.tif');
Isize = size(I);
ang = 80;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 300;
xleft = 300;
Irot = Irot(yup+1:6800,xleft+1:8300);
imshow(Irot,[]);

posfile = importdata('E32_S84_SC.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E32_S84' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E32_S84' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E32_S84' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% PCDH11 MO female
I = imread('Nuclei_full\E33_S50_c1.tif');
Isize = size(I);
ang = 15;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 0;
xleft = 0;
Irot = Irot(yup+1:end,xleft+1:end);
imshow(Irot,[]);

posfile = importdata('E33_S50_MO.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E33_S50' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E33_S50' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E33_S50' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% PCDH11 MO male
I = imread('Nuclei_full\E45_S50_c1.tif');
Isize = size(I);
ang = 40;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 5000;
xleft = 0;
Irot = Irot(yup+1:18500,xleft+1:end);
imshow(Irot,[]);

posfile = importdata('E45_S50_MO.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E45_S50' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E45_S50' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E45_S50' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% NLGN4 SC female new
I = imread('Nuclei_full\E49_S82_c1.tif');
Isize = size(I);
ang = 180;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 0;
xleft = 0;
Irot = Irot(yup+1:end,xleft+1:end);
imshow(Irot,[]);

posfile = importdata('E49_S82_SC.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E49_S82' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E49_S82' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E49_S82' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% PCDH11 SC female new
I = imread('Nuclei_full\E31_S91_c1.tif');
Isize = size(I);
ang = -82;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 0;
xleft = 2000;
Irot = Irot(yup+1:5500,xleft+1:8100);
imshow(Irot,[]);

posfile = importdata('E31_S91_SC.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E31_S91' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E31_S91' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E31_S91' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% NLGN4 MO male new
I = imread('Nuclei_full\E45_S48_c1.tif');
Isize = size(I);
imshow(I,[]);
ang = 40;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 5000;
xleft = 0;
Irot = Irot(yup+1:17700,xleft+1:end);
imshow(Irot,[]);

posfile = importdata('E45_S48_MO.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E45_S48' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E45_S48' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E45_S48' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);

%% PCDH11 MO male new
I = imread('Nuclei_full\E61_S72_c1.tif');
imshow(I,[]);
Isize = size(I);
ang = 7;
Irot = imrotate(I,ang);
imshow(Irot,[]);
rotate_size = size(Irot);

yup = 300;
xleft = 0;
Irot = Irot(yup+1:end,xleft+1:end);
imshow(Irot,[]);

posfile = importdata('E61_S72_MO.csv',',',1);
pos = posfile.data;

pos_transformed = bsxfun(@minus,pos(:,4:5),floor(fliplr(Isize)/2));
rot_angle = -1*ang/180*pi;
rot_mat=[cos(rot_angle),sin(rot_angle);...
    -sin(rot_angle),cos(rot_angle)];
pos_transformed = pos_transformed*rot_mat;
pos_transformed = bsxfun(@plus,fliplr(rotate_size)/2,pos_transformed);
pos_transformed(:,1) = pos_transformed(:,1)-xleft;
pos_transformed(:,2) = pos_transformed(:,2)-yup;
hold on;
plot(pos_transformed(:,1),pos_transformed(:,2),'g.');
legend('all signals');
print(gcf,'-dpng','-r500',['Transformed\' 'E61_S72' '_transformed_plot']);

imwrite(Irot,['Transformed\' 'E61_S72' '_transformed.tif'],'tif');
fid = fopen(['Transformed\' 'E61_S72' '_transformed.csv'],'w');
pos_write = [posfile.textdata(:,1:3),...
    [[{'x_pos'},{'y_pos'},{'im_num'},{'transformed_x_global'},{'transformed_y_global'}];num2cell([posfile.data(:,1:3),pos_transformed])]];
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',pos_write{1,:});
pos_write(1,:) = [];
pos_write = pos_write';
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d\n',pos_write{:});
fclose(fid);
