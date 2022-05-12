%**************************************************************************
%   Name: ETOPO1_Taiwan_GeoTiff_to_mat_v20220512a.m
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220512a
%   Description:�ۡuhttps://www.ngdc.noaa.gov/mgg/global/�v�U�����uETOPO1_Bed_g_geotiff.tif�v���Ѩ��X�x�W�d�򤺪���ơC
%       �����ѪR��:1-arc-minutes (~1.8 kilometers)�A���[��]�A���I���V�̷Ӹg�n�׮y�СF
%       ���{�ѪR��:1���ءA��줽�ءA�B�h�U���򩥪������I�A�V�W�����C
%       �L�{�����K�i�ܦa�ιϡA�H�Q�T�{��ƽd��C
%   �ݨD�ɮ�:       
%       ETOPO1_Bed_g_geotiff.tiff(�U����https://www.ngdc.noaa.gov/mgg/global/)�A
%       ���ɮץ�����m��u�@�ؿ��U����Ƨ��uETOPO1_GeoTiff�v���C
%**************************************************************************
    clear;clc;close all
    %--
    % ŪGeoTiff��
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
    % ScaleX : ������V���Z(���n�t�~�d��)
    % ScaleY : ������V���Z(���n�t�~�d��)
    % ScaleZ : �@��h�ݩ�a�ϡA��2D���p�A������0�A
    disp(dem_geotiff_info.ModelPixelScaleTag)
    %     0.0167
    %     0.0167
    %          0
    %--
    % ModelTiepointTag
    % ��m(I,J,K)�������I�������(X,Y,Z)�C
    % �@��h�ݩ�a�ϡA��2D���p�AK�BZ��0�C
    disp(dem_geotiff_info.ModelTiepointTag)
    %          0
    %          0
    %          0
    %  -180.0083
    %    90.0083
    %          0
    % �H�W�y�z���I(0,0,0)������������ڮy��(-180.0083,90.0083,0)�C
    % �Ъ`�N�ƭȦ����ܥu�������A��ڤW�᭱�٦��ܦh��ơC
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
% �g�ױq-180��+180
target_start_lon=119;
    temp_start_lon_index=find(dem_X_vector>=target_start_lon, 1, 'first');
    if isempty(temp_start_lon_index)
        disp('���~!�䤣��ؼнd�򤺪����!')
        return
    end
target_end_lon=123;
    temp_end_lon_index=find(dem_X_vector>=target_end_lon, 1, 'first');
    if isempty(temp_end_lon_index)
        disp('���~!�䤣��ؼнd�򤺪����!')
        return
    end
    %--
    disp(['�g�׿�ܽd��: ',num2str(target_start_lon),' ~ ',num2str(target_end_lon)])
    disp(['�u�����X�d��: ',num2str(dem_X_vector(temp_start_lon_index)),' ~ ',num2str(dem_X_vector(temp_end_lon_index))])
    disp(['�������ޭȽd��: ',num2str(temp_start_lon_index),' ~ ',num2str(temp_end_lon_index)])
    target_lon_vector=temp_start_lon_index:temp_end_lon_index;
%--
% �n�ױq90��-90
target_start_lat=26;
    temp_start_lat_index=find(dem_Y_vector>=target_start_lat, 1, 'last');
    if isempty(temp_start_lat_index)
        disp('���~!�䤣��ؼнd�򤺪����!')
        return
    end
target_end_lat=21;
    temp_end_lat_index=find(dem_Y_vector>target_end_lat, 1, 'last');
    if isempty(temp_end_lat_index)
        disp('���~!�䤣��ؼнd�򤺪����!')
        return
    end
    %--
    disp(['�n�׿�ܽd��: ',num2str(target_start_lat),' ~ ',num2str(target_end_lat)])
    disp(['�u�����X�d��: ',num2str(dem_Y_vector(temp_start_lat_index)),' ~ ',num2str(dem_Y_vector(temp_end_lat_index))])
    disp(['�������ޭȽd��: ',num2str(temp_start_lat_index),' ~ ',num2str(temp_end_lat_index)])
    target_lat_vector=temp_start_lat_index:temp_end_lat_index;
    %--
    % ����ø�s���ϧΡAinterp��ƫ�n�OXYZ���
    [xi,yi] = meshgrid(dem_X_vector(target_lon_vector),dem_Y_vector(target_lat_vector));
    zi=zeros(size(xi));
    ci_interp=double(dem_geotiff_data(target_lat_vector,target_lon_vector));
    surf(xi,yi,zi,ci_interp,'FaceColor','interp','EdgeColor','none')
    % �վ�colorbar
    [temp_demcmap_cmap,temp_demcmap_clim]=demcmap(ci_interp,1000);
    colormap(temp_demcmap_cmap)
    colorbar
    % �վ��Lø�ϰѼ�(���Ǧn�����v�T)
    axis equal
    box on
    view(0,90)
    xlim([119 123])
    xlabel('Longitude[degrees]')
    ylim([21 26])
    ylabel('Latitude[degrees]')    
    % ���D
    title({'�x�W�a��ETOPO1�a�ι�(�t���`)';'�����ѪR��1����(��1.85����)�A�����ѪR��1����'})
    %--
    % �t�s��mat�ɮ�
    % �ŦXDEM��XYZ�ɮ׮榡
    % ���qXYZ�榡�p�U:
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
    % �i��dem_xyz=sortrows(xyz,[-2,1,3])�ƧǬ��з�DEM�榡�A���Ĳv���t�C
    % �з�DEM��XYZ�榡�p�U:
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
    % �ֳt��mGeoTiff��ƫ�n�i�H�ƥX�з�DEM��XYZ�榡
    xi=xi';
    yi=yi';
    ci_interp=ci_interp';
    ETOPO1_Taiwan_DEM.Data.XYZ=[xi(:) yi(:) ci_interp(:)];
    ETOPO1_Taiwan_DEM.Data.XYZ_Header={'Longitude[degrees]','Latitude[degrees]','Elevation[m]'};
    %--
    % �ɥR��T
    ETOPO1_Taiwan_DEM.Description='�ӷ�:�ۡuhttps://www.ngdc.noaa.gov/mgg/global/�v�U�����uETOPO1_Bed_g_geotiff.tif�v���Ѩ��X�x�W�d�򤺪���ơC�����ѪR��:1-arc-minutes (~1.8 kilometers)�A���[��]�A���I���V�̷Ӹg�n�׮y�СF���{�ѪR��:1���ءA��줽�ءA�B�h�U���򩥪������I�A�V�W�����C';
    ETOPO1_Taiwan_DEM.Version='20220512a';
    ETOPO1_Taiwan_DEM.Editor='HsiupoYeh';
    % �s��
    if ~(exist('Output','dir')==7)
        mkdir('Output')
    end
    save('Output\ETOPO1_Taiwan_DEM.mat','ETOPO1_Taiwan_DEM','-v7.3')
    %--