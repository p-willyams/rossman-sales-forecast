import pandas as pd
import sqlalchemy
from sklearn.preprocessing import OneHotEncoder, MinMaxScaler
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from xgboost import XGBRegressor
from preprocessing import NullImputer


def is_nonbinary_numeric(col, X, categorical_cols):
    # Verifica se coluna é numérica não binária (e não categórica/nem target)
    if col in categorical_cols or col == "Target":
        return False
    unique_vals = X[col].nunique(dropna=True)
    if unique_vals <= 2:
        return False
    return pd.api.types.is_numeric_dtype(X[col])


# Conexão com banco e leitura da ABT (Analytical Base Table)
engine = sqlalchemy.create_engine("sqlite:///data/feature_store.db")
with open("src/03-train/abt.sql", "r") as f:
    abt_query = f.read()
df = pd.read_sql(abt_query, engine)
df = df[df["Target"].notnull()].copy()

# Divide features e target
X = df.drop(columns=["Target", "DtRef", "IdStore"])
y = df["Target"]

# Preprocessamento: define colunas categóricas/numéricas
categorical_cols = ["StoreType", "Assortment"]
encoder = OneHotEncoder(handle_unknown="ignore", dtype="float32", sparse_output=False)
numerical_cols = [
    col for col in X.columns if is_nonbinary_numeric(col, X, categorical_cols)
]
scaler = MinMaxScaler()

# Pipeline de pré-processamento
preprocessing_pipeline = Pipeline(
    [
        ("null_imputer", NullImputer()),
        (
            "encoder_scaler",
            ColumnTransformer(
                transformers=[
                    ("cat", encoder, categorical_cols),
                    ("num", scaler, numerical_cols),
                ],
                remainder="passthrough",
                verbose_feature_names_out=False,
            ),
        ),
    ]
)

# Pipeline final: pré-processamento + modelo XGBoost
final_pipeline_xgb = Pipeline(
    [
        ("preprocessing", preprocessing_pipeline),
        (
            "xgb_model",
            XGBRegressor(
                objective="reg:squarederror",
                random_state=42,
                n_estimators=447,
                max_depth=9,
                learning_rate=0.011420504743763044,
                min_child_weight=10,
                subsample=0.6566906422104706,
                colsample_bytree=0.6170218535567256,
                gamma=4.634144245790077,
                reg_alpha=4.502658128066885,
                reg_lambda=0.004280189699689387,
            ),
        ),
    ]
)

# Treina e salva o modelo
final_pipeline_xgb.fit(X, y)
model_series = pd.Series(
    {
        "model": final_pipeline_xgb,
        "features": list(X.columns),
    }
)
model_series.to_pickle("models/xgb_store_forecast")
