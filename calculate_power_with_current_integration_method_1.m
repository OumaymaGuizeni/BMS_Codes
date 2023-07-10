fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 04-06-2023 ***\n");
pause(3);

fprintf("\n");
% Get current measurements from the user
timeSteps = input('Enter the number of time steps: ');
currentMeasurements = zeros(timeSteps, 1);
for i = 1:timeSteps
    currentMeasurements(i) = input(sprintf('Enter current measurement at time step %d (A): ', i));
end

% Initialize variables
powerEstimates = zeros(timeSteps, 1);
charge = 0;
voltage = input ('Enter the Voltage of you battery: ');

for i = 2:length(time)-1
    dt = time(i) - time(i-1);  % Time step
    charge = charge + (currentMeasurements(i) - currentMeasurements(i-1)) * dt; 
end

% Time interval
totalTime = time(end) - time(1);

% Calculate the power
power = voltage * charge / totalTime;
 % Display the total estimated power
 fprintf("Total Estimated Power (W): %.2f\n", totalPowerEstimate);

% Plot estimated power
time = 1:timeSteps;
figure;
plot(time, currentMeasurements, 'b', 'LineWidth', 1.5);
hold on;
plot([time(1), time(end)], [power, power], 'r--', 'LineWidth', 1.5);
xlabel('Time(s)');
ylabel('Power (W)');
legend('Current','Estimated Power');
title('Estimated Power');
grid on;

% Save the graph as PNG
     print -dpng power_graph_with_current_integration_method.png;
