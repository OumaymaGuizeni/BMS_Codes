fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 28-05-2023 ***\n");
pause(3);

fprintf("\n"); 
% Define and assign a value to rated_capacity
rated_capacity = input('Enter the capacity specified by the manufacturer in mAh:');

% user input actual capacity in mAh
fprintf('Hint: Enter actual_capacity or press enter \n');
actual_capacity = input('Enter the actual capacity of your battery in mAh: '); % mAh 

if actual_capacity > rated_capacity
    disp('This is not correct rated_capacity should be greater then the actual_capacity ');
    actual_capacity = input('Enter the actual capacity of your battery in mAh: '); % mAh
end
% calculate manually the actual_capacity
% if isempty(actual_capacity)
%     Current = input('Enter the current value in mA: '); % A
%     Time = input('Enter the actual time in ms: '); % s
%     actual_capacity = Current * Time;
% end

% Estimate SOC
soh_estimated = (actual_capacity / rated_capacity) * 100;

if soh_estimated < 0 || soh_estimated > 100
    disp("This is incorrect.please try again")
else
% Display the calculated SOH
disp(['State of Health (SOH): ', num2str(soh_estimated), '%']);

% Plotting the State of Health (SOH)
figure
stem(actual_capacity,soh_estimated,'ro','filled');
axis([0 10000 0 100]);
title('Battery State of Health');
xlabel('Actual Capacity (mAh)');
ylabel('State of Health (%)');
grid on;

 % Add legend for estimated SOC values
legend_entries = cell(1, length(soh_estimated));
for i = 1:length(soh_estimated)
    legend_entries{i} = ['estimatedSOH = ' num2str(soh_estimated(i)) '%'];
end
legend(legend_entries);

% Save the graph as PNG
     print -dpng soh_graph_with_capacity_method.png;
end
