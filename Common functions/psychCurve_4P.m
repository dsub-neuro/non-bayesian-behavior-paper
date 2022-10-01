function [min, slope, threshold, max, curve, goodness] = psychCurve_4P(X, Y, curveSpace, L, U, st)
%set lower limits, upper limits, and starting values

[cf, goodness] = L4P(X, Y, st, L, U);
min = cf.A;
slope = cf.B;
threshold = cf.C;
max = cf.D;
curve = cf.D+(cf.A-cf.D)./(1+(curveSpace./cf.C).^cf.B);

end