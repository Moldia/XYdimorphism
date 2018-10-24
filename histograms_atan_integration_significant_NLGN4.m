
%% load results from hisograms_atan_integration
load('Histograms_atan_NLGN4\NLGN4_ratio.mat');
% load('Results\Histograms_atan_NLGN4_2std\NLGN4_ratio.mat');
load('E:\PROOOJECTS\10_XY_dimorphism\Nuclei_full\Boundaries_all_untransformed.mat');

%% parameters used in radonmization
bandwid = 75;
thres = 0.8;

%% 
thres_ratio = thres/(1-thres);
figure;
Integration = [];
% Sample_male = {};

Sample = Significant(:,1:2);
for s = 1:length(Sample)
%     close all;
%     if strcmp(Sample{s,3},'male')
% 		Sample_male = [Sample_male;Sample(s,:)];
        decoded_file = [Sample{s,1} '_' Sample{s,2} '.csv'];
        image = [Sample{s,1} '_backimage.png'];
        nameset = {'NLGN4X','NLGN4Y'};
        
        boundidx = strcmp(Boundaries(:,1),Sample{s,1});
        bound = Boundaries{boundidx,3};
        
        % get position and names
        [name,Pos] = getinsitudata_f(decoded_file,1,4,3);
        [name_uni,~,idx_re] = unique(name);
        [p,q] = hist(idx_re,unique(idx_re));
        % image size
        imgin = imfinfo(image);
        Isize = [imgin.Height,imgin.Width];
                
        for n = 1:2
            name_query = nameset{n};
            
            width = bandwid;
            
            idx_query = find(strcmp(name_uni,name_query));
            if isempty(idx_query)
                warning('No specified transcript detected in the input file');
                idx_query = 0;
            end
            pos_query = Pos(idx_re==idx_query,1:2);
            
            temp = floor(pos_query/5);
            temp(temp==0) = 1;
            Itemp = accumarray(fliplr(temp),1,floor(Isize/5));
            fh = fspecial('gaussian',width*2,width/5);
            Itemp = imfilter(Itemp,fh);
            
            if n == 1
                Color1 = Itemp/max(fh(:));
                Color1 = Color1(:);
            else
                Color2 = Itemp/max(fh(:));
                Color2 = Color2(:);
            end
            
        end
        black = Color1==0 & Color2==0;
        
%         ratio = (Color2(~black)/max(Color2))./(Color1(~black)/max(Color1));
        ratio = Color2(~black)./Color1(~black);
%         ratio = (Color2(~black)/numy)./(Color1(~black)/numx);
%         max2 = unique(ratio);
%         max2 = max2(end-1);
%         ratio(ratio==Inf)=max2;
%         [his3,b3] = hist(log(ratio),bins);
        [his_4,~] = hist(atan(ratio),b4);
        
        Hisvaru = Significant{s,4};
        Hisvard = Significant{s,5};
        
        step_hist = b4(2)-b4(1);
        xlow = atan(1/thres_ratio);
		xhigh = atan(thres_ratio);

        findvar = zeros(length(ratio),1);
        for i = 1:size(Hisvaru,1)
            if Hisvaru(i,2)<xlow || Hisvaru(i,2)>xhigh
                findvar = findvar | (atan(ratio) >= Hisvaru(i,2)-step_hist & atan(ratio) < Hisvaru(i,2)+step_hist);
            end
        end
        Findvar = zeros(length(Color1),1);
        Findvar(find(~black)) = double(findvar);
        
        clf;
        subplot(2,2,1);
        Ivar = cat(3,reshape(Color2.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)));
        Ivar = Ivar/max([Color1(:);Color2(:)])*2;
        imshow(Ivar);
        hold on;
        for b = 1:length(bound)
            plot(bound{b}(:,1)/5,bound{b}(:,2)/5,'--','color','w','linewidth',1);
        end
%         title('+3* std');
        title('+2* std');
        
        findvar = zeros(length(ratio),1);
        for i = 1:size(Hisvard,1)
            if Hisvard(i,2)<xlow || Hisvard(i,2)>xhigh
                findvar = findvar | (atan(ratio) >= Hisvard(i,2)-step_hist & atan(ratio) < Hisvard(i,2)+step_hist);
            end
        end
        Findvar = zeros(length(Color1),1);
        Findvar(find(~black)) = double(findvar);
        
        subplot(2,2,2);
        Ivar = cat(3,reshape(Color2.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)));
        Ivar = Ivar/max([Color1(:);Color2(:)])*2;
        imshow(Ivar);
        hold on;
        for b = 1:length(bound)
            plot(bound{b}(:,1)/5,bound{b}(:,2)/5,'--','color','w','linewidth',1);
        end
%         title('-3* std');
        title('-2* std');

        findvar = zeros(length(ratio),1);
        for i = 1:size(Hisvaru,1)
            if Hisvaru(i,2)>=xlow && Hisvaru(i,2)<=xhigh
                findvar = findvar | (atan(ratio) >= Hisvaru(i,2)-step_hist & atan(ratio) < Hisvaru(i,2)+step_hist);
            end
        end
        Findvar = zeros(length(Color1),1);
        Findvar(find(~black)) = double(findvar);
        
        subplot(2,2,3);
        Ivar = cat(3,reshape(Color2.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)));
        Ivar = Ivar/max([Color1(:);Color2(:)])*2;
        imshow(Ivar);
        hold on;
        for b = 1:length(bound)
            plot(bound{b}(:,1)/5,bound{b}(:,2)/5,'--','color','w','linewidth',1);
        end
%         title('mix +3* std');
        title('mix +2* std');

        findvar = zeros(length(ratio),1);
        for i = 1:size(Hisvard,1)
            if Hisvard(i,2)>=xlow && Hisvard(i,2)<=xhigh
                findvar = findvar | (atan(ratio) >= Hisvard(i,2)-step_hist & atan(ratio) < Hisvard(i,2)+step_hist);
            end
        end
        Findvar = zeros(length(Color1),1);
        Findvar(find(~black)) = double(findvar);
        
        subplot(2,2,4);
        Ivar = cat(3,reshape(Color2.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)),reshape(Color1.*Findvar,size(Itemp)));
        Ivar = Ivar/max([Color1(:);Color2(:)])*2;
        imshow(Ivar);
        hold on;
        for b = 1:length(bound)
            plot(bound{b}(:,1)/5,bound{b}(:,2)/5,'--','color','w','linewidth',1);
        end
%         title('mix -3* std');
        title('mix -2* std');

        set(gcf,'inverthardcopy','off')
        
%         print(gcf,'-dpng','-r500',['Histograms_atan_NLGN4\' Sample{s} '_significant.png']);
        print(gcf,'-dpng','-r500',['Histograms_atan_NLGN4_2std\' Sample{s} '_significant.png']);
        
end



