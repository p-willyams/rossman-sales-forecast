
WITH tb_comp_promo_date AS (
    SELECT 
        Store,  
        CASE 
            WHEN CompetitionOpenSinceYear IS NOT NULL AND CompetitionOpenSinceMonth IS NOT NULL 
            THEN printf('%04d-%02d', CompetitionOpenSinceYear , CompetitionOpenSinceMonth)
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

        Promo2SinceYear
    FROM store
),

tb_promo_comp AS (
    SELECT *,
        CASE 
                WHEN DateCompetition <= substr('{data_ref}',1,7) THEN 1
                WHEN DateCompetition > substr('{data_ref}',1,7) THEN 0
                ELSE NULL
        END AS CompetitionOpen,
        
        CASE 
                WHEN Promo2SinceYear IS NOT NULL
                AND Promo2FirstMonth IS NOT NULL
                AND (
                    CAST (strftime('%Y', '{data_ref}') AS INTEGER) > Promo2SinceYear 
                    OR (
                        CAST (strftime('%Y', '{data_ref}') AS INTEGER) = Promo2SinceYear 
                        AND CAST (strftime('%m', '{data_ref}') AS INTEGER) >= Promo2FirstMonth
                    )
                    )
                THEN 1
                WHEN Promo2SinceYear IS NOT NULL
                AND Promo2FirstMonth IS NOT NULL
                AND (
                    CAST (strftime('%Y', '{data_ref}') AS INTEGER) < Promo2SinceYear
                    OR (
                        CAST (strftime('%Y', '{data_ref}') AS INTEGER) = Promo2SinceYear 
                        AND CAST (strftime('%m', '{data_ref}') AS INTEGER) < Promo2FirstMonth
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
                    CAST(strftime('%Y', '{data_ref}') AS INTEGER) = Promo2SinceYear
                AND 
                    CAST(strftime('%m', '{data_ref}') AS INTEGER) >= Promo2FirstMonth
                AND 
                    CAST(strftime('%m', '{data_ref}') AS INTEGER) <= Promo2LastMonth
                THEN 1
                ELSE 0
        END AS Promo2Open,

        Promo2LastMonth - Promo2FirstMonth AS PromoInterval
    

    FROM tb_comp_promo_date AS t1

)

SELECT 
    '{data_ref}' AS DtRef,
    t1.Store AS IdStore,
    t1.CompetitionOpen,
    t1.Promo2Open,
    t2.StoreType,
    t2.Assortment,
    t2.CompetitionDistance

FROM tb_promo_comp AS t1

LEFT JOIN store AS t2
    ON t1.Store = t2.Store