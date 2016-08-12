function problem2_main
%Runs the uniform and nonuniform meshes and caluclates error

%close any figures
close all

%uniform mesh first

%Different levels of mesh spacing and colors for plotting
uniformMeshSpacing = [20,40,80,160];
colors = ['m','k','b','g'];

% "True solution"
[solution_640,x_640] = problem2_uniform(640);

uniform_error = zeros(length(uniformMeshSpacing),1);

%error stuff
for j = 1:length(uniformMeshSpacing)
    [solution,x] = problem2_uniform(uniformMeshSpacing(j));
    subVec = zeros(length(solution),1);
    for i = 1:length(solution)
        if i == 1
            subVec(1) = solution_640(1);
        elseif i == length(solution)
            subVec(end) = solution_640(end);
        else
            subVec(i) = solution_640(x_640 == x(i));
        end
    end
    uniform_error(j) = max(abs(subVec - solution));
    plot(x,solution,colors(j),'LineWidth',2)
    hold on
end

%plotting and saving
legend('1/20','1/40','1/80','1/160','Location','NorthWest')
title('Uniform Mesh','FontSize',14,'FontWeight','bold')
ylim([-0.05,1.45])
xlabel('x Discretization','FontWeight','bold')
ylabel('Solution','FontWeight','bold')
saveas(gcf,'uniform.png')

figure
loglog(1./uniformMeshSpacing,uniform_error,'m','LineWidth',2)
hold on
loglog(1./uniformMeshSpacing,(1./uniformMeshSpacing).^2,'k','LineWidth',2)
legend('Scheme Error','Squared Discretization','Location','NorthWest')
title('Uniform Mesh Error','FontWeight','bold','FontSize',14)
xlabel('Uniform Mesh Spacing','FontWeight','bold')
ylabel('Error','FontWeight','bold')
saveas(gcf,'uniform_error.png')

%nonuniform mesh
depth = 1:4;

%"True solution'
[solution_5,x_5] = problem2_nonuniform(5);

nonuniform_error = zeros(length(depth),1);

%error stuff
figure
for j = 1:length(depth)
    [solution_non,x_non] = problem2_nonuniform(depth(j));
    %error(j) = max(abs(solution(j) - solution_320(1:2^(5-j):end)));
    subVec = zeros(length(solution_non),1);
    for i = 1:length(solution_non)
        if i == 1
            subVec(1) = solution_5(1);
        elseif i == length(solution_non)
            subVec(end) = solution_5(end);
        else
            subVec(i) = solution_5(x_5 == x_non(i));
        end
    end
    nonuniform_error(j) = max(abs(subVec - solution_non));
    plot(x_non,solution_non,colors(j),'LineWidth',2)
    hold on
end

%plotting and saving
title('NonUniform Mesh','FontSize',14,'FontWeight','bold')
legend('Depth-1','Depth-2','Depth-3','Depth-4','Location','NorthWest')
ylim([-0.05,1.45])
xlabel('x Discretization','FontWeight','bold')
ylabel('Solution','FontWeight','bold')
saveas(gcf,'nonuniform.png')

figure
loglog(1./uniformMeshSpacing,nonuniform_error,'m','LineWidth',2)
hold on
loglog(1./uniformMeshSpacing,(1./uniformMeshSpacing).^2,'k','LineWidth',2)
legend('Scheme Error','Squared Uniform Discretization',...
    'Location','NorthWest')
title('Nonuniform Mesh Error','FontWeight','bold','FontSize',14)
xlabel('Uniform Mesh Spacing','FontWeight','bold')
ylabel('Error','FontWeight','bold')
saveas(gcf,'nonuniform_error.png')

end

