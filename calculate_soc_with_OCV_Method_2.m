fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 27-05-2023 ***\n");
pause(3);

fprintf("\n");  
% Read the standard OCV values and corresponding SOC values from a file
filename = input("Enter the filename (text file) containing the standard OCV and SOC values: ", "s");
    while ~exist(filename, 'file')
       disp("Invalid file. Please enter a valid filename.");
       filename = input("Enter the filename (text file) containing the standard OCV and SOC values: ", "s");
    end
data = dlmread(filename);

% Separate the OCV and SOC columns
     standard_ocv = data(:, 1);
     soc = data(:, 2);
    
measured_ocv_value=input("Enter the ocv value of your battery: ");
     while  measured_ocv_value < 27.5 || measured_ocv_value > 42  % Created Standard 
       disp("Invalid value. Please enter a value between 27.5V & 42V.")
       measured_ocv_value=input("Enter the ocv value of your battery: ");
     end
     
% Calculate the state of charge for each measured OCV value
     soc_estimate = interp1(standard_ocv, soc, measured_ocv_value, 'linear', 'extrap');

% Display the state of charge for each test
    disp("State of Charge (SOC) of your test:");
    disp(['SOC = ', num2str(soc_estimate) , '%']);
   
% Generate the graph
     figure;
     plot(standard_ocv, soc, 'color', [255/255 0/255 255/255]);
     hold on;
     plot(measured_ocv_value, soc_estimate, 'ko');
     axis([27 42 0 100]);
     xlabel("Open Circuit Voltage (OCV) at 25°C (V)");
     ylabel("State of Charge (SOC) (%)");
     title("State of Charge vs. Open Circuit Voltage");
     grid on;

     % Add legend for estimated SOC values
legend_entries = cell(1, length(soc_estimate));
for i = 1:length(soc_estimate)
    legend_entries{i} = ['estimatedSOC = ' num2str(soc_estimate(i)) '%'];
end
legend(legend_entries);

% Save the graph as PNG
     print -dpng soc_graph_with_OCV_method.png;
