% RFainFallViz.m
% Visualization of statewise rainfall.
%
% INPUT:
%   - netCDF file name ('RainFall.nc' by default).
%
% OUTPUT:
%   - Animated GIF file ('RainFall_1981-2014.gif').
%   - MATLAB figure showing rainfall data and state boundaries.
%
% Author: PAVAN KUMAR JONNAKUTI
% Scientist - C
% Ocean Data Management Group
% Indian National Centre for Ocean Information Services (INCOIS)
% "Ocean Valley", Pragathi Nagar (B.O)
% Nizampet (S.O), Hyderabad - 500 090
% Telangana, INDIA
% E-mail: jpawan33@gmail.com
% Web-link: http://www.jpavan.com
% Copyright @ Author
%
% Description:
% This script reads rainfall data from a netCDF file, overlays state
% boundaries from a shapefile, and generates an animated GIF showing
% the rainfall distribution over time.
%
% Version: 1, 06/03/2017

clc; clear all;

%% Load Data
load coastlines.mat;
file = 'RainFall.nc';
Lon = ncread(file, 'lon');
Lat = ncread(file, 'lat');
Time = ncread(file, 'time');
RainFall = ncread(file, 'rf');

%% Time Conversion
t1 = datetime(1981, 01, 01, 0, 0, 0);
t2 = t1 + days(length(Time));
Tdays = t1:t2;
n = length(Tdays); % Time interval
nImages = n;

%% Figure and Animation Setup
fig = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
ax1 = gca;
im = cell(nImages, 1);
path = 'india27-11.shp';
S = shaperead(path);
n = length(S);

%% Visualization Loop
for jloop = 1:100 % length(Time) - Reduced to 100 for GIF creation efficiency
    plot(coastlon, coastlat, 'k', 'Linewidth', 3);
    xlim([55 100]);
    ylim([5 40]);
    hold on;
    pcolor(Lon, Lat, RainFall(:,:,jloop)');
    shading interp;
    colorbar;
    colormap(jet);

    % Overlay state boundaries
    for i = 1:n
        x = S(i).X;
        y = S(i).Y;
        plot(x, y, 'w', 'LineWidth', 2);
    end

    title(['Rainfall on: ' datestr(Tdays(jloop))]);
    frame = getframe(fig);
    im{jloop} = frame2im(frame);
    hold off; % Clear hold for next iteration
end

%% Create Animation File (GIF)
filename = 'RainFall_1981-2014.gif';
for idx = 1:100 % nImages - Reduced to 100 to match visualization loop
    [A, map] = rgb2ind(im{idx}, 256);
    if idx == 1
        imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 0.5);
    else
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
    end
end
