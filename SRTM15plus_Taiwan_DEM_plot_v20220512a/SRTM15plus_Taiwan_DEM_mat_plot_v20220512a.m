%**************************************************************************
%   Name: SRTM15plus_Taiwan_DEM_mat_plot_v20220512a.m
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220512a
%   Description:利用整理好的「SRTM15plus_Taiwan_DEM.mat」繪製台灣地形圖(含水深)。
%       水平解析度:15-arc-seconds (~450 meters)，單位[度]，座標系統:WGS84；
%       高程解析度:浮點數，單位公尺，高程原點為海平面，向上為正。
%   需求檔案:       
%       SRTM15plus_Taiwan_DEM.mat(從https://topex.ucsd.edu/cgi-bin/get_srtm15.cgi?west=119&east=123&south=21&north=26萃取出來的)，
%       該檔案必須放置於工作目錄下的資料夾「SRTM15plus_Taiwan_DEM_mat」中。
%**************************************************************************
    clear;clc;close all
    %--
    % 讀mat檔
    tic
    temp_data=load('SRTM15plus_Taiwan_DEM_mat\SRTM15plus_Taiwan_DEM.mat');
    toc
    % Elapsed time is 0.010278 seconds.
    %--
    tic
    %--
    %
    disp(temp_data.SRTM15plus_Taiwan_DEM.Description)
    % 來源:自「https://topex.ucsd.edu/cgi-bin/get_srtm15.cgi?west=119&east=123&south=21&north=26」。
    % 水平解析度:15-arc-seconds (~450 meters)，單位[度]，座標系統:WGS84；
    % 高程解析度:浮點數，單位[公尺]，高程原點為海平面，向上為正。
    %--
    % 重新排序(如果不確定是不是依照標準DEM的XYZ格式排序，則可以使用此方法，但效率極差，通常對應標準資料不需要此步驟)
    % temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ=sortrows(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ,[-2,1,3]);
    %--
    % 計算X與Y方向的像素點數量(因為是Grid註冊，像素中心點都坐落在Tick上)
    X_Tick_count=sum(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,2)==temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(1,2));
    disp(['X_Tick_count = ',num2str(X_Tick_count)])
    % X_Tick_count = 960
    Y_Tick_count=sum(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,1)==temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(1,1));
    disp(['Y_Tick_count = ',num2str(Y_Tick_count)])
    % Y_Tick_count = 1200
    %--
    % 整理資料
    dem_xi=reshape(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,1),X_Tick_count,[])';
    dem_yi=reshape(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,2),X_Tick_count,[])';
    dem_zi=zeros(size(dem_xi));
    dem_ci_interp=reshape(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,3),X_Tick_count,[])';
    %--
    % 繪圖
    surf(dem_xi,dem_yi,dem_zi,dem_ci_interp,'FaceColor','interp','EdgeColor','none')
    % 調整colorbar
    [temp_demcmap_cmap,temp_demcmap_clim]=demcmap(dem_ci_interp,1000);
    colormap(temp_demcmap_cmap)
    % 顯示colorbar。
    color_bar_handle=colorbar('location','eastoutside');
    %--
    % 設定colorbar標題文字
    color_bar_title_handle=title(color_bar_handle,'Elevation[m]');
    % 調整其他繪圖參數(順序好像有影響)
    axis equal
    box on
    view(0,90)
    xlim([119 123])
    xlabel('Longitude[degrees]')
    ylim([21 26])
    ylabel('Latitude[degrees]')    
    % 標題
    title({'台灣地區SRTM15+地形圖(含水深)';'水平解析度: 15弧秒(約450公尺)';'垂直解析度: 浮點數(單位:公尺)'})
    %--
    % 存檔
    if ~(exist('Output','dir')==7)
        mkdir('Output')
    end
    saveas(gca,'Output\ETOPO1_Taiwan_DEM.png')
    %--