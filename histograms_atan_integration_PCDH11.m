%% atan(ratio) histograms, compared with randomized data
%  PCDH11
%  with 95% confidence envelopes
%  Xiaoyan, 2015-11-6

%% shuffle & ratio histograms & integration
load('E:\PROOOJECTS\10_XY_dimorphism\Info\sample_dual.mat');
Sample_dual = Sample;
load('E:\PROOOJECTS\10_XY_dimorphism\Info\sample_PCDH11.mat');
Sample = [Sample;Sample_dual];
% width
bandwid = 75;
mkdir('Histograms_atan_PCDH11');
% mkdir('Results\Histograms_atan_PCDH11_2std');
bins = 200;
rep = 100;
thres = 0.8;
step = 1;

%% boundaries
load('E:\PROOOJECTS\10_XY_dimorphism\Nuclei_full\Boundaries_all_untransformed.mat');

%% calculation
thres_ratio = thres/(1-thres);
Significant = {};
Integration = [];
Sample_male = {};

set(0, 'DefaultAxesFontName', 'arial')
figure;
for s = 1:length(Sample)
%     close all;
    if strcmp(Sample{s,3},'male')
		Sample_male = [Sample_male;Sample(s,:)];
        decoded_file = ['E:\PROOOJECTS\10_XY_dimorphism\Coordinates\' Sample{s,1} '_' Sample{s,2} '.csv'];
        image = ['E:\PROOOJECTS\10_XY_dimorphism\Nuclei_full\blank\' Sample{s,1} '_backimage.png'];
        nameset = {'PCDH11X','PCDH11Y'};
        
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
                numx = size(pos_query,1);
            else
                Color2 = Itemp/max(fh(:));
                Color2 = Color2(:);
                numy = size(pos_query,1);
            end
            
        end
        % all black pixels
        black = Color1==0 & Color2==0;
        
        % Y/X ratio
        ratio = Color2(~black)./Color1(~black);
        % histogram of atan(ratio)
        [his_4,b4] = hist(atan(ratio),(0:step:90)/180*pi);
        
        % plot
%         subplot(2,1,1);
%         hold off;
%         plot(1:length(b4),his_4,'linewidth',2);
%         set(gca,'YScale','Log');

		% randomization
        His4 = zeros(length(b4),rep);
        for r = 1:rep
            list = 1:length(name);
            rand_order = randperm(length(list));
            name_rand = name(rand_order);
            [name_uni,~,idx_re] = unique(name_rand);
            [p,q] = hist(idx_re,unique(idx_re));
                        
            for n = 1:2
                name_query = nameset{n};
                
                width = bandwid;
                
                idx_query = find(strcmp(name_uni,name_query));
                if isempty(idx_query)
                    error('No specified transcript detected in the input file');
                end
                pos_query = Pos(idx_re==idx_query,1:2);
                
                temp = floor(pos_query/5);
                temp(temp==0) = 1;
                Itemp = accumarray(fliplr(temp),1,floor(Isize/5));
                fh = fspecial('gaussian',width*2,width/5);
                Itemp = imfilter(Itemp,fh);
                
                if n == 1
                    color1 = Itemp/max(fh(:));
                    color1 = color1(:);
                else
                    color2 = Itemp/max(fh(:));
                    color2 = color2(:);
                end
                
            end
            
            black = color1==0 & color2==0;
            
            ratio = color2(~black)./color1(~black);
            [his4,~] = hist(atan(ratio),b4);
            
%             His3(:,r) = his3;
            His4(:,r) = his4;
        end
        
        Hismean = mean(His4,2);

%         % bigger or smaller than mean +- 2 or 3*std
%         Hisvaru = his_4'>Hismean+3*std(His4,0,2);
%         Hisvard = his_4'<Hismean-3*std(His4,0,2);
% %         Hisvaru = his_4'>Hismean+2*std(His4,0,2);
% %         Hisvard = his_4'<Hismean-2*std(His4,0,2);
% 
% %         Significant = [Significant;...
% %             [Sample(s,:),{[find(Hisvaru),(b4(Hisvaru))',(his_4(Hisvaru))']},{[find(Hisvard),(b4(Hisvard))',(his_4(Hisvard))']}]];
% %         
%         hold on;
%         xpoint = 1:length(b4);
%         plot(xpoint,Hismean,'-.','linewidth',1.5);
%         plot(xpoint,Hismean+3*std(His4,0,2),'--','color',rgb('gray'),'linewidth',1);
%         plot(xpoint,Hismean-3*std(His4,0,2),'--','color',rgb('gray'),'linewidth',1);
% %         plot(xpoint,Hismean+2*std(His4,0,2),'--','color',rgb('gray'),'linewidth',1);
% %         plot(xpoint,Hismean-2*std(His4,0,2),'--','color',rgb('gray'),'linewidth',1);
%  
%         % transparent area to show above threshold area
%         yalim = get(gca,'YLim');
		xlow = atan(1/thres_ratio)/pi*180/step;
		xhigh = atan(thres_ratio)/pi*180/step;
		
%         fill([0,0,xlow+1,xlow+1],[yalim(2),1,1,yalim(2)],'c','facealpha',0.1,'linestyle','none');
%         fill([xhigh+1,xhigh+1,length(b4)+1,length(b4)+1],[yalim(2),1,1,yalim(2)],'r','facealpha',0.1,'linestyle','none');
%    
%         % plot above or below 2 or 3*std data points
%         plot(xpoint(find(Hisvaru)),his_4(find(Hisvaru)),'y.','MarkerSize',8);
%         plot(xpoint(find(Hisvard)),his_4(find(Hisvard)),'y.','MarkerSize',8);
%         
%         xlabel('arctangent(PCDH11Y/PCDH11X)');
%         ylabel('pixel frequency');
%         set(gca,'XLim',[0 length(b4)+1],'XTick',linspace(1,xpoint(end),7),'XTickLabel',0:15:90,'YLim',yalim);
%         legend({'data','bootstrap','+ 3 std','- 3 std',},'Location','NorthEastOutside');
% %         print(gcf,'-dpng','-r500',['Results\Histograms_atan_PCDH11\' Sample{s} '_atan.png']);
% %         legend({'data','bootstrap','+ 2 std','- 2 std',},'Location','NorthEastOutside');
% %         print(gcf,'-dpng','-r500',['Results\Histograms_atan_PCDH11_2std\' Sample{s} '_atan.png']);
		 
        His4_percent = His4./repmat(sum(His4,1),length(b4),1);
        His4_percent_integrated = [sum(His4_percent(1:ceil(xlow),:),1);...
            sum(His4_percent(ceil(xlow)+1:floor(xhigh)-1,:),1);...
            sum(His4_percent(floor(xhigh):end,:),1)];

        Confidence_env = [Confidence_env; quantile(His4_percent_integrated(1,:),.025),quantile(His4_percent_integrated(1,:),.975),...
            quantile(His4_percent_integrated(3,:),.025),quantile(His4_percent_integrated(3,:),.975)];

        % integrate the frequencies
		Integration = [Integration;...
            [sum(his_4(1:ceil(xlow))),sum(his_4(ceil(xlow)+1:floor(xhigh)-1)),sum(his_4(floor(xhigh):end)),...
            sum(Hismean(1:ceil(xlow))),sum(Hismean(ceil(xlow)+1:floor(xhigh)-1)),sum(Hismean(floor(xhigh):end))]];
       
        
% %         hold off;
%         subplot(2,1,2);
%         bar([Integration(end,1:3)/sum(Integration(end,1:3));Integration(end,4:6)/sum(Integration(end,4:6))]')
%         set(gca,'XTick',1:3,'XTickLabel',{'X-dominant','mix','Y-dominant'});
% %         legend({'data','bootstrap'});
% %         print(gcf,'-dpng','-r500',['Results\Histograms_atan_PCDH11\' Sample{s} '_integrated.png']);
%         ylabel('relative frequency');
%         box off
%         legend({'data','bootstrap'},'Location','NorthEastOutside');
%         print(gcf,'-dpng','-r500',['Results\Histograms_atan_PCDH11\' Sample{s} '_new.png']);
    end
end
%% save variables and write to a file
save('Histograms_atan_PCDH11\PCDH11_ratio.mat','Significant','b4','His4_percent','Confidence_env','Integration');

datawrite = [Sample_male,num2cell([Integration,Confidence_env_new])];
datawrite = datawrite';
fid = fopen(['Histograms_atan_PCDH11\integration_PCDH11_' num2str(thres) '_confidence.csv'],'w');
fprintf(fid,'id,organ,sex,X_integrated,mix_integrated,Y_integrated,X_random_integrated,mix_random_integrated,Y_random_integrated,');
fprintf(fid,'X_random_integrated_percentage_confidence_low,X_random_integrated_percentage_confidence_high,Y_random_integrated_percentage_confidence_low,Y_random_integrated_percentage_confidence_high\n');
fprintf(fid,'%s,%s,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n',datawrite{:});
fclose(fid);


