function [solution,x] = problem2_nonuniform(depth)
%Assignment 4, problem 2, nonuniform mesh

%Setting the base mesh step size (h). The golden ratio is used to make 
%the mesh nonuniform.
goldenRatio = (1+sqrt(5))/2;
h = 1/20;

%base mesh
x = 0:h:1;

%Nonuniform step sizing with the golden ratio
for j = 1:depth
    addedX = zeros(1,length(x)-1);
    for k = 1:length(x)-1
        addedX(k) = (goldenRatio*x(k+1) + x(k))/(1+goldenRatio);
    end
    x = sort([x,addedX]);
end

%q and a functions to solve ODE and make coefficient matrix
a = @(x)1.0 + exp(x);
q = pi^2 * sin(pi *x);

%coefficient matrix building
coeffMat = zeros(length(x),length(x));

coeffMat(1,1) = 1; %c_j;
coeffMat(1,2) = 0; %c_jplus1;
coeffMat(1,length(x)) = 0; %c_jmin1;

for l = 2:length(x)-1
    jminus = (x(l)+x(l-1))/2;
    jplus = (x(l+1)+x(l))/2;
    hminus = x(l) - x(l-1);
    hj = x(l+1) - x(l);
    
    coeffMat(l,l-1) = -a(jminus)/hminus;
    coeffMat(l,l) = (a(jplus)/hj) + (a(jminus)/hminus);
    coeffMat(l,l+1) = -a(jplus)/hj;
    
    q(l) = (hj+hminus)/2 * pi^2*sin(pi*x(l));
end

coeffMat(length(x),1) = 0; %c_jplus1;
coeffMat(length(x),length(x)-1) = -1; %c_jmin1;
coeffMat(length(x),length(x)) = 1; %c_j;

%solve for solution vector
solution = coeffMat\q';

end

