function [output] = stepResponse(input,alpha, previousOutput)

output = (1 - alpha) * input + (alpha * previousOutput);

end


