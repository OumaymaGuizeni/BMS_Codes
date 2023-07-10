fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 04-06-2023 ***\n");
pause(3);

fprintf("\n");
% Request user input or use known parameters
R0 = 0.003; %Ω
R1 = 0.05; %Ω
C1 = 300; %F

Q = input('Enter the nominal capacity (Q) in Ah or press enter to use default: ');
if isempty(Q)
 Q = 5.2;
end

%Enter voltage and current
voltage = input('Enter the voltage measurement(s)[as a vector]or press enter to use default:');
current = input('Enter the current measurement(s)[as a vector]or press enter to use default:');
if isempty(voltage) && isempty(current)
    voltage = [37.1, 36.5, 35.9];
    current = [2.20, 2.98, 2.56];
end  
% Time vector (assuming constant sampling rate)
dt = 1;             % Sampling interval in seconds
time = (0:dt:(length(voltage)-1)*dt)';   % Create time vector

% Model-based SoH estimation
SoH = zeros(size(voltage));
SoH(1) = 100;         % Initial SoH assumed to be 100%

for k = 2:length(voltage)
    % State of Charge (SoC) estimation
    SoC = trapz(time(1:k), current(1:k)) / Q;
    
    % Predicted voltage from the Equivalent Circuit Model (ECM)
    voltage_model = voltage(k-1) - R0 * current(k) - (1 - SoH(k-1)) * (R1 * current(k) + (voltage(k-1) - R0 * current(k)) / C1);
    
    % SoH estimation
    SoH(k) = voltage(k) / voltage_model * SoH(k-1);
end
if any(SoH < 0) || any(SoH > 100)
    disp("This is incorrect.please try again")
else
% Display SoH results
disp(['State of Health (SoH)= ', num2str(SoH(end)),'%']);

%Plotting results
figure;
subplot(2,1,1);
plot(voltage,'r--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Measured Voltage');
legend('Measured Voltage.vs State of Health (SoH)');
grid on;

subplot(2,1,2);
plot(time, SoH, 'g', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('State of Health (SoH)');
legend('EStimated SOH');
grid on;

% Save the graph as PNG
print -dpng soh_graph_with_model_method.png;
end