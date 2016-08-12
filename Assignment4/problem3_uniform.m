function [solution,x] = problem3_uniform(uniformMeshSpacing)
%Assignment 4, problem 2, uniform mesh

%mesh discretization
h = 1/uniformMeshSpacing;
x = 0:h:1;

%functions a and q to solve ODE and build coefficient matrix
%a = @(x)1.0 + exp(x);
q = pi^2 * sin(pi*x);

%coefficient matrix building
coeffMat = zeros(length(x),length(x));

coeffMat(1,1) = 1; %c_j;
coeffMat(1,2) = 0; %c_jplus1;
coeffMat(1,length(x)) = 0; %c_jmin1;

for i = 2:length(x)-1
    %jminus = (x(i)+x(i-1))/2;
    %jplus = (x(i+1)+x(i))/2;
    
    coeffMat(i,i-1) = (-1/h^2)*(h + exp(x(i)) - exp(x(i-1)));
    coeffMat(i,i) = (1/h^2)*(h + exp(x(i)) - exp(x(i-1))) +...
        (1/h^2)*(h + exp(x(i+1)) - exp(x(i)));
    coeffMat(i,i+1) = (-1/h^2)*(h + exp(x(i+1)) - exp(x(i)));
    
    q(i) = (1/h)*(sin(pi*x(i)) - sin(pi*x(i-1)))+(1/h)*(sin(pi*x(i)) - ...
        sin(pi*x(i+1)));
end

coeffMat(length(x),1) = 0; %c_jplus1;
coeffMat(length(x),length(x)-1) = -1; %c_jmin1;
coeffMat(length(x),length(x)) = 1; %c_j;

%solve for solution vector
solution = coeffMat\q';

end