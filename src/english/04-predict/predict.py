import os
import sys
import pandas as pd
import sqlalchemy

# Ensure import of the preprocessing module
sys.path.append(os.path.abspath("src/03-train"))
from preprocessing import NullImputer

# Load trained model and feature list
model_series = pd.read_pickle("models/xgb_store_forecast")

# Connect to the database
db_engine = sqlalchemy.create_engine("sqlite:///../../../data/feature_store.db")

# Read the analytical base table (ABT)
with open("src/03-train/abt.sql", "r") as f:
    abt_query = f.read()
df = pd.read_sql(abt_query, db_engine)

# Make predictions
X_pred = df[model_series["features"]]
pred = model_series["model"].predict(X_pred)

# Build the results DataFrame (IdStore, DtRef, prediction)
df_pred = pd.DataFrame(
    {"IdStore": df["IdStore"], "DtRef": df["DtRef"], "prediction": pred}
)

# Update the predictions table: clear old dates and insert new ones
dtrefs = df_pred["DtRef"].unique()
dtrefs_str = "', '".join(dtrefs.astype(str))
with db_engine.connect() as con:
    delete_sql = f"DELETE FROM tb_sales WHERE DtRef IN ('{dtrefs_str}');"
    try:
        con.execute(sqlalchemy.text(delete_sql))
        con.commit()
    except Exception as e:
        # Create the table if it does not exist
        if "no such table" not in str(e):
            raise

df_pred.to_sql("tb_sales", db_engine, index=False, if_exists="append")
