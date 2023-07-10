fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 28-05-2023 ***\n");
pause(3);

fprintf("\n"); 
% Input the filename containing the standard OCV and SOC values
filename = input("Enter the filename (text file) containing the standard OCV and SOC values: ", "s");
while ~exist(filename, 'file')
    disp("Invalid file. Please enter a valid filename.");
    filename = input("Enter the filename (text file) containing the standard OCV and SOC values: ", "s");
end
data = dlmread(filename);

% Separate the OCV and SOC columns
standard_ocv = data(:, 1);
soc = data(:, 2);

% Input the noise covariance R
prompt = 'Do you know the noise covariance R? [Y/N]: ';
noise_input = input(prompt, 's');
if strcmpi(noise_input, 'Y')
    R = input('Enter noise covariance R: ');
else
    R = 0.1;  % Default noise covariance, normally between 0.001 and 0.1
end

% Input the initial SOC
prompt = 'Do you know the initial SOC? [Y/N]: ';
initial_soc_input = input(prompt, 's');
if strcmpi(initial_soc_input, 'Y')
    initialSOC = input('Enter initial SOC (state of charge) in (%): ');
else
    initialSOC = 50;  % Default initial SOC value
end

P_initial = 0.1;    % Initial estimate uncertainty

% Measurement Data
currentMeasurement = input('Enter the current measurement (in A): ');
voltageMeasurement = input('Enter the voltage measurement (in V): ');

% Generate SOC Ground Truth
SOC_true = interp1(standard_ocv, soc, voltageMeasurement, 'linear', 'extrap');

% Initialize Kalman Filter Variables
SOC_estimate = 0;  % Estimated SOC
P = P_initial;     % Estimate uncertainty

% Kalman Filtering
    % Prediction
    SOC_estimate = initialSOC + currentMeasurement * time;
    P = P + Q;
    
    % Measurement Update
    K = P / (P + R);
    SOC_estimate = SOC_true + K * (voltageMeasurement - SOC_true);
    P = (1 - K) * P;
    
    % Update Initial Values for Next Iteration
    initialSOC = SOC_estimate;

% Display the estimated SOC
disp(['Estimated SOC: ', num2str(SOC_estimate), '%']);

% Plotting
time = 1:length(SOC_estimate);
figure;
stem(time, SOC_estimate, 'color', [255/255 0/255 255/255], 'markersize', 6);
axis([0 2 0 100]);
xlabel('Time (h)');
ylabel('State of Charge (SOC)');
title('Estimated SOC using Kalman Filter');
grid on;

     % Add legend for estimated SOC values
legend_entries = cell(1, length(SOC_estimate));
for i = 1:length(SOC_estimate)
    legend_entries{i} = ['estimatedSOC = ' num2str(SOC_estimate(i)) '%'];
end
legend(legend_entries);

% Save the graph as PNG
filename = 'estimated_soc_with_kalman.png';
saveas(gcf, filename);
