fprintf("*** By: GUIZENI Oumayma ***\n");
fprintf("*** Date: 03-06-2023 ***\n");
pause(3);
fprintf("\n");

fprintf("Note that Frequency & Impedance are inversely proportional\n");
fprintf("\n");
% Get measured impedance data from the user
measuredFrequency = input('Enter the measured frequency values in Hz(example: 0.0012),[in vector]: ');
measuredImpedance = input('Enter the measured impedance values(example: 1.3)[in vector]: ');

% Find the index of the lowest frequency
[~, lowestFrequencyIndex] = min(measuredFrequency);

% Get the impedance value corresponding to the lowest frequency
lowestImpedance = measuredImpedance(lowestFrequencyIndex);

% Calculate SOH using the impedance data
refImpedance = lowestImpedance; % Reference impedance at the lowest frequency
soh = abs(measuredImpedance) / refImpedance;
estimatedSoh = soh * 100;  % Convert SOH values to percentage

if any(estimatedSoh < 0) || any(estimatedSoh > 100)
    disp("Estimated SOH is out of range!");
else
    % Display the estimated SOH
    fprintf('Estimated SOH = %.2f%%\n', estimatedSoh);

    % Plot the measured impedance and SOH
    subplot(2, 1, 1);
    plot(measuredFrequency, measuredImpedance, 'b', 'linewidth', 1);
    xlabel('Frequency');
    ylabel('Impedance');
    title('Measured Values');
    grid on;

    subplot(2, 1, 2);
    plot(measuredFrequency, estimatedSoh, 'Color', [1, 0.5, 0], 'linewidth', 1.5);
    xlabel('Frequency');
    ylabel('State of Health (SOH)');
    title('SOH Calculation using Impedance Spectroscopy');
    grid on;

% Save the graph as PNG
 print -dpng soh_graph_with_impedance_method.png;
end
