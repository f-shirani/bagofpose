clc;
clear all;
close all;

%%
% Action1 : Wave   ,  Action2 : Drink  , Action3: Answer Phone 
% Action4 : Clap   ,  Action5 : Tight Lace ,  Action6 : Sit Down 
% Action7 : Stand Up  ,  Action8: Read Watch    ,  Action9 : Bow  

diffLast=[];
minDistance=[];
d=[];
load('class.mat');
action_number=9;
conf=zeros(9,9);
for jj=1:10
   
    testdata = class(cell2mat(class(:,3))==jj,:);%get test feature vectors
    traindata = class(cell2mat(class(:,3))~=jj,:);%get train feature vectors
    
    for v=1:size(testdata,1)
        test=testdata{v,1};%feature
        realLabel=cell2mat(testdata(v,2));%action
        rows=size(test,1);
        for i=1:action_number
            for frame=1:rows
                TestFrameF = test(frame,:);
                FeatureVectors=TestFrameF;
                c=cell2mat(traindata(cell2mat(traindata(:,2))==i,1));
                TestFrameF=repmat( FeatureVectors,size(c,1),1);
                diff{frame,i}=sqrt(sum((TestFrameF-c).^2,2));% distance between test frames and train frames
                diffLast(frame,i)= min(diff{frame,i});
                
            end
        end
        
        diffLast=sum(diffLast(:,1:action_number));
        minDistance=[diffLast;minDistance];
        [a,b]=min(diffLast);
        TestLabel =b;
        d=[TestLabel realLabel;d];
    end
    conf = conf + confusionmat(d(:,1),d(:,2));
    video_number= testdata(:,4);
    save(['result_subject_florence',num2str(jj),'.mat'],'d','minDistance','video_number');
    display(num2str(jj));
end
conf = conf./10;
s = sum(conf,2);
for i=1:action_number
    conf(i,:) = (conf(i,:)./s(i));
end


accuracy=(sum(diag(conf))/action_number)*100;

save('conf');


