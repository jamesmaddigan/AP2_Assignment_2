function [y] = distortion(x, distortion_control)


arc_alpha = (distortion_control * 2);
arcTan_ratio = 1;

     y = arcTan_ratio * atan((arc_alpha * x))/atan(arc_alpha);
end

