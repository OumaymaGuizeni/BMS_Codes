fprintf("By: GUIZENI Oumayma\n");
fprintf("Date: 17-06-2023\n");
pause(3);

% Battery parameters
batteryCapacity = input('Enter the Capacity of your battery in Ah: '); % Battery capacity in Ampere-hours (Ah)

% Get current & voltage measurement from the user
timeSteps = input('Enter the number of time steps: ');
currentMeasurements = zeros(timeSteps, 1);
voltageMeasurements = zeros(timeSteps, 1);

for i = 1:timeSteps
    currentMeasurements(i) = input(sprintf('Enter current measurement at time step %d (A): ', i));
    voltageMeasurements(i) = input(sprintf('Enter voltage measurement at time step %d (A): ', i));
end

R = input('Enter noise covariance R or press enter to use default: ');
if isempty(R)
    R = 0.1;  % Default noise covariance, which is normally between 0.001 and 0.1
end

% Initialize variables
powerEstimates = zeros(timeSteps, 1);
x_k = 0; % Initial power estimate
P_k = 1; % Initial covariance estimate

% Estimate power using Kalman Filtering method
    % Predict
    predictedPower = x_k + currentMeasurements * batteryCapacity;
    predictedP = P_k;

    % Update
    residual = voltageMeasurements - predictedPower;
    residualCovariance = predictedP + R;
    kalmanGain = predictedP / residualCovariance;

    x_k = predictedPower + kalmanGain * residual;
    P_k = (1 - kalmanGain) * predictedP;

    powerEstimates = x_k;

% Display the estimated power values
fprintf("Total Estimated Power (W): %.2f\n", powerEstimates, 'W');

% Plotting
time = 1:length(voltageMeasurements);
figure;
subplot(2,1,1);
plot(time, voltageMeasurements,'k', 'LineWidth', 1.5);
xlabel('Time (h)');
ylabel('Voltage (V)');
title('Voltage vs. Time');
grid on;
subplot(2,1,2);
plot(time, powerEstimates, 'm--', 'LineWidth', 1.5);
xlabel('Time (h)');
ylabel('Power (W)');
title('Power vs. Time');
grid on;

% Save the graph as PNG
     print -dpng power_graph_with_kalman_method.png;