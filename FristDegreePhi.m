
function phi = FristDegreePhi(X1,X2,J,BodyU,BodyR)

      % The first degree joints are those that are adjacent to the torso 
        Pointx = J(:,3 * X1 -2);
        Pointy = J(:,3 * X1 -1);
        Pointz = J(:,3 * X1 -0);
        PointOnPlanex  = J(:,3 * X2 - 2);
        PointOnPlaney  = J(:,3 * X2 - 1);
        PointOnPlanez  = J(:,3 * X2 - 0);
       
        Point = [Pointx Pointy Pointz];
        PointOnPlane = [PointOnPlanex PointOnPlaney PointOnPlanez];
        PlaneNormal = BodyU;
        
      
        distance_up=(dot((Point-PointOnPlane),PlaneNormal)/(norm(PlaneNormal).^2))*PlaneNormal;
        ProjectionOnPlane=round(((Point-PointOnPlane)-distance_up),2)/norm(round(((Point-PointOnPlane)-distance_up),2));

    phi = acosd(dot(ProjectionOnPlane,BodyR));
   if(isnan(phi))
    phi=5;
   end
end
    
