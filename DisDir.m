function [Distance, Direction] = DisDir(X1,X2,J)

    Vx = J(:,3*X1-2) - J(:,3*X2-2);
    Vy = J(:,3*X1-1) - J(:,3*X2-1);
    Vz = J(:,3*X1)   - J(:,3*X2);
    Distance  = sqrt(sum(Vx.^2 + Vy.^2 + Vz.^2));
    Direction = [Vx/Distance Vy/Distance Vz/Distance];
