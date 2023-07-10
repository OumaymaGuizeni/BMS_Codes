fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 27-05-2023 ***\n");
pause(3);

fprintf("\n");
% Battery parameters (user input or specify the value)
   nominal_capacity = input('Enter the nominal capacity of your battery in mAh: '); 
 if nominal_capacity < 1000 || nominal_capacity > 10000
    disp('The nominal capacity should be between 1000mAh and 10000mAh.');
    nominal_capacity = input('Enter the nominal capacity of your battery in mAh: ');
 end
 
disp('Hint: The dischrage and charge capacity normally range from 1000mAh to 10000mAh');
discharge_capacity = input('Enter the discharged capacity (mAh) for this test: ');
charge_capacity = input('Enter the charged capacity (mAh) for this test: ');
if charge_capacity < discharge_capacity
    disp('Hint: the charge_capacity should be greater than the discharge_capacity');
    discharge_capacity = input('Enter the discharged capacity (mAh) for this test: ');
    charge_capacity = input('Enter the charged capacity (mAh) for this test: ');
end 

    efficiency = discharge_capacity / charge_capacity;
    fprintf('The coulombic efficiency of your battery is: %.2f%%\n', efficiency);


% Check if charge is greater than discharge
while charge_capacity <= discharge_capacity
    fprintf("Charge capacity should be greater than discharge capacity. Please enter the values again.\n");
    discharge_capacity = input("Enter the discharged capacity (mAh) for this test: ");
    charge_capacity = input("Enter the charged capacity (mAh) for this test: ");
    if discharge_capacity > charge_capacity
        disp('Hint: the charge_capacity should be greater than  discharge_capacity');
        discharge_capacity = input("Enter the discharged capacity (mAh) for this test: ");
        charge_capacity = input("Enter the charged capacity (mAh) for this test: ");
    end 
end

temperature = input('Enter the temperature (°C) for this test: ');

% Current data (user input or specify the value)
disp('Hint: 0.2, 0.5, 1 or 2');
C_rate = input('Enter the C_rate of your battery: ');
if C_rate == 0.2
    current = 520;%mA
elseif C_rate == 0.5
    current = 1300; %mA
elseif C_rate == 1
    current = 2600; %mA
else 
     current = 5200; %mA
end  
% Time data
time_step = 1; % Time step in hours
time = (0:time_step:(length(current)-1)*time_step);

% Calculate cumulative current using left rectangular method
cumulative_current = cumsum(current * time_step);

% Calculate SOC
soc0 = discharge_capacity / nominal_capacity * 100;  % Initial SOC (%)
soc_estimate = soc0 - (cumulative_current / nominal_capacity) * 100;
if (soc_estimate < 0) || (soc_estimate > 100)
    disp('This is not correct, please try again.');
else
    % Display the estimated SOC
    disp(['The estimated state of charge (SOC) of your battery is: ', num2str(soc_estimate(end)), '%']);
    % Plotting
    figure;
    stem(soc_estimate, 'go','filled');
    axis([0 2  0 100]);
    xlabel('Time (hours)');
    ylabel('State of Charge (%)');
    title('State of Charge using Coulomb Counting Method');
    grid on;

     % Add legend for estimated SOC values
legend_entries = cell(1, length(soc_estimate));
for i = 1:length(soc_estimate)
    legend_entries{i} = ['estimatedSOC = ' num2str(soc_estimate(i)) '%'];
end
legend(legend_entries);

% Save the graph as PNG
print -dpng soc_graph_with_colombic_method.png;

end
