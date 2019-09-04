% function RFainFallViz(ncfilename)
% INPUT     : netCDF file name
% OUTPUT    : Vizualizatoin of statewise rainfall .
% Author:   PAVAN KUMAR JONNAKUTI
%           Project Scientist - B
%           Data Information & Management Group
%           Indian National Centre for Ocean Information Services (INCOIS)
%           "Ocean Valley", Pragathi Nagar (B.O)
%           Nizampet (S.O), Hyderabad - 500 090
%           Telangana, INDIA
% E-mail:   jpawan33@gmail.com
% Web-link: http://www.jpavan.com
% Copyright @ Author
% code : Visualization of RainFall Data
% version : version 1, 06/03/2017
clc;clear all;
%%
load coastlines.mat
file = 'RainFall.nc' ;
Lon = ncread(file,'lon') ;
Lat = ncread(file,'lat') ;
Time = ncread(file,'time') ;
RainFall=ncread(file,'rf');
%%
t1 = datetime(1981,01,01,0,0,0); t2 = t1+days(length(Time));
Tdays = t1:t2;
n = length(Tdays); % Time interval
nImages = n;
fig = figure('units','normalized','outerposition',[0 0 1 1]);
ax1 = gca;
im = cell(nImages,1);
path = 'india27-11.shp' ;
S = shaperead(path) ;
n = length(S) ;
for jloop = 1:100 % length(Time)
    plot(coastlon,coastlat,'k','Linewidth',3)
    xlim([55 100])
    ylim([5 40])
    hold on
    pcolor(Lon,Lat,RainFall(:,:,jloop)');shading interp
    colorbar
    colormap(jet)
    for i = 1:n
        x = S(i).X ; y = S(i).Y ;
        [X,Y] = meshgrid(x,y);
        plot(x,y,'w','LineWidth',2)
    end
    title(['Rainfall on: ' datestr(Tdays(jloop))])
    frame = getframe(fig); % Captures every frame of the figure
    im{jloop} = frame2im(frame); % Image data is saved in im
end
%% Create Animation File
filename = 'RainFall_1981-2014.gif'; % Specify the output file name
for idx = 1:100 % nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.5);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.5);
    end
end