%% Matlab for solving Burgers equation
% Burgers's equation: u_t + u*u_x - (0.01/pi)*u_xx = 0

%% Establish equation
%Start timer
tic
%space domain
dom = [-1,1];
%Sampling interval
t = 0:0.01:0.99;

%Establish equation
pdefunction = @(t,x,u) -u.*diff(u)+0.01./pi.*diff(u,2);

%boundary conditions
bc.left = 0;
bc.right = 0;

%Construct a chebfun of the space variable on the domain
x = chebfun(@(x)x, dom);

%initial condition:
u0 = -sin(pi*x);

%% solve the equation
opts = pdeset('Eps', 1e-7, 'HoldPlot', 'on', 'Ylim', [0,0.8]);
[t, u] = pde23t(pdefunction, t, u0, bc, opts);

%% Plot the solution
figure
xlabel('x'), ylabel('t')
toc

x = (linspace(-1,1,256))';
time = 1:100;

usol(:, time) = u(x, time);
usol(:,:) = usol(2:-2,:);
x(:) = x(2:-2);
surf(usol)

%% Save datasets
filename = 'burgers_datasets.mat';
save(filename, 't', 'x', 'usol')


