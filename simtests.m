[t, T] = run_model(1)
% Inside temp reaches ~300K (80 F) at index 27
maxcomft = t(27);
HRmaxcomft = maxcomft/(60*60);
figure
[t, T] = run_model(HRmaxcomft/24)