
-- ETL para gerar base de predição mais recente

SELECT 
    -- Identificadores principais
    t1.IdStore,
    t1.DtRef,
    
    -- Métricas de vendas (últimos períodos)
    t1.QtdSales7d,      t1.QtdSales14d,      t1.QtdSales28d,      t1.QtdSales42d,      t1.QtdSales56d,      t1.QtdSales84d,
    t1.AvgSales7d,      t1.AvgSales14d,      t1.AvgSales28d,      t1.AvgSales42d,      t1.AvgSales56d,      t1.AvgSales84d,
    t1.MinSales7d,      t1.MinSales14d,      t1.MinSales28d,      t1.MinSales42d,      t1.MinSales56d,      t1.MinSales84d,
    t1.MaxSales7d,      t1.MaxSales14d,      t1.MaxSales28d,      t1.MaxSales42d,      t1.MaxSales56d,      t1.MaxSales84d,

    -- Vendas em promoção
    t1.QtdSalesPromo7d,     t1.QtdSalesPromo14d,     t1.QtdSalesPromo28d,     t1.QtdSalesPromo42d,     t1.QtdSalesPromo56d,     t1.QtdSalesPromo84d,
    t1.AvgSalesPromo7d,     t1.AvgSalesPromo14d,     t1.AvgSalesPromo28d,     t1.AvgSalesPromo42d,     t1.AvgSalesPromo56d,     t1.AvgSalesPromo84d,
    t1.MinSalesPromo7d,     t1.MinSalesPromo14d,     t1.MinSalesPromo28d,     t1.MinSalesPromo42d,     t1.MinSalesPromo56d,     t1.MinSalesPromo84d,
    t1.MaxSalesPromo7d,     t1.MaxSalesPromo14d,     t1.MaxSalesPromo28d,     t1.MaxSalesPromo42d,     t1.MaxSalesPromo56d,     t1.MaxSalesPromo84d,

    -- Vendas sem promoção
    t1.QtdSalesNoPromo7d,   t1.QtdSalesNoPromo14d,   t1.QtdSalesNoPromo28d,   t1.QtdSalesNoPromo42d,   t1.QtdSalesNoPromo56d,   t1.QtdSalesNoPromo84d,
    t1.AvgSalesNoPromo7d,   t1.AvgSalesNoPromo14d,   t1.AvgSalesNoPromo28d,   t1.AvgSalesNoPromo42d,   t1.AvgSalesNoPromo56d,   t1.AvgSalesNoPromo84d,
    t1.MinSalesNoPromo7d,   t1.MinSalesNoPromo14d,   t1.MinSalesNoPromo28d,   t1.MinSalesNoPromo42d,   t1.MinSalesNoPromo56d,   t1.MinSalesNoPromo84d,
    t1.MaxSalesNoPromo7d,   t1.MaxSalesNoPromo14d,   t1.MaxSalesNoPromo28d,   t1.MaxSalesNoPromo42d,   t1.MaxSalesNoPromo56d,   t1.MaxSalesNoPromo84d,

    -- Crescimento/Métricas derivadas de vendas
    t1.Growth_AvgSales_7d_vs_28d,
    t1.Growth_AvgSales_14d_vs_28d,
    t1.Growth_AvgSales_28d_vs_56d,
    t1.Growth_AvgSales_42d_vs_84d,
    t1.LiftSalesPromo7d, t1.LiftSalesPromo14d, t1.LiftSalesPromo28d, t1.LiftSalesPromo42d, t1.LiftSalesPromo56d, t1.LiftSalesPromo84d,
    t1.SalesGrowth42dYearAgo,
    t1.SalesPerCustomer7d,      t1.SalesPerCustomer14d,      t1.SalesPerCustomer28d,      t1.SalesPerCustomer42d,      t1.SalesPerCustomer56d,      t1.SalesPerCustomer84d,
    t1.AvgSalesPerCustomer7d,   t1.AvgSalesPerCustomer14d,   t1.AvgSalesPerCustomer28d,   t1.AvgSalesPerCustomer42d,   t1.AvgSalesPerCustomer56d,   t1.AvgSalesPerCustomer84d,

    -- Métricas de clientes
    t2.QtdCustomers7d,      t2.QtdCustomers14d,      t2.QtdCustomers28d,      t2.QtdCustomers42d,      t2.QtdCustomers56d,      t2.QtdCustomers84d,
    t2.AvgCustomers7d,      t2.AvgCustomers14d,      t2.AvgCustomers28d,      t2.AvgCustomers42d,      t2.AvgCustomers56d,      t2.AvgCustomers84d,
    t2.MinCustomers7d,      t2.MinCustomers14d,      t2.MinCustomers28d,      t2.MinCustomers42d,      t2.MinCustomers56d,      t2.MinCustomers84d,
    t2.MaxCustomers7d,      t2.MaxCustomers14d,      t2.MaxCustomers28d,      t2.MaxCustomers42d,      t2.MaxCustomers56d,      t2.MaxCustomers84d,

    -- Clientes em promoção
    t2.QtdCustomersPromo7d,     t2.QtdCustomersPromo14d,     t2.QtdCustomersPromo28d,     t2.QtdCustomersPromo42d,     t2.QtdCustomersPromo56d,     t2.QtdCustomersPromo84d,
    t2.AvgCustomersPromo7d,     t2.AvgCustomersPromo14d,     t2.AvgCustomersPromo28d,     t2.AvgCustomersPromo42d,     t2.AvgCustomersPromo56d,     t2.AvgCustomersPromo84d,
    t2.MinCustomersPromo7d,     t2.MinCustomersPromo14d,     t2.MinCustomersPromo28d,     t2.MinCustomersPromo42d,     t2.MinCustomersPromo56d,     t2.MinCustomersPromo84d,
    t2.MaxCustomersPromo7d,     t2.MaxCustomersPromo14d,     t2.MaxCustomersPromo28d,     t2.MaxCustomersPromo42d,     t2.MaxCustomersPromo56d,     t2.MaxCustomersPromo84d,

    -- Clientes sem promoção
    t2.QtdCustomersNoPromo7d,   t2.QtdCustomersNoPromo14d,   t2.QtdCustomersNoPromo28d,   t2.QtdCustomersNoPromo42d,   t2.QtdCustomersNoPromo56d,   t2.QtdCustomersNoPromo84d,
    t2.AvgCustomersNoPromo7d,   t2.AvgCustomersNoPromo14d,   t2.AvgCustomersNoPromo28d,   t2.AvgCustomersNoPromo42d,   t2.AvgCustomersNoPromo56d,   t2.AvgCustomersNoPromo84d,
    t2.MinCustomersNoPromo7d,   t2.MinCustomersNoPromo14d,   t2.MinCustomersNoPromo28d,   t2.MinCustomersNoPromo42d,   t2.MinCustomersNoPromo56d,   t2.MinCustomersNoPromo84d,
    t2.MaxCustomersNoPromo7d,   t2.MaxCustomersNoPromo14d,   t2.MaxCustomersNoPromo28d,   t2.MaxCustomersNoPromo42d,   t2.MaxCustomersNoPromo56d,   t2.MaxCustomersNoPromo84d,

    -- Crescimento/Métricas derivadas de clientes
    t2.Growth_AvgCustomers_7d_vs_28d,
    t2.Growth_AvgCustomers_14d_vs_28d,
    t2.Growth_AvgCustomers_28d_vs_56d,
    t2.Growth_AvgCustomers_42d_vs_84d,

    -- Características da loja (constantes ou mudam pouco) 
    t3.CompetitionOpen,
    t3.Promo2Open,
    t3.StoreType,
    t3.Assortment,
    t3.CompetitionDistance,

    -- Calendário e indicadores temporais
    t4.DaysOpen7d,       t4.DaysOpen14d,       t4.DaysOpen28d,       t4.DaysOpen42d,       t4.DaysOpen56d,       t4.DaysOpen84d,
    t4.DaysClosed7d,     t4.DaysClosed14d,     t4.DaysClosed28d,     t4.DaysClosed42d,     t4.DaysClosed56d,     t4.DaysClosed84d,
    t4.DaysOpenRate7d,   t4.DaysOpenRate14d,   t4.DaysOpenRate28d,   t4.DaysOpenRate42d,   t4.DaysOpenRate56d,   t4.DaysOpenRate84d,
    t4.DaysPromo7d,      t4.DaysPromo14d,      t4.DaysPromo28d,      t4.DaysPromo42d,      t4.DaysPromo56d,      t4.DaysPromo84d,
    t4.DaysNoPromo7d,    t4.DaysNoPromo14d,    t4.DaysNoPromo28d,    t4.DaysNoPromo42d,    t4.DaysNoPromo56d,    t4.DaysNoPromo84d,
    t4.DaysPromoRate7d,  t4.DaysPromoRate14d,  t4.DaysPromoRate28d,  t4.DaysPromoRate42d,  t4.DaysPromoRate56d,  t4.DaysPromoRate84d,
    t4.DaysStateHoliday7d,    t4.DaysStateHoliday14d,    t4.DaysStateHoliday28d,    t4.DaysStateHoliday42d,    t4.DaysStateHoliday56d,    t4.DaysStateHoliday84d,
    t4.DaysStateHolidayRate7d, t4.DaysStateHolidayRate14d, t4.DaysStateHolidayRate28d, t4.DaysStateHolidayRate42d, t4.DaysStateHolidayRate56d, t4.DaysStateHolidayRate84d,
    t4.DaysSchoolHoliday7d,    t4.DaysSchoolHoliday14d,    t4.DaysSchoolHoliday28d,    t4.DaysSchoolHoliday42d,    t4.DaysSchoolHoliday56d,    t4.DaysSchoolHoliday84d,
    t4.DaysSchoolHolidayRate7d, t4.DaysSchoolHolidayRate14d, t4.DaysSchoolHolidayRate28d, t4.DaysSchoolHolidayRate42d, t4.DaysSchoolHolidayRate56d, t4.DaysSchoolHolidayRate84d,
    t4.MonthsSinceCompetition

FROM fs_vendas AS t1

LEFT JOIN fs_clientes  AS t2 ON t1.IdStore = t2.IdStore AND t1.DtRef = t2.DtRef
LEFT JOIN fs_loja      AS t3 ON t1.IdStore = t3.IdStore AND t1.DtRef = t3.DtRef
LEFT JOIN fs_temporal  AS t4 ON t1.IdStore = t4.IdStore AND t1.DtRef = t4.DtRef

-- Apenas dados mais recentes para todos os IdStore
WHERE t1.DtRef = (SELECT MAX(DtRef) FROM fs_vendas)