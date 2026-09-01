
WITH tb_base_ativa AS (
    SELECT *
    FROM sales
    WHERE Date < '{data_ref}'
      AND Date >= DATE('{data_ref}', '-84 Day')
),

tb_vendas_stat AS (
    SELECT 
        t1.Store,

        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') THEN t1.Sales END) AS  QtdSales7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') THEN t1.Sales END) AS QtdSales14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') THEN t1.Sales END) AS QtdSales28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') THEN t1.Sales END) AS QtdSales42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') THEN t1.Sales END) AS QtdSales56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') THEN t1.Sales END) AS QtdSales84d,

        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 1 THEN t1.Sales END) AS  AvgSales7d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 1 THEN t1.Sales END) AS AvgSales14d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 1 THEN t1.Sales END) AS AvgSales28d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 1 THEN t1.Sales END) AS AvgSales42d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 1 THEN t1.Sales END) AS AvgSales56d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 1 THEN t1.Sales END) AS AvgSales84d,

        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 1 THEN t1.Sales END) AS  MinSales7d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 1 THEN t1.Sales END) AS MinSales14d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 1 THEN t1.Sales END) AS MinSales28d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 1 THEN t1.Sales END) AS MinSales42d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 1 THEN t1.Sales END) AS MinSales56d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 1 THEN t1.Sales END) AS MinSales84d,

        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 1 THEN t1.Sales END) AS  MaxSales7d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 1 THEN t1.Sales END) AS MaxSales14d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 1 THEN t1.Sales END) AS MaxSales28d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 1 THEN t1.Sales END) AS MaxSales42d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 1 THEN t1.Sales END) AS MaxSales56d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 1 THEN t1.Sales END) AS MaxSales84d,


        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 THEN t1.Sales END) AS  QtdSalesPromo7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 THEN t1.Sales END) AS QtdSalesPromo14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 THEN t1.Sales END) AS QtdSalesPromo28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 THEN t1.Sales END) AS QtdSalesPromo42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 THEN t1.Sales END) AS QtdSalesPromo56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 THEN t1.Sales END) AS QtdSalesPromo84d,

        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS  AvgSalesPromo7d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesPromo14d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesPromo28d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesPromo42d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesPromo56d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesPromo84d,

        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesPromo7d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesPromo14d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesPromo28d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesPromo42d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesPromo56d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesPromo84d,
        

        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 THEN t1.Sales END) AS  MaxSalesPromo7d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 THEN t1.Sales END) AS MaxSalesPromo14d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 THEN t1.Sales END) AS MaxSalesPromo28d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 THEN t1.Sales END) AS MaxSalesPromo42d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 THEN t1.Sales END) AS MaxSalesPromo56d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 THEN t1.Sales END) AS MaxSalesPromo84d,

        
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 THEN t1.Sales END) AS  QtdSalesNoPromo7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 THEN t1.Sales END) AS QtdSalesNoPromo14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 THEN t1.Sales END) AS QtdSalesNoPromo28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 THEN t1.Sales END) AS QtdSalesNoPromo42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 THEN t1.Sales END) AS QtdSalesNoPromo56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 THEN t1.Sales END) AS QtdSalesNoPromo84d,

        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS  AvgSalesNoPromo7d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesNoPromo14d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesNoPromo28d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesNoPromo42d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesNoPromo56d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS AvgSalesNoPromo84d,

        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS  MinSalesNoPromo7d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesNoPromo14d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesNoPromo28d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesNoPromo42d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesNoPromo56d,
        MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Sales END) AS MinSalesNoPromo84d,
        

        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 THEN t1.Sales END) AS  MaxSalesNoPromo7d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 THEN t1.Sales END) AS MaxSalesNoPromo14d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 THEN t1.Sales END) AS MaxSalesNoPromo28d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 THEN t1.Sales END) AS MaxSalesNoPromo42d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 THEN t1.Sales END) AS MaxSalesNoPromo56d,
        MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 THEN t1.Sales END) AS MaxSalesNoPromo84d
    FROM tb_base_ativa AS t1
    GROUP BY t1.Store
),

tb_vendas_lift_promo AS (
    SELECT
        Store,
        (AvgSalesPromo7d - AvgSalesNoPromo7d) / NULLIF(AvgSalesNoPromo7d, 0) AS LiftSalesPromo7d,
        (AvgSalesPromo14d - AvgSalesNoPromo14d) / NULLIF(AvgSalesNoPromo14d, 0) AS LiftSalesPromo14d,
        (AvgSalesPromo28d - AvgSalesNoPromo28d) / NULLIF(AvgSalesNoPromo28d, 0) AS LiftSalesPromo28d,
        (AvgSalesPromo42d - AvgSalesNoPromo42d) / NULLIF(AvgSalesNoPromo42d, 0) AS LiftSalesPromo42d,
        (AvgSalesPromo56d - AvgSalesNoPromo56d) / NULLIF(AvgSalesNoPromo56d, 0) AS LiftSalesPromo56d,
        (AvgSalesPromo84d - AvgSalesNoPromo84d) / NULLIF(AvgSalesNoPromo84d, 0) AS LiftSalesPromo84d
    FROM tb_vendas_stat
),


tb_year_ago AS (
    SELECT
        t1.Store,
        AVG(CASE WHEN t1.Date >= DATE(DATE('{data_ref}', '-365 Day'), '-42 Day') AND t1.Open = 1 THEN t1.Sales END) AS AvgSales42dYearAgo
    FROM sales AS t1
    WHERE t1.Date < DATE('{data_ref}', '-365 Day')
        AND t1.Date >= DATE(DATE('{data_ref}', '-365 Day'), '-42 Day')
    GROUP BY t1.Store
),

tb_crescimento_ano AS (
    SELECT
        t1.Store,
        (t2.AvgSales42d - t1.AvgSales42dYearAgo) / NULLIF(t1.AvgSales42dYearAgo, 0) AS SalesGrowth42dYearAgo
    FROM tb_year_ago t1
    INNER JOIN (
        SELECT
            Store,
            AVG(CASE WHEN Date >= DATE('{data_ref}', '-42 Day') AND Open = 1 THEN Sales END) AS AvgSales42d
        FROM sales
        WHERE Date < '{data_ref}' AND Date >= DATE('{data_ref}', '-42 Day')
        GROUP BY Store
    ) t2 ON t1.Store = t2.Store
), 


tb_vendas_por_cliente AS (
    SELECT
        t1.Store,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') THEN t1.Sales END) * 1.0 / NULLIF(SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') THEN t1.Customers END), 0) AS SalesPerCustomer7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') THEN t1.Sales END) * 1.0 / NULLIF(SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') THEN t1.Customers END), 0) AS SalesPerCustomer14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') THEN t1.Sales END) * 1.0 / NULLIF(SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') THEN t1.Customers END), 0) AS SalesPerCustomer28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') THEN t1.Sales END) * 1.0 / NULLIF(SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') THEN t1.Customers END), 0) AS SalesPerCustomer42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') THEN t1.Sales END) * 1.0 / NULLIF(SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') THEN t1.Customers END), 0) AS SalesPerCustomer56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') THEN t1.Sales END) * 1.0 / NULLIF(SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') THEN t1.Customers END), 0) AS SalesPerCustomer84d,
        
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Customers > 0 THEN CAST(t1.Sales AS float) / t1.Customers END) AS AvgSalesPerCustomer7d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Customers > 0 THEN CAST(t1.Sales AS float) / t1.Customers END) AS AvgSalesPerCustomer14d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Customers > 0 THEN CAST(t1.Sales AS float) / t1.Customers END) AS AvgSalesPerCustomer28d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Customers > 0 THEN CAST(t1.Sales AS float) / t1.Customers END) AS AvgSalesPerCustomer42d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Customers > 0 THEN CAST(t1.Sales AS float) / t1.Customers END) AS AvgSalesPerCustomer56d,
        AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Customers > 0 THEN CAST(t1.Sales AS float) / t1.Customers END) AS AvgSalesPerCustomer84d

    FROM tb_base_ativa AS t1
    GROUP BY t1.Store
), 

tb_vendas_dia_semana AS (
    SELECT
        t1.Store,
        w.DayOfWeek,
        
        SUM(CASE WHEN w.WeekRank <= 4 THEN t1.Sales END) AS SalesSumLast4,
        AVG(CASE WHEN w.WeekRank <= 4 THEN t1.Sales END) AS SalesAvgLast4,


        SUM(CASE WHEN w.WeekRank <= 8 THEN t1.Sales END) AS SalesSumLast8,
        AVG(CASE WHEN w.WeekRank <= 8 THEN t1.Sales END) AS SalesAvgLast8,


        SUM(CASE WHEN w.WeekRank <= 12 THEN t1.Sales END) AS SalesSumLast12,
        AVG(CASE WHEN w.WeekRank <= 12 THEN t1.Sales END) AS SalesAvgLast12

    FROM (
        SELECT *,
        CAST (strftime('%w', Date) AS INTEGER) AS DayOfWeek
        FROM tb_base_ativa
    ) t1
    JOIN (
        SELECT
            Store,
            Date,
            CAST(strftime('%w', Date) AS INTEGER) AS DayOfWeek,
            ROW_NUMBER() OVER (PARTITION BY Store, CAST(strftime('%w', Date) AS INTEGER) ORDER BY Date DESC) AS WeekRank
        FROM tb_base_ativa
    ) w
    ON t1.Store = w.Store AND t1.Date = w.Date
    GROUP BY t1.Store, w.DayOfWeek
)

SELECT
    '{data_ref}' AS DtRef,
    s.Store AS IdStore,
    s.QtdSales7d,
    s.QtdSales14d,
    s.QtdSales28d,
    s.QtdSales42d,
    s.QtdSales56d,
    s.QtdSales84d,
    s.AvgSales7d,
    s.AvgSales14d,
    s.AvgSales28d,
    s.AvgSales42d,
    s.AvgSales56d,
    s.AvgSales84d,
    s.MinSales7d,
    s.MinSales14d,
    s.MinSales28d,
    s.MinSales42d,
    s.MinSales56d,
    s.MinSales84d,
    s.MaxSales7d,
    s.MaxSales14d,
    s.MaxSales28d,
    s.MaxSales42d,
    s.MaxSales56d,
    s.MaxSales84d,
    s.QtdSalesPromo7d,
    s.QtdSalesPromo14d,
    s.QtdSalesPromo28d,
    s.QtdSalesPromo42d,
    s.QtdSalesPromo56d,
    s.QtdSalesPromo84d,
    s.AvgSalesPromo7d,
    s.AvgSalesPromo14d,
    s.AvgSalesPromo28d,
    s.AvgSalesPromo42d,
    s.AvgSalesPromo56d,
    s.AvgSalesPromo84d,
    s.MinSalesPromo7d,
    s.MinSalesPromo14d,
    s.MinSalesPromo28d,
    s.MinSalesPromo42d,
    s.MinSalesPromo56d,
    s.MinSalesPromo84d,
    s.MaxSalesPromo7d,
    s.MaxSalesPromo14d,
    s.MaxSalesPromo28d,
    s.MaxSalesPromo42d,
    s.MaxSalesPromo56d,
    s.MaxSalesPromo84d,
    s.QtdSalesNoPromo7d,
    s.QtdSalesNoPromo14d,
    s.QtdSalesNoPromo28d,
    s.QtdSalesNoPromo42d,
    s.QtdSalesNoPromo56d,
    s.QtdSalesNoPromo84d,
    s.AvgSalesNoPromo7d,
    s.AvgSalesNoPromo14d,
    s.AvgSalesNoPromo28d,
    s.AvgSalesNoPromo42d,
    s.AvgSalesNoPromo56d,
    s.AvgSalesNoPromo84d,
    s.MinSalesNoPromo7d,
    s.MinSalesNoPromo14d,
    s.MinSalesNoPromo28d,
    s.MinSalesNoPromo42d,
    s.MinSalesNoPromo56d,
    s.MinSalesNoPromo84d,
    s.MaxSalesNoPromo7d,
    s.MaxSalesNoPromo14d,
    s.MaxSalesNoPromo28d,
    s.MaxSalesNoPromo42d,
    s.MaxSalesNoPromo56d,
    s.MaxSalesNoPromo84d,
    (s.AvgSales7d - s.AvgSales28d)  / NULLIF(s.AvgSales28d,0)  AS Growth_AvgSales_7d_vs_28d,
    (s.AvgSales14d - s.AvgSales28d) / NULLIF(s.AvgSales28d,0)  AS Growth_AvgSales_14d_vs_28d,
    (s.AvgSales28d - s.AvgSales56d) / NULLIF(s.AvgSales56d,0)  AS Growth_AvgSales_28d_vs_56d,
    (s.AvgSales42d - s.AvgSales84d) / NULLIF(s.AvgSales84d,0)  AS Growth_AvgSales_42d_vs_84d,
    l.LiftSalesPromo7d,
    l.LiftSalesPromo14d,
    l.LiftSalesPromo28d,
    l.LiftSalesPromo42d,
    l.LiftSalesPromo56d,
    l.LiftSalesPromo84d,
    c.SalesGrowth42dYearAgo,
    v.SalesPerCustomer7d,
    v.SalesPerCustomer14d,
    v.SalesPerCustomer28d,
    v.SalesPerCustomer42d,
    v.SalesPerCustomer56d,
    v.SalesPerCustomer84d,
    v.AvgSalesPerCustomer7d,
    v.AvgSalesPerCustomer14d,
    v.AvgSalesPerCustomer28d,
    v.AvgSalesPerCustomer42d,
    v.AvgSalesPerCustomer56d,
    v.AvgSalesPerCustomer84d
FROM tb_vendas_stat s
LEFT JOIN tb_vendas_lift_promo l ON s.Store = l.Store
LEFT JOIN tb_crescimento_ano c ON s.Store = c.Store
LEFT JOIN tb_vendas_por_cliente v ON s.Store = v.Store;
