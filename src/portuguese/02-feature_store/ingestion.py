"""
Script para ingestão de dados em feature_store.db por intervalo de datas.

Exemplo de uso:
    python ingestion.py --table clientes --start_date 2013-03-26 --end_date 2015-07-31

A query SQL esperada deve estar em um arquivo chamado fs_{table}.sql neste diretório.
"""

import sqlalchemy
import pandas as pd
import datetime
from tqdm import tqdm
import argparse


def import_query(path):
    with open(path, "r") as f:
        return f.read()


def ingest_table(table_name: str, data_ref: str, query: str):
    # Remove dados existentes para a data antes do insert
    query_fmt = query.format(data_ref=data_ref)
    with TARGET.connect() as con:
        state = f"DELETE FROM fs_{table_name} WHERE DtRef = '{data_ref}';"
        try:
            con.execute(sqlalchemy.text(state))
            con.commit()
        except Exception as e:
            if "no such table" not in str(e):
                raise
    df = pd.read_sql(query_fmt, ORIGIN)
    df.to_sql(f"fs_{table_name}", TARGET, index=False, if_exists="append")


def date_range(start, stop):
    dt_start = datetime.datetime.strptime(start, "%Y-%m-%d")
    dt_stop = datetime.datetime.strptime(stop, "%Y-%m-%d")
    dates = []
    while dt_start <= dt_stop:
        dates.append(dt_start.strftime("%Y-%m-%d"))
        dt_start += datetime.timedelta(days=1)
    return dates


# Engines de conexão com os bancos
ORIGIN = sqlalchemy.create_engine("sqlite:///../../../data/database.db")
TARGET = sqlalchemy.create_engine("sqlite:///../../../data/feature_store.db")

# Argumentos de linha de comando
parser = argparse.ArgumentParser(description="Ingest features into the feature store.")
parser.add_argument(
    "--table",
    type=str,
    required=True,
    help="Table name (without fs_ prefix); expects the .sql file as 'fs_{table}.sql' in this directory.",
)
parser.add_argument(
    "--start_date", type=str, required=True, help="Start date in YYYY-MM-DD format."
)
parser.add_argument(
    "--end_date", type=str, required=True, help="End date in YYYY-MM-DD format."
)
args = parser.parse_args()

table_name = args.table
sql_path = f"fs_{table_name}.sql"
query = import_query(sql_path)
dates = date_range(args.start_date, args.end_date)

# Loop de ingestão (um dia por vez)
for date in tqdm(dates):
    ingest_table(table_name, date, query)
