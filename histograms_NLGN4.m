
%% shuffle & heatmaps
load('sample_dual.mat');
Sample_dual = Sample;
load('sample_NLGN4.mat');
Sample = [Sample;Sample_dual];
% width
bandwid = 75;
mkdir('1D histograms');
bins = 200;
rep = 100;

for s = 1:length(Sample)
    if strcmp(Sample{s,3},'male')
        decoded_file = [Sample{s,1} '_' Sample{s,2} '.csv'];
        image = [Sample{s,1} '_backimage.png'];
        nameset = {'NLGN4X','NLGN4Y'};
        
        % get position and names
        [name,Pos] = getinsitudata_f(decoded_file,1,4,3);
        [name_uni,~,idx_re] = unique(name);
        [p,q] = hist(idx_re,unique(idx_re));
        % image size
        imgin = imfinfo(image);
        Isize = [imgin.Height,imgin.Width];
        
        figure; hold on;
%         set(gcf,'Name',Sample{s},'Units','Normalized','Position',[0.025 0.4 0.9 0.3]);
        
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
                Color1 = Itemp/max(fh(:));
                Color1 = reshape(Color1,[],1);
                numx = size(pos_query,1);
            else
                Color2 = Itemp/max(fh(:));
                Color2 = reshape(Color2,[],1);
                numy = size(pos_query,1);
            end
            
        end
        black = Color1==0 & Color2==0;
        %         [his,b] = hist3([color1(~black),color2(~black)],[200,200]);
        
%         ratio = (Color2(~black)/max(Color2))./(Color1(~black)/max(Color1));
        ratio = Color2(~black)./Color1(~black);
%         ratio = (Color2(~black)/numy)./(Color1(~black)/numx);
%         max2 = unique(ratio);
%         max2 = max2(end-1);
%         ratio(ratio==Inf)=max2;
        [his1,b1] = hist(Color1(~black),bins);
        [his2,b2] = hist(Color2(~black),bins);
        [his3,b3] = hist(log(ratio),bins);
        [his4,b4] = hist(atan(ratio),(0:2:90)/180*pi);
        
        subplot(2,2,1);
        hold on;
        plot(1:bins,his1,'linewidth',1);
        set(gca,'YScale','Log');
        subplot(2,2,2);
        hold on;
        plot(1:bins,his2,'linewidth',1);
        set(gca,'YScale','Log');
        subplot(2,2,3);
        hold on;
        plot(b3,his3,'linewidth',1);
        set(gca,'YScale','Log');
        subplot(2,2,4);
        hold on;
        plot(1:length(b4),his4,'linewidth',1);
        set(gca,'YScale','Log');

        
        
        His1 = zeros(bins,rep);
        His2 = zeros(bins,rep);
        His3 = zeros(bins,rep);
        His4 = zeros(length(b4),rep);
        for r = 1:rep
            list = 1:length(name);
            rand_order = randperm(length(list));
            name_rand = name(rand_order);
            [name_uni,~,idx_re] = unique(name_rand);
            [p,q] = hist(idx_re,unique(idx_re));
            
            %             merged = zeros(floor(Isize(1)/5),floor(Isize(2)/5),3);
            
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
                    color1 = reshape(color1,[],1);
                else
                    color2 = Itemp/max(fh(:));
                    color2 = reshape(color2,[],1);
                end
                
            end
            
            black = color1==0 & color2==0;
            
%             ratio = (color2(~black)/max(Color2))./(color1(~black)/max(Color1));
            ratio = color2(~black)./color1(~black);
%             ratio = (color2(~black)/numy)./(color1(~black)/numx);
%             max2 = unique(ratio);
%             max2 = max2(end-1);
%             ratio(ratio==Inf)=max2;
            [his1,~] = hist(color1(~black),b1);
            [his2,~] = hist(color2(~black),b2);
            [his3,~] = hist(log(ratio),b3);
            [his4,~] = hist(atan(ratio),b4);
            
            His1(:,r) = his1;
            His2(:,r) = his2;
            His3(:,r) = his3;
            His4(:,r) = his4;
        end
        
        subplot(2,2,1);
        hold on;
        plot(1:bins,mean(His1,2),'-.');
        plot(1:bins,mean(His1,2)+3*std(His1,0,2),'--','color',rgb('darkgrey'));
        plot(1:bins,mean(His1,2)-3*std(His1,0,2),'--','color',rgb('darkgrey'));
        set(gca,'XLim',[0 bins+1],'XTick',40:40:bins,'XTickLabel',round(b1(40:40:bins),1));
        xlabel('NLGN4X');
%         legend({'data','bootstrap'});
       
        subplot(2,2,2);
        hold on;
        plot(1:bins,mean(His2,2),'-.');
        plot(1:bins,mean(His2,2)+3*std(His2,0,2),'--','color',rgb('darkgrey'));
        plot(1:bins,mean(His2,2)-3*std(His2,0,2),'--','color',rgb('darkgrey'));
        set(gca,'XLim',[0 bins+1],'XTick',40:40:bins,'XTickLabel',round(b2(40:40:bins),1));
        xlabel('NLGN4Y');
        legend({'data','bootstrap'});

        subplot(2,2,3);
        hold on;
        plot(b3,mean(His3,2),'-.');
        plot(b3,mean(His3,2)+3*std(His3,0,2),'--','color',rgb('darkgrey'));
        plot(b3,mean(His3,2)-3*std(His3,0,2),'--','color',rgb('darkgrey'));
        xlabel('log(NLGN4Y/NLGN4X)');
%         set(gca,'XLim',[0 bins+1],'XTick',40:40:bins,'XTickLabel',round(b3(40:40:bins),1));
%         legend({'data','bootstrap'});
        
        subplot(2,2,4);
        hold on;
        plot(1:length(b4),mean(His4,2),'-.');
        plot(1:length(b4),mean(His4,2)+3*std(His4,0,2),'--','color',rgb('darkgrey'));
        plot(1:length(b4),mean(His4,2)-3*std(His4,0,2),'--','color',rgb('darkgrey'));
        xlabel('arctangent(NLGN4Y/NLGN4X)');
        set(gca,'XLim',[-1 length(b4)+1],'XTick',0:7.5:45,'XTickLabel',0:15:90);
%         legend({'data','bootstrap'});
        
        print(gcf,'-dpng','-r500',['Results\1D histograms\' Sample{s} '_histogram.png']);
    end
end

