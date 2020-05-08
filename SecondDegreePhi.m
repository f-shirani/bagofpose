function phi = SecondDegreePhi(X1,X2,J,X3,BodyR)

Pointx = J(:,3 * X1 -2);
Pointy = J(:,3 * X1 -1);
Pointz = J(:,3 * X1 -0);
PointOnPlanex  = J(:,3 * X2 - 2);
PointOnPlaney  = J(:,3 * X2 - 1);
PointOnPlanez  = J(:,3 * X2 - 0);
originx =J(:,3 * X3 -2);
originy =J(:,3 * X3 -1);
originz =J(:,3 * X3 -0);

Point = [Pointx Pointy Pointz];
PointOnPlane = [PointOnPlanex PointOnPlaney PointOnPlanez];

Distance=sqrt(sum(originx.^2 + originy.^2 + originz.^2));
bDirection = [originx/Distance originy/Distance originz/Distance];

%   projection of r into s
rdistance2s = (dot(bDirection,BodyR)/(norm(bDirection).^2))*  bDirection;
Project_r2s = round(( BodyR- rdistance2s),2 ) ;

%   project hand-elbow (HE) into s
HE = (Point - PointOnPlane)/norm(Point - PointOnPlane);
hdistance2s = (dot(bDirection,HE)/(norm(bDirection).^2))* bDirection; % this should be already normalized
Project_H2s = round(( HE - hdistance2s),2 ) ;% is a vector


phi = acosd(dot(Project_H2s,Project_r2s));
if(isnan(phi))
    phi=10;
end
end