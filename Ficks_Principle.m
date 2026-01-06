% Estimating Blood Flow Using Fick's Principle
% Author: Emily D. Delgado Gonzalez
% Date: October 24th, 2025

clear; clc; close all;

% Time vector (1 minute, 100 samples)
t = linspace(0, 60, 100);

% Indicator injection rate Fi(t) in mg/s
Fi = 5 * exp(-0.1 * t);

% Simulated blood concentration C(t) in mg/mL
C = 0.2 + 0.1 * sin(0.1 * t);

% Preallocations
m = zeros(size(t));    % cumulative indicator
aucC = zeros(size(t)); % area under C(t)
F = zeros(size(t));    % estimated flow

% Integration loop
for k = 2:length(t)
    dt = t(k) - t(k-1);
    m(k) = m(k-1) + 0.5 * (Fi(k) + Fi(k-1)) * dt;
    aucC(k) = aucC(k-1) + 0.5 * (C(k) + C(k-1)) * dt;

    if aucC(k) > 0
        F(k) = m(k) / aucC(k);
    else
        F(k) = NaN;
    end
end

% Print results
fprintf('Final cumulative indicator (m): %.3f mg\n', m(end));
fprintf('Total area under C(t): %.3f (mg/mL)*s\n', aucC(end));
fprintf('Estimated flow (F): %.3f mL/s\n', F(end));
fprintf('Run date/time: %s\n', datestr(now, 31));

% Plots
figure('Color','w');
subplot(3,1,1)
plot(t, C, 'LineWidth', 1.5)
xlabel('Time (s)'), ylabel('C(t) (mg/mL)')
title('Blood Concentration')

subplot(3,1,2)
plot(t, F, 'LineWidth', 1.5)
xlabel('Time (s)'), ylabel('Flow (mL/s)')
title('Estimated Flow Over Time')

subplot(3,1,3)
plot(t, m, 'LineWidth', 1.5)
xlabel('Time (s)'), ylabel('m(t) (mg)')
title('Cumulative Indicator')
