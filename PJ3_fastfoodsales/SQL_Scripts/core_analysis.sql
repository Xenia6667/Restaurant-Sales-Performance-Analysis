
/*
 Q1.賺多少？哪些月份賺最多？支付時段？假日和平日？
 Q2.（服務人員）在不同時段的處理金額
 Q3.「熱門餐點留存率」，分析某個餐點（item_name）在不同月份是否持續被點購
 Q4.Fastfood 與 Beverages 的配比分析。計算 item_type 的銷售佔比與獲利能力。
 分析點：分析「買漢堡（Fastfood）的人是否一定會配飲料（Beverages）」？這就是餐飲業的 附帶率 (Attachment Rate)。
 Q5.利用 order_id 做 Self-Join，找出同一張訂單中最常出現的組合。
*/

set search_path to fast_food_sales_data;

-- 營收趨勢診斷 
CREATE OR REPLACE VIEW Monthly_Revenue_Trend AS
SELECT 
    sale_month,
    SUM(transaction_amount) AS monthly_revenue,
    COUNT(order_id) AS total_orders,
    -- 核心統計：計算上個月營收，並算出成長率
    ROUND(
        (SUM(transaction_amount) - LAG(SUM(transaction_amount)) OVER (ORDER BY sale_month))::DECIMAL 
        -- SQL有很奇怪的限制，如果當初是以整數相除的話，結果也壹定華是整數，所以要再設定
        -- 為什麼是放這個位置呢？如果放除完後，結果就變成0了，這樣會來不及，所以要提前變小數
        / NULLIF(LAG(SUM(transaction_amount)) OVER (ORDER BY sale_month), 0) * 100, 2
    ) || '%' AS mom_growth -- || '%'：這是「膠水」，把算出來的數字跟 % 符號黏在一起，讓報表變得很漂亮。
FROM stain_food_df
GROUP BY 1
ORDER BY 1 DESC;


-- 時段與平假日的交叉影響
CREATE OR REPLACE VIEW Peak_Hour_Performance AS
SELECT 
	sale_month,
    time_of_sale,
    day_type,
    SUM(transaction_amount) AS period_revenue,
    -- 能一眼看出哪個時段是「營收支柱」
    ROUND(SUM(transaction_amount) * 100.0 / SUM(SUM(transaction_amount)) OVER(), 2) || '%' AS rev_share,
    ROUND(AVG(transaction_amount), 2) AS avg_ticket_size
FROM stain_food_df
GROUP BY 1, 2, 3
ORDER BY 1, 4 DESC;