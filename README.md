# Restaurant-Sales-Performance-Analysis
A data analytics project using SQL (PostgreSQL) and Tableau to diagnose sales trends and operational efficiency for a restaurant.
# 🍴 Restaurant Sales Performance Analysis 

## 📌 專案背景 (Project Overview)
利用 SQL 與 Tableau 針對 12 個月的餐廳銷售數據進行營運診斷，重點在於營收趨勢追蹤與時段效能優化。

## 🛠️ 技術重點 (Technical Highlights)
- **數據清理 (Data Cleaning)**：使用正則表達式與日期函數統一銷售時間格式。
- **指標建模 (Metric Modeling)**：
  - 透過 `LAG()` 視窗函數計算月成長率 (MoM%)。
  - 使用 `::DECIMAL` 處理 PostgreSQL 的整數除法問題，確保成長率精度。
- **多維度聚合 (Multi-dimensional Aggregation)**：將明細表轉換為「時段 x 平假日」的交叉分析報表。

## 📊 關鍵發現 (Key Insights)
- **營收波動**：偵測到 2023/01 具備異常高成長，判斷為該數據集的特徵點。
- **營運優化**：週末晚間 (Weekend Night) 具備最高客單價 (AOV)，為人力配置之首選時段。

## 📁 檔案架構說明 (Project Structure)
- **Raw_Data/**: 存放原始銷售數據明細。
- **SQL_Scripts/**: 包含資料清洗與指標計算的 PostgreSQL 腳本。
- **Processed_Data/**: 經過 SQL 聚合後的報表數據 (CSV)，用於視覺化輸入。
- **Output_Reports/**: 最終分析成果，包含專案儀表板 PDF 檔。

## 📊 數據視覺化 (Visualization)
本專案採用 Tableau 進行指標呈現，您可以透過以下兩種方式查看成果：
1. **互動式儀表板**: [👉 點此進入 Tableau Public 連結](https://public.tableau.com/views/fast_food_test/1?:language=zh-TW&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
2. **靜態報告**: 請參考 `Output_Reports/` 資料夾下的 PDF 檔案。
