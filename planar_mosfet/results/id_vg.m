data = readmatrix('id_vg.csv');
plot(data(:,1), data(:,2)); % Plot 1st column vs 2nd column
xlabel('Gate Voltage(vg)');
ylabel('Drain Current(id)');
title('CSV Plot');   