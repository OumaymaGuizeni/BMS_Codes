fprintf("By: GUIZENI Oumayma\n");
fprintf("Date: 17-06-2023\n");
pause(3);

% Battery parameters
batteryCapacity = input('Enter the Capacity of your battery in Ah: '); % Battery capacity in Ampere-hours (Ah)

% Current measurements
timeSteps = input('Enter the number of time steps: ');
if timeSteps < 2
    disp('Minimum Time Steps should be 2');
    timeSteps = input('Enter the number of time steps: ');
end
    
currentMeasurements = zeros(timeSteps, 1);
voltageMeasurements = zeros(timeSteps, 1);

% Get current and voltage measurements from the user
for i = 1:timeSteps
    currentMeasurements(i) = input(sprintf('Enter current measurement for step %d (A): ', i));
    voltageMeasurements(i) = input(sprintf('Enter voltage measurement for step %d (V): ', i));
end

% Initialize variables
powerEstimates = zeros(timeSteps, 1);
totalPowerEstimates = 0;

% Estimate power using Model-Based Approaches method
for i = 1:timeSteps
    % Predicted voltage from the Equivalent Circuit Model (ECM)
    predictedVoltage = batteryCapacity * currentMeasurements(i); 
    
    % Estimate power based on the predicted voltage
    powerEstimates(i) = predictedVoltage * currentMeasurements(i);
    totalPowerEstimates = totalPowerEstimates + powerEstimates(i); 
end

% Display the total estimated power
fprintf("Total Estimated Power (W): %.2f\n", totalPowerEstimates);

% Plotting
time = 1:timeSteps;
figure;
plot(time, powerEstimates, 'b-', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('Power (W)');
title('Power vs. Time Step');
grid on;

% Save the graph as PNG
print -dpng power_graph_with_model_method.png;