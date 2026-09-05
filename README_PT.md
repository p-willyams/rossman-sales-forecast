> :information_source: Para a versão em inglês deste README, veja o arquivo **README.md**.

## Visão Geral do Projeto

Um **modelo de machine learning para previsão de vendas no varejo** que estima o **valor total de vendas para os próximos 42 dias (seis semanas)** de cada loja de uma rede de farmácias, alcançando um **R² de 0.9461** e um **MAPE de 5.20%** no período de teste Out-of-Time (OOT).

### Destaques

- **R²: 0.9461** | **MAPE: 5.20%** no conjunto OOT, forte poder preditivo e consistência ao longo do tempo
- **MAE: R$ 12.895,76** e **RMSE: R$ 20.822,40** no OOT
- **240 features** construídas a partir de histórico de vendas, clientes, promoções, feriados e características das lojas
- **XGBoost** selecionado após comparação com 4 algoritmos de regressão, ajustado com **Optuna (50 trials)**
- Feature Store organizada por **loja e data de referência**, construída com **SQL + Python**

---



## Problema de Negócio

**Estimar as vendas futuras de cada loja** para apoiar decisões estratégicas relacionadas a investimentos, expansão de lojas, reformas e campanhas de marketing.

**Target:** Total de vendas acumuladas nos **42 dias seguintes à data de referência**.

**Saída:** Valor de vendas previsto para cada loja nas próximas seis semanas.

---



## Dados & Infraestrutura

O projeto combina duas fontes principais de dados, armazenadas em um banco SQLite local (`data/database.db`):

- `sales` — Vendas diárias, clientes, funcionamento da loja, promoções e feriados (**1.017.209 registros**)
- `store` — Características das lojas, sortimento, concorrência e informações sobre o Promo2 (**1.115 lojas**)

Todos os dados brutos são transformados em uma **Feature Store** (`data/feature_store.db`), organizada por **loja e data de referência**, e posteriormente utilizados para construir a **Analytical Base Table (ABT)** usada na modelagem.

Foram utilizadas janelas históricas de **7, 14, 28, 42, 56 e 84 dias**, permitindo capturar comportamentos de curto e longo prazo.

**Prevenção de Data Leakage:** as variáveis históricas são construídas utilizando apenas informações disponíveis até a respectiva data de referência.

---



## Solução

Um **modelo XGBoost** treinado com **240 features** organizadas em uma Feature Store, agrupadas em quatro categorias principais:

- **Vendas:** histórico de vendas, estatísticas móveis, sazonalidade e indicadores de crescimento
- **Clientes:** volume, variabilidade e indicadores de crescimento do fluxo de clientes
- **Temporal:** funcionamento da loja, promoções e feriados
- **Loja:** tipo, sortimento, concorrência e participação em programas promocionais



### Pipeline de modelagem

- **Valores ausentes:** tratados com um transformer customizado `NullImputer` (mediana, 0, -1, ou indicadores de ausência, dependendo da variável)
- **Encoding:** One-Hot Encoding para `StoreType` e `Assortment` (`handle_unknown='ignore'`)
- **Escala:** Min-Max Scaling aplicado às variáveis numéricas não binárias
- **Divisão:** split cronológico pela data de referência — **60% treino, 20% validação, 20% teste**, além de um conjunto separado **Out-of-Time (OOT)** com a data de referência mais recente, para evitar o uso de informações futuras durante o treinamento



### Seleção do modelo

Quatro modelos de regressão foram comparados utilizando o mesmo pipeline de pré-processamento:


| Modelo            | R² Val. | MAPE Val. | R² Teste   | MAPE Teste |
| ----------------- | ------- | --------- | ---------- | ---------- |
| Gradient Boosting | 0.8847  | 8.14%     | **0.9167** | **5.54%**  |
| AdaBoost          | 0.7550  | 13.20%    | 0.8182     | 10.46%     |
| Random Forest     | 0.8740  | 8.85%     | 0.8235     | 6.87%      |
| XGBoost           | 0.8748  | 8.99%     | 0.8703     | 7.12%      |


Embora o Gradient Boosting tenha apresentado as melhores métricas brutas no teste, o **XGBoost foi selecionado** por seu desempenho competitivo na validação, uma diferença menor entre validação e teste (melhor generalização) e menor tempo de treinamento, tornando-o a melhor opção para a etapa de otimização de hiperparâmetros.

### Ajuste de hiperparâmetros

O XGBoost foi ajustado com **Optuna**, minimizando o **MAE** no conjunto de validação ao longo de **50 trials**. A melhor configuração (trial 46, MAE de validação ≈ R$ 20.022,60) foi:

- `n_estimators`: 447
- `max_depth`: 9
- `learning_rate`: 0.0114
- `min_child_weight`: 10
- `subsample`: 0.6567
- `colsample_bytree`: 0.6170
- `gamma`: 4.6341
- `reg_alpha`: 4.5027
- `reg_lambda`: 0.0043

---



## Performance do Modelo

Após o ajuste, o modelo final foi retreinado com os conjuntos combinados de **treino + validação**, mantendo o período **OOT** totalmente separado para uma avaliação final em dados mais recentes:


| Métrica  | Teste        | OOT          |
| -------- | ------------ | ------------ |
| **R²**   | **0.9469**   | **0.9461**   |
| **MAE**  | R$ 11.065,86 | R$ 12.895,76 |
| **MAPE** | **4.51%**    | **5.20%**    |
| **RMSE** | R$ 20.292,75 | R$ 20.822,40 |


A proximidade entre os resultados de Teste e OOT indica **boa capacidade de generalização** e desempenho estável ao prever um período não utilizado durante o treinamento ou o ajuste.

---



## Análise de Erros

A análise de erros foi realizada tanto em nível de observação quanto em nível de loja:

- A maioria das previsões apresenta erros concentrados **próximos de zero**, com uma distribuição que mostra caudas em ambos os lados para um número menor de outliers.
- Em nível de loja, a maior parte dos erros absolutos fica abaixo de aproximadamente **R$ 20.000**, embora algumas lojas (ex.: loja 842) atinjam erros de até **~R$ 155.000**, principalmente lojas com alto volume de vendas ou comportamento atípico.
- Algumas lojas (ex.: 187, 339, 77) tiveram previsões quase perfeitas, com erros inferiores a R$ 12.
- Foi identificada uma leve tendência de **subestimação das vendas** no período mais recente da série.
- Não foi encontrada relação clara entre o número da loja e a magnitude do erro — a dificuldade de previsão está associada às características individuais de cada loja, não ao seu identificador.

Esses casos representam oportunidades para investigações futuras, especialmente em lojas com maior variabilidade de vendas.

---



## Principais Resultados

✓ **R² de 0.9461 e MAPE de 5.20%** no período OOT

✓ Previsão de vendas para os **próximos 42 dias**, por loja

✓ **240 features** cobrindo vendas, clientes, comportamento temporal e características das lojas

✓ **Otimização com Optuna**, utilizando 50 trials

✓ **Boa generalização** entre os conjuntos de Teste e OOT

✓ A maioria das previsões apresenta **baixo erro absoluto**, concentrado próximo de zero

✓ Identificação de lojas/períodos com maior erro, permitindo investigações futuras

---



## Pipeline de Execução

```text
Dados Brutos
    ↓
Exploração
    ↓
Engenharia de Features
    ↓
Feature Store
    ↓
Analytical Base Table (ABT)
    ↓
Pipeline de Pré-processamento
    ↓
Comparação de Modelos
    ↓
Seleção do XGBoost
    ↓
Ajuste com Optuna
    ↓
Modelo Final
    ↓
Avaliação em Teste + OOT
    ↓
Análise de Erros
    ↓
Previsão de Vendas
```

---



## Estrutura do Projeto

```text
rossman-sales-forecast/
├── data/
│   ├── database.db              # Banco de dados bruto (tabelas sales e store) — não versionado
│   └── feature_store.db         # Feature Store construída a partir dos dados brutos — não versionada
├── models/
│   └── xgb_store_forecast       # Artefato do modelo treinado (pickle) — não versionado
└── src/
    ├── english/                 # Notebooks e scripts, documentados em inglês
    │   └── ...
    └── portuguese/               # Mesmo pipeline, documentado em português
        ├── 01-inital_exploration/
        │   ├── 01-data_exploration.ipynb
        │   └── 02-feature_store.ipynb
        ├── 02-feature_store/
        │   ├── fs_clientes.sql
        │   ├── fs_loja.sql
        │   ├── fs_temporal.sql
        │   ├── fs_vendas.sql
        │   └── ingestion.py
        ├── 03-train/
        │   ├── abt.sql
        │   ├── model_selection.ipynb  # Notebook de exploração e seleção de modelo
        │   ├── preprocessing.py       # Transformer NullImputer
        │   └── train.py               # Script de treinamento de produção
        └── 04-predict/
            ├── etl.sql
            └── predict.py               # Script de previsão de produção
```

> :warning: As pastas `data/` e `models/` estão vazias por padrão (o conteúdo é excluído via `.gitignore`). É necessário fornecer o `data/database.db` bruto e gerar a Feature Store e o modelo treinado executando o pipeline abaixo.

---



## Como Executar o Projeto



### 1. Requisitos

- Python 3.10+
- Instale as dependências listadas em `requirements.txt`:

```bash
pip install -r requirements.txt
```



### 2. Prepare os dados brutos

Coloque o banco de dados SQLite bruto, contendo as tabelas `sales` e `store` (dataset Rossmann), em:

```text
data/database.db
```



### 3. Construa a Feature Store

A partir de `src/english/02-feature_store/` (ou `src/portuguese/02-feature_store/`), execute o script de ingestão para cada grupo de features no intervalo de datas desejado. O script lê a query `fs_{table}.sql` correspondente e grava os resultados em `data/feature_store.db`:

```bash
cd src/portuguese/02-feature_store

python ingestion.py --table vendas    --start_date 2013-03-26 --end_date 2015-07-31
python ingestion.py --table loja      --start_date 2013-03-26 --end_date 2015-07-31
python ingestion.py --table clientes  --start_date 2013-03-26 --end_date 2015-07-31
python ingestion.py --table temporal  --start_date 2013-03-26 --end_date 2015-07-31
```

> Ajuste `--start_date` / `--end_date` para o intervalo de datas de referência que deseja processar. Executar novamente para uma data já processada substitui os dados existentes dessa data.



### 4. Explore os dados e o processo de modelagem (opcional)

Abra os notebooks no Jupyter para reproduzir as etapas de exploração, análise de features, comparação de modelos e ajuste com Optuna:

```bash
jupyter notebook src/portuguese/01-inital_exploration/01-data_exploration.ipynb
jupyter notebook src/portuguese/03-train/model_selection.ipynb
```

> :warning: O `model_selection.ipynb` é destinado apenas para **exploração e análise**. Para treinar o modelo e persistir os resultados, utilize o script `train.py` (passo 5).



### 5. Treine o modelo final

A partir da raiz do projeto, execute o script de treinamento de produção. Ele lê a ABT da Feature Store, aplica o pipeline de pré-processamento, ajusta o modelo XGBoost já otimizado e salva o pipeline treinado em `models/xgb_store_forecast`:

```bash
cd src/portuguese/03-train
python train.py
```



### 6. Gere as previsões

Execute o script de previsão para pontuar a ABT atual com o modelo treinado e gravar os resultados de volta no banco de dados:

```bash
cd src/portuguese/04-predict
python predict.py
```

As previsões (`IdStore`, `DtRef`, `prediction`) são armazenadas na tabela `tb_sales` dentro de `data/feature_store.db`.

---



## Tecnologias Utilizadas

- **Python** — pandas, NumPy
- **Scikit-learn** — pipelines, pré-processamento, transformers customizados
- **XGBoost** — modelo final de regressão
- **Optuna** — otimização bayesiana de hiperparâmetros
- **SQLAlchemy / SQLite** — Feature Store e Analytical Base Table (ABT)
- **Matplotlib / Seaborn** — visualizações de exploração e análise de erros

