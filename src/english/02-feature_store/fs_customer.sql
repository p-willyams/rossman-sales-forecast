
WITH tb_base_ativa AS (

    SELECT *
    FROM sales
    WHERE Date < '{data_ref}'
      AND Date >= DATE('{data_ref}', '-84 Day')

),

tb_customers_qtd AS (
    
    SELECT 
            t1.Store,

            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') THEN t1.Customers END) AS  QtdCustomers7d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') THEN t1.Customers END) AS QtdCustomers14d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') THEN t1.Customers END) AS QtdCustomers28d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') THEN t1.Customers END) AS QtdCustomers42d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') THEN t1.Customers END) AS QtdCustomers56d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') THEN t1.Customers END) AS QtdCustomers84d,

            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 1 THEN t1.Customers END) AS  AvgCustomers7d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomers14d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomers28d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomers42d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomers56d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomers84d,

            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 1 THEN t1.Customers END) AS MinCustomers7d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 1 THEN t1.Customers END) AS MinCustomers14d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 1 THEN t1.Customers END) AS MinCustomers28d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 1 THEN t1.Customers END) AS MinCustomers42d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 1 THEN t1.Customers END) AS MinCustomers56d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 1 THEN t1.Customers END) AS MinCustomers84d,
    

            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') THEN t1.Customers END) AS  MaxCustomers7d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') THEN t1.Customers END) AS MaxCustomers14d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') THEN t1.Customers END) AS MaxCustomers28d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') THEN t1.Customers END) AS MaxCustomers42d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') THEN t1.Customers END) AS MaxCustomers56d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') THEN t1.Customers END) AS MaxCustomers84d,



            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 THEN t1.Customers END) AS  QtdCustomersPromo7d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 THEN t1.Customers END) AS QtdCustomersPromo14d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 THEN t1.Customers END) AS QtdCustomersPromo28d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 THEN t1.Customers END) AS QtdCustomersPromo42d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 THEN t1.Customers END) AS QtdCustomersPromo56d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 THEN t1.Customers END) AS QtdCustomersPromo84d,

            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS  AvgCustomersPromo7d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersPromo14d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersPromo28d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersPromo42d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersPromo56d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersPromo84d,

            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersPromo7d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersPromo14d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersPromo28d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersPromo42d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersPromo56d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersPromo84d,
    

            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 THEN t1.Customers END) AS  MaxCustomersPromo7d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 THEN t1.Customers END) AS MaxCustomersPromo14d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 THEN t1.Customers END) AS MaxCustomersPromo28d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 THEN t1.Customers END) AS MaxCustomersPromo42d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 THEN t1.Customers END) AS MaxCustomersPromo56d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 THEN t1.Customers END) AS MaxCustomersPromo84d,


            
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 THEN t1.Customers END) AS  QtdCustomersNoPromo7d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 THEN t1.Customers END) AS QtdCustomersNoPromo14d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 THEN t1.Customers END) AS QtdCustomersNoPromo28d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 THEN t1.Customers END) AS QtdCustomersNoPromo42d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 THEN t1.Customers END) AS QtdCustomersNoPromo56d,
            SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 THEN t1.Customers END) AS QtdCustomersNoPromo84d,

            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS  AvgCustomersNoPromo7d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersNoPromo14d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersNoPromo28d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersNoPromo42d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersNoPromo56d,
            AVG(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS AvgCustomersNoPromo84d,

            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS  MinCustomersNoPromo7d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersNoPromo14d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersNoPromo28d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersNoPromo42d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersNoPromo56d,
            MIN(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 AND t1.Open = 1 THEN t1.Customers END) AS MinCustomersNoPromo84d,
    

            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 THEN t1.Customers END) AS  MaxCustomersNoPromo7d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 THEN t1.Customers END) AS MaxCustomersNoPromo14d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 THEN t1.Customers END) AS MaxCustomersNoPromo28d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 THEN t1.Customers END) AS MaxCustomersNoPromo42d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 THEN t1.Customers END) AS MaxCustomersNoPromo56d,
            MAX(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 THEN t1.Customers END) AS MaxCustomersNoPromo84d

    FROM tb_base_ativa AS t1
    GROUP BY t1.Store

)
    
SELECT
       '{data_ref}' AS DtRef,
       
       Store AS IdStore, 

       QtdCustomers7d,
       QtdCustomers14d,
       QtdCustomers28d,
       QtdCustomers42d,
       QtdCustomers56d,
       QtdCustomers84d,
       
       AvgCustomers7d,
       AvgCustomers14d,
       AvgCustomers28d,
       AvgCustomers42d,
       AvgCustomers56d,
       AvgCustomers84d,

       MinCustomers7d,
       MinCustomers14d,
       MinCustomers28d,
       MinCustomers42d,
       MinCustomers56d,
       MinCustomers84d,

       MaxCustomers7d,
       MaxCustomers14d,
       MaxCustomers28d,
       MaxCustomers42d,
       MaxCustomers56d,
       MaxCustomers84d,

       QtdCustomersPromo7d,
       QtdCustomersPromo14d,
       QtdCustomersPromo28d,
       QtdCustomersPromo42d,
       QtdCustomersPromo56d,
       QtdCustomersPromo84d,

       AvgCustomersPromo7d,
       AvgCustomersPromo14d,
       AvgCustomersPromo28d,
       AvgCustomersPromo42d,
       AvgCustomersPromo56d,
       AvgCustomersPromo84d,

       MinCustomersPromo7d,
       MinCustomersPromo14d,
       MinCustomersPromo28d,
       MinCustomersPromo42d,
       MinCustomersPromo56d,
       MinCustomersPromo84d,
    
       MaxCustomersPromo7d,
       MaxCustomersPromo14d,
       MaxCustomersPromo28d,
       MaxCustomersPromo42d,
       MaxCustomersPromo56d,
       MaxCustomersPromo84d,
            
       QtdCustomersNoPromo7d,
       QtdCustomersNoPromo14d,
       QtdCustomersNoPromo28d,
       QtdCustomersNoPromo42d,
       QtdCustomersNoPromo56d,
       QtdCustomersNoPromo84d,

       AvgCustomersNoPromo7d,
       AvgCustomersNoPromo14d,
       AvgCustomersNoPromo28d,
       AvgCustomersNoPromo42d,
       AvgCustomersNoPromo56d,
       AvgCustomersNoPromo84d,

       MinCustomersNoPromo7d,
       MinCustomersNoPromo14d,
       MinCustomersNoPromo28d,
       MinCustomersNoPromo42d,
       MinCustomersNoPromo56d,
       MinCustomersNoPromo84d,
    
       MaxCustomersNoPromo7d,
       MaxCustomersNoPromo14d,
       MaxCustomersNoPromo28d,
       MaxCustomersNoPromo42d,
       MaxCustomersNoPromo56d,
       MaxCustomersNoPromo84d,

       (AvgCustomers7d - AvgCustomers28d)  / NULLIF(AvgCustomers28d,0)  AS Growth_AvgCustomers_7d_vs_28d,
       (AvgCustomers14d - AvgCustomers28d) / NULLIF(AvgCustomers28d,0)  AS Growth_AvgCustomers_14d_vs_28d,
       (AvgCustomers28d - AvgCustomers56d) / NULLIF(AvgCustomers56d,0)  AS Growth_AvgCustomers_28d_vs_56d,
       (AvgCustomers42d - AvgCustomers84d) / NULLIF(AvgCustomers84d,0)  AS Growth_AvgCustomers_42d_vs_84d

FROM tb_customers_qtd
