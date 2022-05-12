%**************************************************************************
%   Name: Taidp200m_2021_XYZ_to_mat_v20220512a.m
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220512a
%   Description:�ۡuTaidp200m_2021.xyz�v�����X��ơC
%       �����ѪR��:(~200 meters)�A���[��]�A�y�Шt��:WGS84�F
%       ���{�ѪR��:�B�I�ơA���[����]�A���{���I���������A�V�W�����C
%**************************************************************************
    clear;clc;close all    
    %--
    % Ū���x�W����XYZ�ɡA�]���OCell���U�Ҧ��A����I���|��n�b�g�n�פW�C
    tic
    Taidp200m_Taiwan_DEM.Data.XYZ=load('Taidp200m_2021_xyz/Taidp200m_2021.xyz');
    toc
    % Elapsed time is 4.879818 seconds.
    %--    
    Taidp200m_Taiwan_DEM.Data.XYZ_Header={'Longitude[degrees]','Latitude[degrees]','Elevation[m]'};
    %--
    % �ɥR��T
    Taidp200m_Taiwan_DEM.Description='�ӷ�:�ۡu���v�Ǫ���Ʈw(Ocean Data Bank, ODB)�v�ӽЪ��uTaidp200m_2021.xyz�v�C�����ѪR��:(~200 meters)�A���[��]�A�y�Шt��:WGS84�F���{�ѪR��:�B�I�ơA���[����]�A���{���I���������A�V�W�����C';
    Taidp200m_Taiwan_DEM.Version='20220512a';
    Taidp200m_Taiwan_DEM.Editor='HsiupoYeh';
    % �s��
    if ~(exist('Output','dir')==7)
        mkdir('Output')
    end
    save('Output\Taidp200m_Taiwan_DEM.mat','Taidp200m_Taiwan_DEM','-v7.3')    
    %--