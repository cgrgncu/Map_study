%**************************************************************************
%   Name: SRTM15plus_Taiwan_DEM_mat_plot_v20220512a.m
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220512a
%   Description:�Q�ξ�z�n���uSRTM15plus_Taiwan_DEM.mat�vø�s�x�W�a�ι�(�t���`)�C
%       �����ѪR��:15-arc-seconds (~450 meters)�A���[��]�A�y�Шt��:WGS84�F
%       ���{�ѪR��:�B�I�ơA��줽�ءA���{���I���������A�V�W�����C
%   �ݨD�ɮ�:       
%       SRTM15plus_Taiwan_DEM.mat(�qhttps://topex.ucsd.edu/cgi-bin/get_srtm15.cgi?west=119&east=123&south=21&north=26�Ѩ��X�Ӫ�)�A
%       ���ɮץ�����m��u�@�ؿ��U����Ƨ��uSRTM15plus_Taiwan_DEM_mat�v���C
%**************************************************************************
    clear;clc;close all
    %--
    % Ūmat��
    tic
    temp_data=load('SRTM15plus_Taiwan_DEM_mat\SRTM15plus_Taiwan_DEM.mat');
    toc
    % Elapsed time is 0.010278 seconds.
    %--
    tic
    %--
    %
    disp(temp_data.SRTM15plus_Taiwan_DEM.Description)
    % �ӷ�:�ۡuhttps://topex.ucsd.edu/cgi-bin/get_srtm15.cgi?west=119&east=123&south=21&north=26�v�C
    % �����ѪR��:15-arc-seconds (~450 meters)�A���[��]�A�y�Шt��:WGS84�F
    % ���{�ѪR��:�B�I�ơA���[����]�A���{���I���������A�V�W�����C
    %--
    % ���s�Ƨ�(�p�G���T�w�O���O�̷Ӽз�DEM��XYZ�榡�ƧǡA�h�i�H�ϥΦ���k�A���Ĳv���t�A�q�`�����зǸ�Ƥ��ݭn���B�J)
    % temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ=sortrows(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ,[-2,1,3]);
    %--
    % �p��X�PY��V�������I�ƶq(�]���OGrid���U�A���������I�������bTick�W)
    X_Tick_count=sum(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,2)==temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(1,2));
    disp(['X_Tick_count = ',num2str(X_Tick_count)])
    % X_Tick_count = 960
    Y_Tick_count=sum(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,1)==temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(1,1));
    disp(['Y_Tick_count = ',num2str(Y_Tick_count)])
    % Y_Tick_count = 1200
    %--
    % ��z���
    dem_xi=reshape(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,1),X_Tick_count,[])';
    dem_yi=reshape(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,2),X_Tick_count,[])';
    dem_zi=zeros(size(dem_xi));
    dem_ci_interp=reshape(temp_data.SRTM15plus_Taiwan_DEM.Data.XYZ(:,3),X_Tick_count,[])';
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
    title({'�x�W�a��SRTM15+�a�ι�(�t���`)';'�����ѪR��: 15����(��450����)';'�����ѪR��: �B�I��(���:����)'})
    %--
    % �s��
    if ~(exist('Output','dir')==7)
        mkdir('Output')
    end
    saveas(gca,'Output\ETOPO1_Taiwan_DEM.png')
    %--