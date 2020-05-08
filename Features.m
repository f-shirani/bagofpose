%florence dataset

% 1-Head: f1-f3
% 2-Neck: f4-f6
% 3-Spine: f7-f9
% 4-Left Shoulder: f10-f12
% 5-Left Elbow: f13-f15
% 6-Left Wrist: f16-f18
% 7-Right Shoulder: f19-f21
% 8-Right Elbow: f22-f24
% 9-Right Wrist: f25-f27
% 10-Left Hip: f28-f30
% 11-Left Knee: f31-f33
% 12-Left Ankle: f34-f36
% 13-Right Hip: f37-f39
% 14-Right Knee: f40-f42
% 15-Right Ankle: f43-f45
function fv=Features(Tframe,J)
% joint allocation
x = 1: 3 : 45;
y = x + 1;
z = x + 2;
fv=zeros(0,17);

%% vertical and horizantal direction of the body

[Distance ,rightSide] = DisDir(13,7,J);
[Distance ,leftSide] = DisDir(10,4,J);
BodyU(Tframe,:) = (rightSide+leftSide)/2;
[~ ,BodyR(Tframe,:) ] = DisDir(7,4,J);

%% First degree right side features (teta,phi)
%first upside features
[Distance, RSREdirection(Tframe,:)] = DisDir(7,8,J);
tetaFDRU(Tframe) =acosd( dot(RSREdirection(Tframe,:),BodyU(Tframe,:)));
phiFDRU(Tframe) = FristDegreePhi(7,8,J,BodyU(Tframe,:),BodyR(Tframe,:));
fv(1)= tetaFDRU(Tframe);
fv(2)= phiFDRU(Tframe);
%first downside features
[Distance, RHRKdirection(Tframe,:)] = DisDir(13,14,J);
tetaFDRD(Tframe) =acosd( dot(RHRKdirection(Tframe,:),BodyU(Tframe,:)));
phiFDRD(Tframe) = FristDegreePhi(13,14,J,BodyU(Tframe,:),BodyR(Tframe,:));
fv(3)= tetaFDRD(Tframe) ;
fv(4)= phiFDRD(Tframe) ;

%% Second degreee right side feature
%second upside features
[Distance, RERHdirection(Tframe,:)] = DisDir(8,9,J);
tetaSDRU(Tframe) = acosd(dot(RSREdirection(Tframe,:),RERHdirection(Tframe,:)));
phiSDRU(Tframe) = SecondDegreePhi(8,9,J,7,BodyR(Tframe,:));
fv(5)= tetaSDRU(Tframe) ;
fv(6)= phiSDRU(Tframe) ;
%second downside features
[Distance, RKRAdirection(Tframe,:)] = DisDir(14,15,J);
tetaSDRD(Tframe) =acosd(dot(RHRKdirection(Tframe,:),RKRAdirection(Tframe,:)));
phiSDRD(Tframe) = SecondDegreePhi(14,15,J,13,BodyR(Tframe,:));
fv(7)=tetaSDRD(Tframe) ;
fv(8)= phiSDRD(Tframe) ;



%% r aligned to left side (body remains the same)
[Distance , BodyR(Tframe,:) ] = DisDir(7,4,J);

%% First degree left hand features (teta,phi)
%first upside feature
[Distance, LSLEdirection(Tframe,:)] = DisDir(4,5,J);
tetaFDLU(Tframe) =acosd( dot(LSLEdirection(Tframe,:), BodyU(Tframe,:)));
phiFDLU(Tframe) = FristDegreePhi(4,5,J,BodyU(Tframe,:),BodyR(Tframe,:));
fv(9)=tetaFDLU(Tframe) ;
fv(10)= phiFDLU(Tframe) ;
%first downside feature
[Distance, LHLKdirection(Tframe,:)] = DisDir(10,11,J);
tetaFDLD(Tframe) =acosd( dot(LHLKdirection(Tframe,:),BodyU(Tframe,:)));
phiFDLD(Tframe) = FristDegreePhi(10,11,J,BodyU(Tframe,:),BodyR(Tframe,:));
fv(11)=tetaFDLD(Tframe) ;
fv(12)=phiFDLD(Tframe) ;

%% Second degreee left side feature
%second upside feature
[Distance, LELHdirection(Tframe,:)] = DisDir(5,6,J);
tetaSDLU(Tframe) = acosd(dot(LSLEdirection(Tframe,:),LELHdirection(Tframe,:)));
phiSDLU(Tframe) = SecondDegreePhi(5,6,J,4,BodyR(Tframe,:));
fv(13)=tetaSDLU(Tframe) ;
fv(14)=phiSDLU(Tframe) ;
%second downside feature
[Distance, LKLAdirection(Tframe,:)] = DisDir(11,12,J);
tetaSDLD(Tframe) = acosd( dot(LHLKdirection(Tframe,:),LKLAdirection(Tframe,:)));
phiSDLD(Tframe) = SecondDegreePhi(11,12,J,10,BodyR(Tframe,:));
fv(15)=tetaSDLD(Tframe) ;
fv(16)=phiSDLD(Tframe) ;
