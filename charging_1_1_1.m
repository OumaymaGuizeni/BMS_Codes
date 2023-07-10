fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 18-06-2023 ***\n");
pause(3);

fprintf("\n");
% Charging Time Estimation for Electric Vehicle (EV)

batteryCapacity = input('Enter the battery capacity in kilowatt-hours (kWh): ');
chargingCurrent = input('Enter the charging current in A: ');
chargingTime = (batteryCapacity / chargingCurrent)*1000;
switch true
    case chargingTime >= 22 && chargingTime <= 40
        fprintf('You are charging your car at Level 1. The estimated charging time is %.2f hours, which is approximately %.2f days.\n', chargingTime, chargingTime/24);
    case chargingTime >= 2 && chargingTime <= 13
        fprintf('You are charging your car at Level 2. The estimated charging time is %.2f hours, which is approximately %.2f days.\n', chargingTime, chargingTime/24);
    case chargingTime >= 0.25 && chargingTime <= 1.5
        fprintf('You are charging your car at Level 3. The estimated charging time is %.2f hours, which is approximately %.2f days.\n', chargingTime, chargingTime/24);
    otherwise
        fprintf('Invalid charging power entered.\n');
end

% Create a figure to plot the charging time
figure;
stem(chargingPower, chargingTime, 'bo-','filled', 'LineWidth', 2);
xlabel('Charging Power (kW)');
ylabel('Charging Time (hours)');
title('Estimated Charging Time vs Charging Power');
grid on;
 % Add legend for estimated SOC values
legend_entries = cell(1, length(chargingTime));
for i = 1:length(chargingTime)
    legend_entries{i} = ['chargingTime = ' num2str(chargingTime(i)) 'hour(s)'];
end
legend(legend_entries);

% Save the graph as PNG
     print -dpng charging.png;