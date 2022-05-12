# Map_study
地圖相關的筆記

### 水平解析度單位清單
+ 1-degree (~110 kilometers)
+ 7.5-arc-minutes	(~14 kilometers)
+ 1-arc-minutes	(~1.8 kilometers)
+ 30-arc-seconds (~1 kilometers)
+ 15-arc-seconds (~450 meters)
+ 7.5-arc-seconds (~225 meters)
+ 3-arc-seconds	(~90 meters)
+ 1/3-arc-seconds (~10 meters)	
+ 1/9-arc-second s(~3.4 meters)

### 知名的資料來源
+ ETOPO1，1-arc-minutes (~1.8 kilometers)，有水深資料
  + GeoTiff格式
    + 水平基準: 坐標系統為WGS84 ；
+ SRTM15+ V2.3，15-arc-seconds (~450 meters)，有水深資料
  + 網頁XYZ萃取工具: https://topex.ucsd.edu/cgi-bin/get_srtm15.cgi 
    + 其實可以用GET方法取得資料，例如: https://topex.ucsd.edu/cgi-bin/get_srtm15.cgi?west=119.0&east=119.2&south=21&north=21.1 
    + 看起來XYZ點沒有落在整數經緯度上，應該是Cell註冊。
+ 海洋學門資料庫(Ocean Data Bank, ODB)-網格化水深資料 
  + 資料申請網頁: https://www.odb.ntu.edu.tw/odb-services/
  + 申請資料基本費用500元。科技部計畫半價。
    + 2022年5月申請到的資料檔案是「Taidp200m_2021.zip」，檔案大小:35.9[MB]。解壓縮後為「Taidp200m_2021.xyz」，檔案大小:139[MB]。
    + 網格化資料(*.xyz)內容依序為 經度 緯度 高程(公尺)值；
      + 水平基準: 坐標系統為WGS84 ；
      + 垂直基準: 由於探測任務的不同及人力有限，測量的高程基準皆為當時當地的海水面，亦未做潮汐校正。
+ 內政部DTM
+ GMT
  + 基本上是從各大平台蒐集資料後一併轉換為GTM自己的命名格式，存成*.nc檔案，其中高程是用短整數(short int，等同於16-bits integer)儲存。所以檔案小很多。
  + REF: https://docs.generic-mapping-tools.org/6.0/datasets/earth_relief.html

### 海岸線/邊界
+ 全球自我一致性分層高解析度地理資料庫，(Global Self-consistent, Hierarchical, High-resolution Geography Database, GSHHG) 
  + 網址: https://www.ngdc.noaa.gov/mgg/shorelines/gshhs.html
  + 文獻: Wessel, P., & Smith, W. H. (1996). A global, self‐consistent, hierarchical, high‐resolution shoreline database. Journal of Geophysical Research: Solid Earth, 101(B4), 8741-8743.
  + 最新更新版本: GSHHG data version 2.3.7 (June 15, 2017) ，檔案大小142[MB]。
