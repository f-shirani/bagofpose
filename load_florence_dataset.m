function [data,sIndex]=load_florence_dataset(dpath)
fname = sprintf('%s/Florence_dataset_WorldCoordinates.txt', dpath);
fd = fopen(fname, 'r');
if fd == -1
    error('Could not open file');
end
S = fscanf(fd, '%f');
fclose(fd);

S = reshape(S,3+45,[])';
vidIds  = unique(S(:,1));
Subject = unique(S(:,2));
Actions = unique(S(:,3));
asIndex=zeros(max(Actions),max(Subject));
data=cell(max(Actions),max(Subject),5);
sIndex = cell(size(data));
for k= 1: length(vidIds)
frames = S(S(:,1)==k,:);
a=frames(1,3);%action
s=frames(1,2);%subject
asIndex(a,s)=asIndex(a,s)+1;
e=asIndex(a,s);
index=[a,s,e];
frames(:,1:3)=[];
data{a,s,e}=reshape(frames(:,(1:end)),[],45);
sIndex{a,s,e}=index;
index=[];
% % get all frames of a video into a matrix
% for k=1:length(vidIds)
%    vid=S(:,S(1,:)==k);
%    frame=vid(:)';
%    col_size = size(frame, 2);
%    data(k,1:col_size)=frame(1,1:col_size);
%   

end

