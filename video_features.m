clc
clear all
close all

%%
[data,sIndex]=load_florence_dataset('E:\shirani\datasets\florence3d_actions\Florence_3d_actions');
class=cell(1,4);% class for actions
testVideos={};
trainVideos={};

count=1;

for i = 1 : size(data,1)
    for j=1 : size(data,2)
        for k = 1 : size(data,3)
            if isempty(data{i,j,k})
                break;
            end
            videoFrames = data{i,j,k};
            
            FeatureVectors = [];
            rows=size(videoFrames,1);
            for frame = 1 : rows
                J = videoFrames(frame,1:end);
                FV =Features(frame,J); % feature vector for each frame
                FeatureVectors =[FV;FeatureVectors ];
            end
            
            class{count,1}=FeatureVectors; % features 
            class{count,2}=i; % action
            class{count,3}=j; % subject
            class{count,4}=sIndex{i,j,k}; % name
            count=count+1;
        end
    end
end
save class;

