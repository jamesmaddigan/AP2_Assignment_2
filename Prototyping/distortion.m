function [y] = distortion(x, distortion_control)


arc_alpha = (distortion_control * 2);


     y = atan((arc_alpha * x))/atan(arc_alpha);
end

