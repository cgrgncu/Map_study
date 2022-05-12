%**************************************************************************
%   Name: Taidp200m_2021_XYZ_to_mat_v20220512a.m
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220512a
%   Description:自「Taidp200m_2021.xyz」中取出資料。
%       水平解析度:(~200 meters)，單位[度]，座標系統:WGS84；
%       高程解析度:浮點數，單位[公尺]，高程原點為海平面，向上為正。
%**************************************************************************
    clear;clc;close all    
    %--
    % 讀取台灣附近XYZ檔，因為是Cell註冊模式，資料點不會剛好在經緯度上。
    tic
    Taidp200m_Taiwan_DEM.Data.XYZ=load('Taidp200m_2021_xyz/Taidp200m_2021.xyz');
    toc
    % Elapsed time is 4.879818 seconds.
    %--    
    Taidp200m_Taiwan_DEM.Data.XYZ_Header={'Longitude[degrees]','Latitude[degrees]','Elevation[m]'};
    %--
    % 補充資訊
    Taidp200m_Taiwan_DEM.Description='來源:自「海洋學門資料庫(Ocean Data Bank, ODB)」申請的「Taidp200m_2021.xyz」。水平解析度:(~200 meters)，單位[度]，座標系統:WGS84；高程解析度:浮點數，單位[公尺]，高程原點為海平面，向上為正。';
    Taidp200m_Taiwan_DEM.Version='20220512a';
    Taidp200m_Taiwan_DEM.Editor='HsiupoYeh';
    % 存檔
    if ~(exist('Output','dir')==7)
        mkdir('Output')
    end
    save('Output\Taidp200m_Taiwan_DEM.mat','Taidp200m_Taiwan_DEM','-v7.3')    
    %--