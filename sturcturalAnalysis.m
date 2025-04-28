function [eigval, eigvec] = sturcturalAnalysis(Ms, Ks)
% solve matrix equation for eigenfrequency (source: https://www.comsol.com/multiphysics/eigenfrequency-analysis)

[eigvec, eigval] = eig(Ks, Ms);

end

