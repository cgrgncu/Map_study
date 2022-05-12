%**************************************************************************
%   Name: ETOPO1_Taiwan_DEM_mat_plot_v20220512a.m
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220512a
%   Description:�Q�ξ�z�n���uETOPO1_Taiwan_DEM.mat�vø�s�x�W�a�ι�(�t���`)�C
%       �����ѪR��:1-arc-minutes (~1.8 kilometers)�A���[��]�A���I���V�̷Ӹg�n�׮y�СF
%       ���{�ѪR��:��ơA���[����]�A�B�h�U���򩥪������I�A�V�W�����C
%   �ݨD�ɮ�:       
%       ETOPO1_Taiwan_DEM.mat(�qETOPO1_Bed_g_geotiff.tif�Ѩ��X�Ӫ�)�A
%       ���ɮץ�����m��u�@�ؿ��U����Ƨ��uETOPO1_Taiwan_DEM_mat�v���C
%**************************************************************************
    clear;clc;close all
    %--
    % ŪGeoTiff��
    tic
    temp_data=load('ETOPO1_Taiwan_DEM_mat\ETOPO1_Taiwan_DEM.mat');
    toc
    % Elapsed time is 0.010278 seconds.
    %--
    tic
    %--
    %
    disp(temp_data.ETOPO1_Taiwan_DEM.Description)
    % �ӷ�:�ۡuhttps://www.ngdc.noaa.gov/mgg/global/�v�U�����uETOPO1_Bed_g_geotiff.tif�v���Ѩ��X�x�W�d�򤺪���ơC
    % �����ѪR��:1-arc-minutes (~1.8 kilometers)�A���[��]�A���I���V�̷Ӹg�n�׮y�СF
    % ���{�ѪR��:��ơA���[����]�A�B�h�U���򩥪������I�A�V�W�����C
    %--
    % ���s�Ƨ�(�p�G���T�w�O���O�̷Ӽз�DEM��XYZ�榡�ƧǡA�h�i�H�ϥΦ���k�A���Ĳv���t�A�q�`�����зǸ�Ƥ��ݭn���B�J)
    % temp_data.ETOPO1_Taiwan_DEM.Data.XYZ=sortrows(temp_data.ETOPO1_Taiwan_DEM.Data.XYZ,[-2,1,3]);
    %--
    % �p��X�PY��V�������I�ƶq(�]���OGrid���U�A���������I�������bTick�W)
    X_Tick_count=sum(temp_data.ETOPO1_Taiwan_DEM.Data.XYZ(:,2)==temp_data.ETOPO1_Taiwan_DEM.Data.XYZ(1,2));
    disp(['X_Tick_count = ',num2str(X_Tick_count)])
    % X_Tick_count = 241
    Y_Tick_count=sum(temp_data.ETOPO1_Taiwan_DEM.Data.XYZ(:,1)==temp_data.ETOPO1_Taiwan_DEM.Data.XYZ(1,1));
    disp(['Y_Tick_count = ',num2str(Y_Tick_count)])
    % Y_Tick_count = 301
    %--
    % ��z���
    dem_xi=reshape(temp_data.ETOPO1_Taiwan_DEM.Data.XYZ(:,1),X_Tick_count,[])';
    dem_yi=reshape(temp_data.ETOPO1_Taiwan_DEM.Data.XYZ(:,2),X_Tick_count,[])';
    dem_zi=zeros(size(dem_xi));
    dem_ci_interp=reshape(temp_data.ETOPO1_Taiwan_DEM.Data.XYZ(:,3),X_Tick_count,[])';
    %--
    % ø��
    surf(dem_xi,dem_yi,dem_zi,dem_ci_interp,'FaceColor','interp','EdgeColor','none')
    % �վ�colorbar
    [temp_demcmap_cmap,temp_demcmap_clim]=demcmap(dem_ci_interp,1000);
    colormap(temp_demcmap_cmap)
    % ���colorbar�C
    color_bar_handle=colorbar('location','eastoutside');
    %--
    % �]�wcolorbar���D��r
    color_bar_title_handle=title(color_bar_handle,'Elevation[m]');
    % �վ��Lø�ϰѼ�(���Ǧn�����v�T)
    axis equal
    box on
    view(0,90)
    xlim([119 123])
    xlabel('Longitude[degrees]')
    ylim([21 26])
    ylabel('Latitude[degrees]')    
    % ���D
    title({'�x�W�a��ETOPO1�a�ι�(�t���`)';'�����ѪR��1����(��1.85����)';'�����ѪR��: ���(���:����)'})
    %--
    % �s��
    if ~(exist('Output','dir')==7)
        mkdir('Output')
    end
    saveas(gca,'Output\ETOPO1_Taiwan_DEM.png')
    %--