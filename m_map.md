### 練習 m_map

### 步驟
+ 下載zip檔案，檔案大小8.87[MB]。https://www.eos.ubc.ca/~rich/m_map1.4.zip


```matlab
clear;clc;close all
load topo

subplot(2,1,1);  % Example without it
imagesc([0 360],[-90 90],topo);
caxis([-5000 5000]);
colormap([m_colmap('water',64);m_colmap('gland',64)]);
set(gca,'ydir','normal');

subplot(2,1,2);  % Example with it
caxis([-5000 5000]);
colormap([m_colmap('water',64);m_colmap('gland',64)]);
m_shadedrelief([0 360],[-90 90],topo,'gradient',1000,'coord','Z');
axis tight
```
