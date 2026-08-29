WITH tb_base_ativa AS (
    SELECT * 
    FROM sales
    WHERE Date < '{data_ref}'
    AND Date >= DATE('{data_ref}', '-84 Day')
),

tb_comp_promo_date AS (
    SELECT 
        t1.Date,
        t1.Store,  
        CASE 
            WHEN t2.CompetitionOpenSinceYear IS NOT NULL OR t2.CompetitionOpenSinceMonth IS NOT NULL 
            THEN printf('%04d-%02d', t2.CompetitionOpenSinceYear , t2.CompetitionOpenSinceMonth)
            ELSE NULL
        END AS DateCompetition, 
        CASE 
            WHEN substr(PromoInterval, 1, 3) = 'Jan' THEN 1
            WHEN substr(PromoInterval, 1, 3) = 'Feb' THEN 2
            WHEN substr(PromoInterval, 1, 3) = 'Mar' THEN 3
            WHEN substr(PromoInterval, 1, 3) = 'Apr' THEN 4
            WHEN substr(PromoInterval, 1, 3) = 'May' THEN 5
            WHEN substr(PromoInterval, 1, 3) = 'Jun' THEN 6
            WHEN substr(PromoInterval, 1, 3) = 'Jul' THEN 7
            WHEN substr(PromoInterval, 1, 3) = 'Aug' THEN 8
            WHEN substr(PromoInterval, 1, 3) = 'Sep' THEN 9
            WHEN substr(PromoInterval, 1, 3) = 'Oct' THEN 10
            WHEN substr(PromoInterval, 1, 3) = 'Nov' THEN 11
            WHEN substr(PromoInterval, 1, 3) = 'Dec' THEN 12
            ELSE NULL
        END AS Promo2FirstMonth,
        CASE 
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Jan' THEN 1
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Feb' THEN 2
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Mar' THEN 3
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Apr' THEN 4
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'May' THEN 5
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Jun' THEN 6
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Jul' THEN 7
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Aug' THEN 8
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Sep' THEN 9
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Oct' THEN 10
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Nov' THEN 11
            WHEN substr(PromoInterval, length(PromoInterval) - 2, 3) = 'Dec' THEN 12
            ELSE NULL
        END AS Promo2LastMonth,
        t2.Promo2SinceYear
    FROM tb_base_ativa AS t1
    LEFT JOIN store AS t2
        ON t1.Store = t2.Store 
),

tb_promo_comp AS (
    SELECT *,
        CASE 
                WHEN DateCompetition <= substr(t1.Date,1,7) THEN 1
                WHEN DateCompetition > substr(t1.Date,1,7) THEN 0
                ELSE NULL
        END AS CompetitionOpen,
        
        CASE 
                WHEN Promo2SinceYear IS NOT NULL
                AND Promo2FirstMonth IS NOT NULL
                AND (
                    CAST (strftime('%Y', t1.Date) AS INTEGER) > Promo2SinceYear 
                    OR (
                        CAST (strftime('%Y', t1.Date) AS INTEGER) = Promo2SinceYear 
                        AND CAST (strftime('%m', t1.Date) AS INTEGER) >= Promo2FirstMonth
                    )
                    )
                THEN 1
                WHEN Promo2SinceYear IS NOT NULL
                AND Promo2FirstMonth IS NOT NULL
                AND (
                    CAST (strftime('%Y', t1.Date) AS INTEGER) < Promo2SinceYear
                    OR (
                        CAST (strftime('%Y', t1.Date) AS INTEGER) = Promo2SinceYear 
                        AND CAST (strftime('%m', t1.Date) AS INTEGER) < Promo2FirstMonth
                    )
                )
                THEN 0
                ELSE NULL
        END AS Promo2FirstOpen,

        CASE 
                WHEN Promo2SinceYear IS NOT NULL
                AND Promo2FirstMonth IS NOT NULL
                AND Promo2LastMonth IS NOT NULL
                AND 
                    CAST(strftime('%Y', t1.Date) AS INTEGER) = Promo2SinceYear
                AND 
                    CAST(strftime('%m', t1.Date) AS INTEGER) >= Promo2FirstMonth
                AND 
                    CAST(strftime('%m', t1.Date) AS INTEGER) <= Promo2LastMonth
                THEN 1
                ELSE 0
        END AS Promo2Open,

        Promo2LastMonth - Promo2FirstMonth AS PromoInterval
    

    FROM tb_comp_promo_date AS t1

)

SELECT 
    Date AS DtRef,
    Store AS IdStore,
    DateCompetition,
    Promo2FirstMonth,
    Promo2LastMonth,
    Promo2SinceYear,
    CompetitionOpen,
    Promo2Open,
    t3.StoreType,
    t3.Assortment,
    t3.CompetitionDistance
       
FROM tb_promo_comp AS t2

LEFT JOIN Store AS t3
    ON t2.Store = t3.Store;