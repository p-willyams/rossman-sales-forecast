"""
Para este projeto, será utilizado o seguinte range de datas:

Data inicial:  26/03/2013

Data final: 19/06/2015

Como fazer a ingestão dos dados no banco:

Execute este script fornecendo os argumentos obrigatórios para a tabela e datas desejadas.
O script irá ler a query SQL referente à tabela, executar para cada dia no intervalo fornecido,
e inserir o resultado no banco feature_store.db.

Exemplo de uso:
    python ingestion.py --table vendas --start_date 2015-07-15 --end_date 2015-07-20

A query SQL para a tabela esperada deve estar em um arquivo chamado fs_{table}.sql na pasta deste script.
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


ORIGIN = sqlalchemy.create_engine("sqlite:///../../data/database.db")
TARGET = sqlalchemy.create_engine("sqlite:///../../data/feature_store.db")


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

for date in tqdm(dates):
    ingest_table(table_name, date, query)
