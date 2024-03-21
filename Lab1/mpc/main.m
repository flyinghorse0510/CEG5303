clear;
nx = 12;
ny = 12;
nu = 4;
nd = 3;
% input vector (T, tau_phi, tau_theta, tau_psi, v_wind_x, v_wind_y, v_wind_z)
% MV index 1,2,3,4
% MD index 5,6,7
nlmpcobj = nlmpc(nx, ny, 'MV', [1 2 3 4], 'MD', [5 6 7]);
nlmpcobj.Model.StateFcn = "QuadrotorStateFcn";
rng(0);
validateFcns(nlmpcobj,rand(nx,1),rand(nu,1), rand(1, nd));


Ts = 0.1;
p = 18;
m = 2;
nlmpcobj.Ts = Ts;
nlmpcobj.PredictionHorizon = p;
nlmpcobj.ControlHorizon = m;

nlmpcobj.MV = struct( ...
    Min={0;0;0;0}, ...
    Max={40;40;40;40}, ...
    RateMin={-2;-2;-2;-2}, ...
    RateMax={2;2;2;2} ...
    );


nlmpcobj.Weights.OutputVariables = [1 1 1 1 1 1 0 0 0 0 0 0];
nlmpcobj.Weights.ManipulatedVariables = [0.1 0.1 0.1 0.1];
nlmpcobj.Weights.ManipulatedVariablesRate = [0.1 0.1 0.1 0.1];

% Specify the initial conditions
x = [0;6;0;0;0;0;0;0;0;0;0;0];

% Nominal control target (average to keep quadrotor floating)
nloptions = nlmpcmoveopt;
nloptions.MVTarget = [5.8 5.8 5.8 5.8]; 
mv = nloptions.MVTarget;

% Simulation duration in seconds
Duration = 20;

% Display waitbar to show simulation progress
hbar = waitbar(0,"Simulation Progress");

% MV last value is part of the controller state
lastMV = mv;

% Store states for plotting purposes
xHistory = x';
uHistory = lastMV;

% Simulation loop
for k = 1:(Duration/Ts)

    % Set references for previewing
    t = linspace(k*Ts, (k+p-1)*Ts,p);
    yref = QuadrotorReferenceTrajectory(t);
    wind_md = getWindDisturbance(t);

    % Compute control move with reference previewing
    xk = xHistory(k,:);
    [uk,nloptions,info] = nlmpcmove(nlmpcobj,xk,lastMV,yref',wind_md,nloptions);

    % Store control move
    uHistory(k+1,:) = uk';
    lastMV = uk;

    % Simulate quadrotor for the next control interval (MVs = uk) 
    ODEFUN = @(t,xk) QuadrotorStateFcn(xk,[uk; wind_md(1, :)']);
    [TOUT,XOUT] = ode45(ODEFUN,[0 Ts], xHistory(k,:)');

    % Update quadrotor state
    xHistory(k+1,:) = XOUT(end,:);

    % Update waitbar
    waitbar(k*Ts/Duration,hbar);
end

% Close waitbar 
close(hbar);

close all;
plotQuadrotorTrajectory;
% animateQuadrotorTrajectory;
