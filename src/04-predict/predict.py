import os
import sys
import pandas as pd
import sqlalchemy

# Garante import do módulo de pré-processamento
sys.path.append(os.path.abspath("src/03-train"))
from preprocessing import NullImputer

# Carrega modelo treinado e features
model_series = pd.read_pickle("models/xgb_store_forecast")

# Conexão com a base de dados
db_engine = sqlalchemy.create_engine("sqlite:///data/feature_store.db")

# Lê a base analítica (ABT)
with open("src/03-train/abt.sql", "r") as f:
    abt_query = f.read()
df = pd.read_sql(abt_query, db_engine)

# Faz as previsões
X_pred = df[model_series["features"]]
pred = model_series["model"].predict(X_pred)

# Monta o DataFrame de resultados (IdStore, DtRef, prediction)
df_pred = pd.DataFrame(
    {"IdStore": df["IdStore"], "DtRef": df["DtRef"], "prediction": pred}
)

# Atualiza a tabela de previsões: limpa datas antigas e insere novas
dtrefs = df_pred["DtRef"].unique()
dtrefs_str = "', '".join(dtrefs.astype(str))
with db_engine.connect() as con:
    delete_sql = f"DELETE FROM tb_sales WHERE DtRef IN ('{dtrefs_str}');"
    try:
        con.execute(sqlalchemy.text(delete_sql))
        con.commit()
    except Exception as e:
        # Cria a tabela se não existir
        if "no such table" not in str(e):
            raise

df_pred.to_sql("tb_sales", db_engine, index=False, if_exists="append")
