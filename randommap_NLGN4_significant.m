
%% shuffle & heatmaps
load('sample.mat');
% width
bandwid = 75;
mkdir('Results\Significant_3std\');
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
            Igau = imfilter(Itemp,fh);
            
            if n == 1
                Color1 = Igau/max(fh(:));
            else
                Color2 = Igau/max(fh(:));
            end
        end
%         merged = cat(3,Color2,Color1,Color1);
%         imshow(merged/max(merged(:))*2)
        
        % bootstraping 50 replicates
%         Map_rand = zeros(bins,bins,rep);
        color1 = zeros(size(Color1,1),size(Color1,2),rep);
        color2 = zeros(size(Color1,1),size(Color1,2),rep);

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
                    color1(:,:,r) = Itemp/max(fh(:));
%                     color1 = reshape(color1,[],1);
                else
                    color2(:,:,r) = Itemp/max(fh(:));
%                     color2 = reshape(color2,[],1);
                end

            end
            
%             black = color1==0 & color2==0;
%             hist_rand = hist3([color1(~black),color2(~black)],b);
%             Map_rand(:,:,r) = hist_rand;
        end
        
        % average of replicates
%         Map_ave = cat(3,mean(color2,3)-2*std(color2,0,3),mean(color1,3)-2*std(color1,0,3),mean(color1,3)-2*std(color1,0,3));
%         Map_ave = cat(3,std(color2,0,3),std(color1,0,3),std(color1,0,3));
        imshow(Map_ave/max([Color1(:);Color2(:)])*2)
        
        % mean +- 3*std
        biovar1 = Color1>mean(color1,3)+2*std(color1,0,3) | Color1<mean(color1,3)-2*std(color1,0,3);
        biovar2 = Color2>mean(color2,3)+2*std(color2,0,3) | Color2<mean(color2,3)-2*std(color2,0,3);
        
        Isig = cat(3,double(biovar2).*Color2,double(biovar1).*Color1,double(biovar1).*Color1);
        imshow(Isig/max([Color1(:);Color2(:)]))

%         imshow(biovar);
        biovar = biovar(:);
        % find back original indices in the histogram
        Diff = his(:);
        Diff = Diff.*double(biovar);
        Diff = reshape(Diff,bins,bins);
        imwrite(flipud(Diff'),['Results\Significant_3std\'  Sample{s} '_histogram.png'],'png');
%         bh = bar3(flipud(Diff),1);
%         for h = 1:length(bh)
%             htemp = get(bh(h),'Zdata');
%             set(bh(h),'Cdata',log(htemp)*5);
%         end
%         view(2); 
%         set(gca,'xLim',[-1 201],'YLim',[-1 201],'YDir','reverse',...
%             'YTick',0:20:200,'YTickLabel',[0 b{1}(19:20:200)],...
%             'XTick',0:20:200,'XTickLabel',[fliplr(b{2}(19:20:200)) 0],...
%             'XTickLabelRotation',90);
%         xlabel('transcript Y');
%         ylabel('transcript X');
%         %         set(gca,'ZScale','log')
%         colormap hot
%         title('bootstraping 50 replicates averaged');
        
        % find back original image indices
        Diff_gau = zeros(size(Igau,1),size(Igau,2),3);
        [r,c] = find(Diff>0);
        bx = b{1}(2)-b{1}(1);
        by = b{2}(2)-b{2}(1);
        findxy = zeros(length(Color1),1);
        
        for p = 1:length(r)
            findx = Color1>=b{1}(r(p))-bx & Color1<b{1}(r(p))+bx;
            findy = Color2>=b{2}(c(p))-by & Color2<b{2}(c(p))+by;
            findxy = findxy + double(findx & findy);
        end
        Diff_gau(:,:,2) = reshape(Color1.*double(findxy),size(Igau,1),[]);
        Diff_gau(:,:,3) = reshape(Color1.*double(findxy),size(Igau,1),[]);
        Diff_gau(:,:,1) = reshape(Color2.*double(findxy),size(Igau,1),[]);
%        Diff_gau = reshape(Diff_gau,floor(Isize/5));     

        Diff_gau = Diff_gau/max([Color1;Color2]);
        imwrite(Diff_gau,['Results\Significant_3std\'  Sample{s} '_merged.png'],'png')
    end
end
    
