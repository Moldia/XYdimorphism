
%% age info
[~, ~, raw] = xlsread('E:\PROOOJECTS\10_XY_dimorphism\Info\age_info.xlsx','Sheet1');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);

sample = cellVectors(:,1);
age = cellVectors(:,2);
sample = sample(2:end);
age = age(2:end);
clearvars data raw cellVectors;

%% NLGN4
% read data, format sample name and calculate age
dataratio = importdata(['Histograms_atan_NLGN4\integration_NLGN4_0.8' '_CI_reordered_nooutlier.csv'],',',1);
data = dataratio.data;
percent = [data(:,[1:3])./repmat(sum(data(:,1:3),2),1,3),data(:,[4:6])./repmat(sum(data(:,4:6),2),1,3)];
YLabori = cell(size(percent,1),1);
sampleage = zeros(size(percent,1),1);
organ = dataratio.textdata(2:end,2);
samples = cell(size(percent,1),1);

for i = 1:size(percent,1)
    temp = strsplit(dataratio.textdata{1+i,1},'_');
    YLabori(i) = {[temp{1} '\_' temp{2} '-' dataratio.textdata{1+i,2}]};
    samples(i) = {[temp{1} '\_' temp{2}]};
    temp = strcmp(temp{1},sample);
    temp = age{temp};
    temp = strtok(temp,'W');
    temp = strsplit(temp,'D');
    sampleage(i) = str2double(temp{1})*7 + str2double(temp{2});
end

% sort based on age
[age_sort,idx_age] = sort(sampleage);

% sort based on organ
[organ_sort,idx_organ] = sort(organ);

% sort based on sample
% [sample_sort,idx_sample] = sort(samples);
idx_sample = 1:length(samples);

% bar plots
% stacked bar plot sorted based on organ
percent_bar = zeros(size(percent,1)*4,3);
l = 1:length(percent_bar);
percent_bar(mod(l,4)==2,:) = percent(idx_organ,1:3);
percent_bar(mod(l,4)==3,:) = percent(idx_organ,4:6);
figure;
h = bar(percent_bar,'stack');
colormap([0 1 1; 1 1 1; 1 0 0]);
title('NLGN4');
ylabel('relative pixel frequency','fontsize',15);
set(gca,'XTick',2.5:4:length(percent_bar),'XTickLabel',samples(idx_organ),'XTickLabelRotation',90,...
    'YLim',[0 1]);
legend({'X-dominant','mix','Y-dominant'},'location','NorthEastOutside');
drawnow;
ax1 = gca;
ax2 = axes('Position',ax1.Position,...
    'XAxisLocation','top','XLim',ax1.XLim,'XTickLabelRotation',45,...
    'XTick',2.5:4:length(percent_bar),'XTickLabel',organ_sort,...
    'YTick',[],'Color','none');
set(ax2,'Position',ax1.Position);
linkaxes([ax1,ax2],'xy');
hold on;
% error bars
for i = 1:length(samples)
    plot([4*i-1,4*i-1],data(idx_organ(i),7:8),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_organ(i),7),data(idx_organ(i),7)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_organ(i),8),data(idx_organ(i),8)],'k');
end
for i = 1:length(samples)
    plot([4*i-1,4*i-1],1-data(idx_organ(i),9:10),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_organ(i),9),1-data(idx_organ(i),9)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_organ(i),10),1-data(idx_organ(i),10)],'k');
end

% stacked bar plot sorted based on age
percent_bar = zeros(size(percent,1)*4,3);
l = 1:length(percent_bar);
percent_bar(mod(l,4)==2,:) = percent(idx_age,1:3);
percent_bar(mod(l,4)==3,:) = percent(idx_age,4:6);
figure;
h = bar(percent_bar,'stack');
colormap([0 1 1; 1 1 1; 1 0 0]);
title('NLGN4');
ylabel('relative pixel frequency','fontsize',15);
set(gca,'XTick',2.5:4:length(percent_bar),'XTickLabel',samples(idx_age),'XTickLabelRotation',90);
legend({'X-dominant','mix','Y-dominant'},'location','NorthEastOutside');
drawnow;
ax1 = gca;
ax2 = axes('Position',ax1.Position,...
    'XAxisLocation','top','XLim',ax1.XLim,...
    'XTick',2.5:4:length(percent_bar),'XTickLabel',age_sort,...
    'YTick',[],'Color','none');
set(ax2,'Position',ax1.Position);
linkaxes([ax1,ax2],'xy');
hold on;
% error bars
for i = 1:length(samples)
    plot([4*i-1,4*i-1],data(idx_age(i),7:8),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_age(i),7),data(idx_age(i),7)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_age(i),8),data(idx_age(i),8)],'k');
end
for i = 1:length(samples)
    plot([4*i-1,4*i-1],1-data(idx_age(i),9:10),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_age(i),9),1-data(idx_age(i),9)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_age(i),10),1-data(idx_age(i),10)],'k');
end


% stacked bar plot sorted based on sample
percent_bar = zeros(size(percent,1)*4,3);
l = 1:length(percent_bar);
percent_bar(mod(l,4)==2,:) = percent(idx_sample,1:3);
percent_bar(mod(l,4)==3,:) = percent(idx_sample,4:6);
figure;
h = bar(percent_bar,'stack');
colormap([0 1 1; 1 1 1; 1 0 0]);
title('NLGN4');
ylabel('relative pixel frequency','fontsize',15);
set(gca,'XTick',2.5:4:length(percent_bar),'XTickLabel',samples(idx_sample),'XTickLabelRotation',90);
legend({'X-dominant','mix','Y-dominant'},'location','NorthEastOutside');
hold on;
% error bars
for i = 1:length(samples)
    plot([4*i-1,4*i-1],data(idx_sample(i),7:8),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_sample(i),7),data(idx_sample(i),7)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_sample(i),8),data(idx_sample(i),8)],'k');
end
for i = 1:length(samples)
    plot([4*i-1,4*i-1],1-data(idx_sample(i),9:10),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_sample(i),9),1-data(idx_sample(i),9)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_sample(i),10),1-data(idx_sample(i),10)],'k');
end



%% PCDH11
% read data, format sample name and calculate age
dataratio = importdata(['Histograms_atan_PCDH11\integration_PCDH11_0.8' '_CI_reordered.csv'],',',1);
data = dataratio.data;
percent = [data(:,[1:3])./repmat(sum(data(:,1:3),2),1,3),data(:,[4:6])./repmat(sum(data(:,4:6),2),1,3)];
YLabori = cell(size(percent,1),1);
sampleage = zeros(size(percent,1),1);
organ = dataratio.textdata(2:end,2);
samples = cell(size(percent,1),1);

for i = 1:size(percent,1)
    temp = strsplit(dataratio.textdata{1+i,1},'_');
    YLabori(i) = {[temp{1} '\_' temp{2} '-' dataratio.textdata{1+i,2}]};
    samples(i) = {[temp{1} '\_' temp{2}]};
    temp = strcmp(temp{1},sample);
    temp = age{temp};
    temp = strtok(temp,'W');
    temp = strsplit(temp,'D');
    sampleage(i) = str2double(temp{1})*7 + str2double(temp{2});
end

% sort based on age
[age_sort,idx_age] = sort(sampleage);

% sort based on organ
[organ_sort,idx_organ] = sort(organ);

% sort based on sample
% [sample_sort,idx_sample] = sort(samples);
idx_sample = 1:length(samples);

% bar plots
% stacked bar plot sorted based on organ
percent_bar = zeros(size(percent,1)*4,3);
l = 1:length(percent_bar);
percent_bar(mod(l,4)==2,:) = percent(idx_organ,1:3);
percent_bar(mod(l,4)==3,:) = percent(idx_organ,4:6);
figure;
h = bar(percent_bar,'stack');
colormap([0 1 1; 1 1 1; 1 0 0]);
title('PCDH11');
ylabel('relative pixel frequency','fontsize',15);
set(gca,'XTick',2.5:4:length(percent_bar),'XTickLabel',samples(idx_organ),'XTickLabelRotation',90,...
    'YLim',[0 1]);
legend({'X-dominant','mix','Y-dominant'},'location','NorthEastOutside');
drawnow;
ax1 = gca;
ax2 = axes('Position',ax1.Position,...
    'XAxisLocation','top','XLim',ax1.XLim,'XTickLabelRotation',45,...
    'XTick',2.5:4:length(percent_bar),'XTickLabel',organ_sort,...
    'YTick',[],'Color','none');
set(ax2,'Position',ax1.Position);
linkaxes([ax1,ax2],'xy');
hold on;
% error bars
for i = 1:length(samples)
    plot([4*i-1,4*i-1],data(idx_organ(i),7:8),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_organ(i),7),data(idx_organ(i),7)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_organ(i),8),data(idx_organ(i),8)],'k');
end
for i = 1:length(samples)
    plot([4*i-1,4*i-1],1-data(idx_organ(i),9:10),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_organ(i),9),1-data(idx_organ(i),9)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_organ(i),10),1-data(idx_organ(i),10)],'k');
end

% stacked bar plot sorted based on age
percent_bar = zeros(size(percent,1)*4,3);
l = 1:length(percent_bar);
percent_bar(mod(l,4)==2,:) = percent(idx_age,1:3);
percent_bar(mod(l,4)==3,:) = percent(idx_age,4:6);
figure;
h = bar(percent_bar,'stack');
colormap([0 1 1; 1 1 1; 1 0 0]);
title('PCDH11');
ylabel('relative pixel frequency','fontsize',15);
set(gca,'XTick',2.5:4:length(percent_bar),'XTickLabel',samples(idx_age),'XTickLabelRotation',90);
legend({'X-dominant','mix','Y-dominant'},'location','NorthEastOutside');
drawnow;
ax1 = gca;
ax2 = axes('Position',ax1.Position,...
    'XAxisLocation','top','XLim',ax1.XLim,...
    'XTick',2.5:4:length(percent_bar),'XTickLabel',age_sort,...
    'YTick',[],'Color','none');
set(ax2,'Position',ax1.Position);
linkaxes([ax1,ax2],'xy');
hold on;
% error bars
for i = 1:length(samples)
    plot([4*i-1,4*i-1],data(idx_age(i),7:8),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_age(i),7),data(idx_age(i),7)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_age(i),8),data(idx_age(i),8)],'k');
end
for i = 1:length(samples)
    plot([4*i-1,4*i-1],1-data(idx_age(i),9:10),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_age(i),9),1-data(idx_age(i),9)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_age(i),10),1-data(idx_age(i),10)],'k');
end

% stacked bar plot sorted based on sample
percent_bar = zeros(size(percent,1)*4,3);
l = 1:length(percent_bar);
percent_bar(mod(l,4)==2,:) = percent(idx_sample,1:3);
percent_bar(mod(l,4)==3,:) = percent(idx_sample,4:6);
figure;
h = bar(percent_bar,'stack');
colormap([0 1 1; 1 1 1; 1 0 0]);
title('PCDH11');
ylabel('relative pixel frequency','fontsize',15);
set(gca,'XTick',2.5:4:length(percent_bar),'XTickLabel',samples(idx_sample),'XTickLabelRotation',90);
legend({'X-dominant','mix','Y-dominant'},'location','NorthEastOutside');
hold on;
% error bars
for i = 1:length(samples)
    plot([4*i-1,4*i-1],data(idx_sample(i),7:8),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_sample(i),7),data(idx_sample(i),7)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[data(idx_sample(i),8),data(idx_sample(i),8)],'k');
end
for i = 1:length(samples)
    plot([4*i-1,4*i-1],1-data(idx_sample(i),9:10),'k','linewidth',1);
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_sample(i),9),1-data(idx_sample(i),9)],'k');
end
for i = 1:length(samples)
    plot([4*i-1-.3,4*i-1+.3],[1-data(idx_sample(i),10),1-data(idx_sample(i),10)],'k');
end