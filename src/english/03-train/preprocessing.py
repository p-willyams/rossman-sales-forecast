import pandas as pd
from sklearn.base import BaseEstimator, TransformerMixin


class NullImputer(BaseEstimator, TransformerMixin):
    def __init__(self):
        # Variables for imputation
        self.lift_vars = [
            "LiftSalesPromo7d",
            "LiftSalesPromo14d",
            "LiftSalesPromo28d",
            "LiftSalesPromo42d",
            "LiftSalesPromo56d",
            "LiftSalesPromo84d",
            "MonthsSinceCompetition",
        ]

        # Promo or promo-customer-related features
        self.cols_promo = [
            "SalesGrowth42dYearAgo_missing",
            # Promo sales
            "QtdSalesPromo7d",
            "QtdSalesPromo14d",
            "QtdSalesPromo28d",
            "QtdSalesPromo42d",
            "QtdSalesPromo56d",
            "QtdSalesPromo84d",
            "AvgSalesPromo7d",
            "AvgSalesPromo14d",
            "AvgSalesPromo28d",
            "AvgSalesPromo42d",
            "AvgSalesPromo56d",
            "AvgSalesPromo84d",
            "MinSalesPromo7d",
            "MinSalesPromo14d",
            "MinSalesPromo28d",
            "MinSalesPromo42d",
            "MinSalesPromo56d",
            "MinSalesPromo84d",
            "MaxSalesPromo7d",
            "MaxSalesPromo14d",
            "MaxSalesPromo28d",
            "MaxSalesPromo42d",
            "MaxSalesPromo56d",
            "MaxSalesPromo84d",
            # Sales without promotion
            "QtdSalesNoPromo7d",
            "QtdSalesNoPromo14d",
            "QtdSalesNoPromo28d",
            "QtdSalesNoPromo42d",
            "QtdSalesNoPromo56d",
            "QtdSalesNoPromo84d",
            "AvgSalesNoPromo7d",
            "AvgSalesNoPromo14d",
            "AvgSalesNoPromo28d",
            "AvgSalesNoPromo42d",
            "AvgSalesNoPromo56d",
            "AvgSalesNoPromo84d",
            "MinSalesNoPromo7d",
            "MinSalesNoPromo14d",
            "MinSalesNoPromo28d",
            "MinSalesNoPromo42d",
            "MinSalesNoPromo56d",
            "MinSalesNoPromo84d",
            "MaxSalesNoPromo7d",
            "MaxSalesNoPromo14d",
            "MaxSalesNoPromo28d",
            "MaxSalesNoPromo42d",
            "MaxSalesNoPromo56d",
            "MaxSalesNoPromo84d",
            # Promo customers
            "QtdCustomersPromo7d",
            "QtdCustomersPromo14d",
            "QtdCustomersPromo28d",
            "QtdCustomersPromo42d",
            "QtdCustomersPromo56d",
            "QtdCustomersPromo84d",
            "AvgCustomersPromo7d",
            "AvgCustomersPromo14d",
            "AvgCustomersPromo28d",
            "AvgCustomersPromo42d",
            "AvgCustomersPromo56d",
            "AvgCustomersPromo84d",
            "MinCustomersPromo7d",
            "MinCustomersPromo14d",
            "MinCustomersPromo28d",
            "MinCustomersPromo42d",
            "MinCustomersPromo56d",
            "MinCustomersPromo84d",
            "MaxCustomersPromo7d",
            "MaxCustomersPromo14d",
            "MaxCustomersPromo28d",
            "MaxCustomersPromo42d",
            "MaxCustomersPromo56d",
            "MaxCustomersPromo84d",
            # Customers without promotion
            "QtdCustomersNoPromo7d",
            "QtdCustomersNoPromo14d",
            "QtdCustomersNoPromo28d",
            "QtdCustomersNoPromo42d",
            "QtdCustomersNoPromo56d",
            "QtdCustomersNoPromo84d",
            "AvgCustomersNoPromo7d",
            "AvgCustomersNoPromo14d",
            "AvgCustomersNoPromo28d",
            "AvgCustomersNoPromo42d",
            "AvgCustomersNoPromo56d",
            "AvgCustomersNoPromo84d",
            "MinCustomersNoPromo7d",
            "MinCustomersNoPromo14d",
            "MinCustomersNoPromo28d",
            "MinCustomersNoPromo42d",
            "MinCustomersNoPromo56d",
            "MinCustomersNoPromo84d",
            "MaxCustomersNoPromo7d",
            "MaxCustomersNoPromo14d",
            "MaxCustomersNoPromo28d",
            "MaxCustomersNoPromo42d",
            "MaxCustomersNoPromo56d",
            "MaxCustomersNoPromo84d",
            # Other promo related
            "Promo2Open",
            "DaysPromo7d",
            "DaysPromo14d",
            "DaysPromo28d",
            "DaysPromo42d",
            "DaysPromo56d",
            "DaysPromo84d",
            "DaysNoPromo7d",
            "DaysNoPromo14d",
            "DaysNoPromo28d",
            "DaysNoPromo42d",
            "DaysNoPromo56d",
            "DaysNoPromo84d",
            "DaysPromoRate7d",
            "DaysPromoRate14d",
            "DaysPromoRate28d",
            "DaysPromoRate42d",
            "DaysPromoRate56d",
            "DaysPromoRate84d",
        ]

        # General sales and customer features
        self.cols_sales_customers = [
            "QtdSales7d",
            "QtdSales14d",
            "AvgSales7d",
            "AvgSales14d",
            "AvgSales28d",
            "AvgSales42d",
            "AvgSales56d",
            "AvgSales84d",
            "MinSales7d",
            "MinSales14d",
            "MinSales28d",
            "MinSales42d",
            "MinSales56d",
            "MinSales84d",
            "MaxSales7d",
            "MaxSales14d",
            "MaxSales28d",
            "MaxSales42d",
            "MaxSales56d",
            "MaxSales84d",
            "Growth_AvgSales_7d_vs_28d",
            "Growth_AvgSales_14d_vs_28d",
            "Growth_AvgSales_28d_vs_56d",
            "Growth_AvgSales_42d_vs_84d",
            "SalesGrowth42dYearAgo",
            "SalesPerCustomer7d",
            "SalesPerCustomer14d",
            "SalesPerCustomer28d",
            "SalesPerCustomer42d",
            "SalesPerCustomer56d",
            "SalesPerCustomer84d",
            "AvgSalesPerCustomer7d",
            "AvgSalesPerCustomer14d",
            "AvgSalesPerCustomer28d",
            "AvgSalesPerCustomer42d",
            "AvgSalesPerCustomer56d",
            "AvgSalesPerCustomer84d",
            "QtdCustomers7d",
            "QtdCustomers14d",
            "AvgCustomers7d",
            "AvgCustomers14d",
            "AvgCustomers28d",
            "AvgCustomers42d",
            "AvgCustomers56d",
            "AvgCustomers84d",
            "MinCustomers7d",
            "MinCustomers14d",
            "MinCustomers28d",
            "MinCustomers42d",
            "MinCustomers56d",
            "MinCustomers84d",
            "MaxCustomers7d",
            "MaxCustomers14d",
            "Growth_AvgCustomers_7d_vs_28d",
            "Growth_AvgCustomers_14d_vs_28d",
            "Growth_AvgCustomers_28d_vs_56d",
            "Growth_AvgCustomers_42d_vs_84d",
        ]

    def fit(self, X, y=None):
        # Save the median for CompetitionDistance
        self.competition_distance_median_ = X["CompetitionDistance"].median()
        return self

    def transform(self, X):
        X = X.copy()

        # Missing flags for main columns
        X["SalesGrowth42dYearAgo_missing"] = (
            X["SalesGrowth42dYearAgo"].isna().astype(int)
        )
        X["CompetitionOpen_missing"] = X["CompetitionOpen"].isna().astype(int)
        X["CompetitionDistance_missing"] = X["CompetitionDistance"].isna().astype(int)

        # Special rule: CompetitionOpen depends on CompetitionDistance
        def comp_open(row):
            if not pd.isna(row["CompetitionDistance"]):
                return 1
            if pd.isna(row["CompetitionOpen"]):
                return 0
            return row["CompetitionOpen"]

        X["CompetitionOpen"] = X.apply(comp_open, axis=1)
        X["CompetitionDistance"] = X["CompetitionDistance"].fillna(
            self.competition_distance_median_
        )

        # Impute -1 and create missing flags for lift_vars
        for col in self.lift_vars:
            X[f"{col}_missing"] = X[col].isna().astype(int)
            X[col] = X[col].fillna(-1)

        # Impute 0 for promo and general sales/customer features
        for col in self.cols_promo:
            if col in X.columns:
                X[col] = X[col].fillna(0)
        for col in self.cols_sales_customers:
            if col in X.columns:
                X[col] = X[col].fillna(0)

        return X
