WITH tb_base_ativa AS (

    SELECT *
    FROM sales
    WHERE Date < '{data_ref}'
      AND Date >= DATE('{data_ref}', '-84 Day')

),

tb_daily_events AS (

    SELECT 

        t1.Store,


        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) AS DaysOpen7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) AS DaysOpen14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) AS DaysOpen28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) AS DaysOpen42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) AS DaysOpen56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) AS DaysOpen84d,


        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 0 THEN 1 ELSE 0 END) AS DaysClosed7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 0 THEN 1 ELSE 0 END) AS DaysClosed14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 0 THEN 1 ELSE 0 END) AS DaysClosed28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 0 THEN 1 ELSE 0 END) AS DaysClosed42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 0 THEN 1 ELSE 0 END) AS DaysClosed56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 0 THEN 1 ELSE 0 END) AS DaysClosed84d,

        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) / 7 AS DaysOpenRate7d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) / 14 AS DaysOpenRate14d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) / 28 AS DaysOpenRate28d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) / 42 AS DaysOpenRate42d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) / 56 AS DaysOpenRate56d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Open = 1 THEN 1 ELSE 0 END) / 84 AS DaysOpenRate84d,


        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) AS DaysPromo7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) AS DaysPromo14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) AS DaysPromo28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) AS DaysPromo42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) AS DaysPromo56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) AS DaysPromo84d,

        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 0 THEN 1 ELSE 0 END) AS DaysNoPromo7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 0 THEN 1 ELSE 0 END) AS DaysNoPromo14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 0 THEN 1 ELSE 0 END) AS DaysNoPromo28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 0 THEN 1 ELSE 0 END) AS DaysNoPromo42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 0 THEN 1 ELSE 0 END) AS DaysNoPromo56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 0 THEN 1 ELSE 0 END) AS DaysNoPromo84d,


        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) / 7 AS DaysPromoRate7d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) / 14 AS DaysPromoRate14d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) / 28 AS DaysPromoRate28d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) / 42 AS DaysPromoRate42d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) / 56 AS DaysPromoRate56d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.Promo = 1 THEN 1 ELSE 0 END) / 84 AS DaysPromoRate84d,

        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) AS DaysStateHoliday7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) AS DaysStateHoliday14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) AS DaysStateHoliday28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) AS DaysStateHoliday42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) AS DaysStateHoliday56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) AS DaysStateHoliday84d,


        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) / 7 AS DaysStateHolidayRate7d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) / 14 AS DaysStateHolidayRate14d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) / 28 AS DaysStateHolidayRate28d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) / 42 AS DaysStateHolidayRate42d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) / 56 AS DaysStateHolidayRate56d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.StateHoliday = 1 THEN 1 ELSE 0 END) / 84 AS DaysStateHolidayRate84d,


        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) AS DaysSchoolHoliday7d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) AS DaysSchoolHoliday14d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) AS DaysSchoolHoliday28d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) AS DaysSchoolHoliday42d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) AS DaysSchoolHoliday56d,
        SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) AS DaysSchoolHoliday84d,


        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-7 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) / 7 AS DaysSchoolHolidayRate7d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-14 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) / 14 AS DaysSchoolHolidayRate14d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-28 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) / 28 AS DaysSchoolHolidayRate28d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-42 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) / 42 AS DaysSchoolHolidayRate42d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-56 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) / 56 AS DaysSchoolHolidayRate56d,
        1.0 * SUM(CASE WHEN t1.Date >= DATE('{data_ref}', '-84 Day') AND t1.SchoolHoliday = 1 THEN 1 ELSE 0 END) / 84 AS DaysSchoolHolidayRate84d

    FROM tb_base_ativa AS t1
    GROUP BY t1.Store
)

SELECT 

    t1.Store AS IdStore,

    '{data_ref}' AS DtRef,

    t2.DaysOpen7d,
    t2.DaysOpen14d,
    t2.DaysOpen28d,
    t2.DaysOpen42d,
    t2.DaysOpen56d,
    t2.DaysOpen84d,

    t2.DaysClosed7d,
    t2.DaysClosed14d,
    t2.DaysClosed28d,
    t2.DaysClosed42d,
    t2.DaysClosed56d,
    t2.DaysClosed84d,

    t2.DaysOpenRate7d,
    t2.DaysOpenRate14d,
    t2.DaysOpenRate28d,
    t2.DaysOpenRate42d,
    t2.DaysOpenRate56d,
    t2.DaysOpenRate84d,

    t2.DaysPromo7d,
    t2.DaysPromo14d,
    t2.DaysPromo28d,
    t2.DaysPromo42d,
    t2.DaysPromo56d,
    t2.DaysPromo84d,

    t2.DaysNoPromo7d,
    t2.DaysNoPromo14d,
    t2.DaysNoPromo28d,
    t2.DaysNoPromo42d,
    t2.DaysNoPromo56d,
    t2.DaysNoPromo84d,

    t2.DaysPromoRate7d,
    t2.DaysPromoRate14d,
    t2.DaysPromoRate28d,
    t2.DaysPromoRate42d,
    t2.DaysPromoRate56d,
    t2.DaysPromoRate84d,

    t2.DaysStateHoliday7d,
    t2.DaysStateHoliday14d,
    t2.DaysStateHoliday28d,
    t2.DaysStateHoliday42d,
    t2.DaysStateHoliday56d,
    t2.DaysStateHoliday84d,

    t2.DaysStateHolidayRate7d,
    t2.DaysStateHolidayRate14d,
    t2.DaysStateHolidayRate28d,
    t2.DaysStateHolidayRate42d,
    t2.DaysStateHolidayRate56d,
    t2.DaysStateHolidayRate84d,

    t2.DaysSchoolHoliday7d,
    t2.DaysSchoolHoliday14d,
    t2.DaysSchoolHoliday28d,
    t2.DaysSchoolHoliday42d,
    t2.DaysSchoolHoliday56d,
    t2.DaysSchoolHoliday84d,

    t2.DaysSchoolHolidayRate7d,
    t2.DaysSchoolHolidayRate14d,
    t2.DaysSchoolHolidayRate28d,
    t2.DaysSchoolHolidayRate42d,
    t2.DaysSchoolHolidayRate56d,
    t2.DaysSchoolHolidayRate84d,

    CASE             
        WHEN t1.CompetitionOpenSinceYear IS NOT NULL 
            AND t1.CompetitionOpenSinceMonth IS NOT NULL 
                THEN ((CAST(strftime('%Y', '{data_ref}') AS INTEGER) - t1.CompetitionOpenSinceYear) * 12) + (CAST(strftime('%m', '{data_ref}') AS INTEGER) - t1.CompetitionOpenSinceMonth) 
        ELSE NULL         
    END AS MonthsSinceCompetition
FROM store t1

LEFT JOIN tb_daily_events t2
    ON t1.Store = t2.Store;