%**************************************************************************
%   Name: ETOPO1_Taiwan_GeoTiff_to_mat_v20220512a.m
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220512a
%   Description:自「https://www.ngdc.noaa.gov/mgg/global/」下載的「ETOPO1_Bed_g_geotiff.tif」中萃取出台灣範圍內的資料。
%       水平解析度:1-arc-minutes (~1.8 kilometers)，單位[度]，原點正向依照經緯度座標；
%       高程解析度:1公尺，單位公尺，冰層下的基岩表面為原點，向上為正。
%       過程中順便展示地形圖，以利確認資料範圍。
%   需求檔案:       
%       ETOPO1_Bed_g_geotiff.tiff(下載自https://www.ngdc.noaa.gov/mgg/global/)，
%       該檔案必須放置於工作目錄下的資料夾「ETOPO1_GeoTiff」中。
%**************************************************************************
    clear;clc;close all
    %--
    % 讀GeoTiff檔
    tic
    dem_geotiff_data=imread('ETOPO1_GeoTiff\ETOPO1_Bed_g_geotiff.tif');
    toc
    % <10801x21601 int16>
    % Elapsed time is 3.071906 seconds.
    %--
    tic
    %--
    dem_geotiff_info=imfinfo('ETOPO1_GeoTiff\ETOPO1_Bed_g_geotiff.tif');
    toc
    % Elapsed time is 0.002642 seconds.
    %--
    %
    disp(dem_geotiff_info.Width)
    %        21601
    disp(dem_geotiff_info.Height)
    %        10801
    %--
    % ModelPixelScaleTag (ScaleX, ScaleY, ScaleZ)
    % ScaleX : 水平方向間距(單位要另外查詢)
    % ScaleY : 垂直方向間距(單位要另外查詢)
    % ScaleZ : 一般多屬於地圖，為2D狀況，此項填0，
    disp(dem_geotiff_info.ModelPixelScaleTag)
    %     0.0167
    %     0.0167
    %          0
    %--
    % ModelTiepointTag
    % 位置(I,J,K)的像素點對應實際(X,Y,Z)。
    % 一般多屬於地圖，為2D狀況，K、Z填0。
    disp(dem_geotiff_info.ModelTiepointTag)
    %          0
    %          0
    %          0
    %  -180.0083
    %    90.0083
    %          0
    % 以上描述原點(0,0,0)的像素對應實際座標(-180.0083,90.0083,0)。
    % 請注意數值位數顯示只有部分，實際上後面還有很多位數。
    %--
    dem_X_vector=(0:dem_geotiff_info.Width-1)*dem_geotiff_info.ModelPixelScaleTag(1)+dem_geotiff_info.ModelTiepointTag(4)+(dem_geotiff_info.ModelPixelScaleTag(1)/2);
    disp('dem_X_vector:')
    disp(num2str(dem_X_vector(1:5)))
    % -180     -179.9833     -179.9667       -179.95     -179.9333
    dem_Y_vector=(0:-1:-(dem_geotiff_info.Height-1))*dem_geotiff_info.ModelPixelScaleTag(2)+dem_geotiff_info.ModelTiepointTag(5)-(dem_geotiff_info.ModelPixelScaleTag(2)/2);
    disp('dem_Y_vector:')
    disp(num2str(dem_Y_vector(1:5)))
    % 90      89.9833      89.9667        89.95      89.9333
    %--
% 經度從-180到+180
target_start_lon=119;
    temp_start_lon_index=find(dem_X_vector>=target_start_lon, 1, 'first');
    if isempty(temp_start_lon_index)
        disp('錯誤!找不到目標範圍內的資料!')
        return
    end
target_end_lon=123;
    temp_end_lon_index=find(dem_X_vector>=target_end_lon, 1, 'first');
    if isempty(temp_end_lon_index)
        disp('錯誤!找不到目標範圍內的資料!')
        return
    end
    %--
    disp(['經度選擇範圍: ',num2str(target_start_lon),' ~ ',num2str(target_end_lon)])
    disp(['真正取出範圍: ',num2str(dem_X_vector(temp_start_lon_index)),' ~ ',num2str(dem_X_vector(temp_end_lon_index))])
    disp(['對應索引值範圍: ',num2str(temp_start_lon_index),' ~ ',num2str(temp_end_lon_index)])
    target_lon_vector=temp_start_lon_index:temp_end_lon_index;
%--
% 緯度從90到-90
target_start_lat=26;
    temp_start_lat_index=find(dem_Y_vector>=target_start_lat, 1, 'last');
    if isempty(temp_start_lat_index)
        disp('錯誤!找不到目標範圍內的資料!')
        return
    end
target_end_lat=21;
    temp_end_lat_index=find(dem_Y_vector>target_end_lat, 1, 'last');
    if isempty(temp_end_lat_index)
        disp('錯誤!找不到目標範圍內的資料!')
        return
    end
    %--
    disp(['緯度選擇範圍: ',num2str(target_start_lat),' ~ ',num2str(target_end_lat)])
    disp(['真正取出範圍: ',num2str(dem_Y_vector(temp_start_lat_index)),' ~ ',num2str(dem_Y_vector(temp_end_lat_index))])
    disp(['對應索引值範圍: ',num2str(temp_start_lat_index),' ~ ',num2str(temp_end_lat_index)])
    target_lat_vector=temp_start_lat_index:temp_end_lat_index;
    %--
    % 嘗試繪製成圖形，interp資料恰好是XYZ資料
    [xi,yi] = meshgrid(dem_X_vector(target_lon_vector),dem_Y_vector(target_lat_vector));
    zi=zeros(size(xi));
    ci_interp=double(dem_geotiff_data(target_lat_vector,target_lon_vector));
    surf(xi,yi,zi,ci_interp,'FaceColor','interp','EdgeColor','none')
    % 調整colorbar
    [temp_demcmap_cmap,temp_demcmap_clim]=demcmap(ci_interp,1000);
    colormap(temp_demcmap_cmap)
    colorbar
    % 調整其他繪圖參數(順序好像有影響)
    axis equal
    box on
    view(0,90)
    xlim([119 123])
    xlabel('Longitude[degrees]')
    ylim([21 26])
    ylabel('Latitude[degrees]')    
    % 標題
    title({'台灣地區ETOPO1地形圖(含水深)';'水平解析度1弧分(約1.85公里)，垂直解析度1公尺'})
    %--
    % 另存成mat檔案
    % 符合DEM的XYZ檔案格式
    % 普通XYZ格式如下:
    % xyz =
    %      1     1     1
    %      1     2     2
    %      1     3     3
    %      1     4     4
    %      2     1     5
    %      2     2     6
    %      2     3     7
    %      2     4     8
    %      3     1     9
    %      3     2    10
    %      3     3    11
    %      3     4    12
    %      4     1    13
    %      4     2    14
    %      4     3    15
    %      4     4    16
    %      5     1    17
    %      5     2    18
    %      5     3    19
    %      5     4    20
    %--
    % 可用dem_xyz=sortrows(xyz,[-2,1,3])排序為標準DEM格式，但效率極差。
    % 標準DEM的XYZ格式如下:
    %--
    % dem_xyz =
    % 
    %      1     4     4
    %      2     4     8
    %      3     4    12
    %      4     4    16
    %      5     4    20
    %      1     3     3
    %      2     3     7
    %      3     3    11
    %      4     3    15
    %      5     3    19
    %      1     2     2
    %      2     2     6
    %      3     2    10
    %      4     2    14
    %      5     2    18
    %      1     1     1
    %      2     1     5
    %      3     1     9
    %      4     1    13
    %      5     1    17
    %--
    % 快速轉置GeoTiff資料恰好可以排出標準DEM的XYZ格式
    xi=xi';
    yi=yi';
    ci_interp=ci_interp';
    ETOPO1_Taiwan_DEM.Data.XYZ=[xi(:) yi(:) ci_interp(:)];
    ETOPO1_Taiwan_DEM.Data.XYZ_Header={'Longitude[degrees]','Latitude[degrees]','Elevation[m]'};
    %--
    % 補充資訊
    ETOPO1_Taiwan_DEM.Description='來源:自「https://www.ngdc.noaa.gov/mgg/global/」下載的「ETOPO1_Bed_g_geotiff.tif」中萃取出台灣範圍內的資料。水平解析度:1-arc-minutes (~1.8 kilometers)，單位[度]，原點正向依照經緯度座標；高程解析度:1公尺，單位公尺，冰層下的基岩表面為原點，向上為正。';
    ETOPO1_Taiwan_DEM.Version='20220512a';
    ETOPO1_Taiwan_DEM.Editor='HsiupoYeh';
    % 存檔
    if ~(exist('Output','dir')==7)
        mkdir('Output')
    end
    save('Output\ETOPO1_Taiwan_DEM.mat','ETOPO1_Taiwan_DEM','-v7.3')
    %--