> :information_source: For the Portuguese version of this README, see the file **README_PT.md**.

## Project Overview

A **machine learning model for retail sales forecasting** that predicts the **total sales value for the next 42 days (six weeks)** for each store of a pharmacy chain, achieving an **R² of 0.9461** and a **MAPE of 5.20%** on the Out-of-Time (OOT) test period.

### Highlights

- **R²: 0.9461** | **MAPE: 5.20%** on the OOT set, strong predictive power and consistency over time
- **MAE: R$ 12,895.76** and **RMSE: R$ 20,822.40** on OOT
- **240 features** built from sales history, customers, promotions, holidays, and store characteristics
- **XGBoost** selected after comparing 4 regression algorithms, tuned with **Optuna (50 trials)**
- Feature Store organized by **store and reference date**, built with **SQL + Python**

---



## Business Problem

**Estimate the future sales of each store** to support strategic decisions related to investments, store expansion, renovations, and marketing campaigns.

**Target:** Total sales accumulated in the **42 days following the reference date**.

**Output:** Predicted sales value for each store over the upcoming six weeks.

---



## Data & Infrastructure

The project combines two main data sources, stored in a local SQLite database (`data/database.db`):

- `sales` — Daily sales, customers, store operation, promotions, and holidays (**1,017,209 records**)
- `store` — Store characteristics, assortment, competition, and Promo2 information (**1,115 stores**)

All raw data is transformed into a **Feature Store** (`data/feature_store.db`), organized by **store and reference date**, and later used to build the **Analytical Base Table (ABT)** used for modeling.

Historical windows of **7, 14, 28, 42, 56, and 84 days** were used to capture both short- and long-term behavior.

**Data Leakage Prevention:** historical features are built using only information available up to the respective reference date.

---



## Solution

An **XGBoost model** trained on **240 features** organized in a Feature Store, grouped into four main categories:

- **Sales:** sales history, moving statistics, seasonality, and growth indicators
- **Customers:** volume, variability, and growth indicators for customer traffic
- **Temporal:** store operation, promotions, and holidays
- **Store:** type, assortment, competition, and participation in promotional programs



### Modeling pipeline

- **Missing values:** handled with a custom `NullImputer` transformer (median, 0, -1, or missing-indicator flags depending on the variable)
- **Encoding:** One-Hot Encoding for `StoreType` and `Assortment` (`handle_unknown='ignore'`)
- **Scaling:** Min-Max Scaling applied to non-binary numeric features
- **Split:** chronological split by reference date, **60% train, 20% validation, 20% test**, plus a separate **Out-of-Time (OOT)** holdout using the most recent reference date, to avoid using future information during training



### Model selection

Four regression models were compared using the same preprocessing pipeline:


| Model             | R² Val. | MAPE Val. | R² Test    | MAPE Test |
| ----------------- | ------- | --------- | ---------- | --------- |
| Gradient Boosting | 0.8847  | 8.14%     | **0.9167** | **5.54%** |
| AdaBoost          | 0.7550  | 13.20%    | 0.8182     | 10.46%    |
| Random Forest     | 0.8740  | 8.85%     | 0.8235     | 6.87%     |
| XGBoost           | 0.8748  | 8.99%     | 0.8703     | 7.12%     |


Although Gradient Boosting had the best raw test metrics, **XGBoost was selected** for its competitive validation performance, a smaller gap between validation and test results (better generalization), and faster training time, making it the best fit for hyperparameter optimization.

### Hyperparameter tuning

XGBoost was tuned with **Optuna**, minimizing **MAE** on the validation set over **50 trials**. The best configuration (trial 46, validation MAE ≈ R$ 20,022.60) was:

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



## Model Performance

After tuning, the final model was retrained on the combined **train + validation** sets, keeping the **OOT** period completely separate for a final evaluation on more recent data:


| Metric   | Test         | OOT          |
| -------- | ------------ | ------------ |
| **R²**   | **0.9469**   | **0.9461**   |
| **MAE**  | R$ 11,065.86 | R$ 12,895.76 |
| **MAPE** | **4.51%**    | **5.20%**    |
| **RMSE** | R$ 20,292.75 | R$ 20,822.40 |


The closeness between Test and OOT results indicates **good generalization ability** and stable performance when forecasting a period not seen during training or tuning.

---



## Error Analysis

Error analysis was performed at both the observation and store levels:

- Most predictions have errors concentrated **near zero**, with a distribution showing tails on both sides for a smaller number of outliers.
- At the store level, most absolute errors stay below approximately **R$ 20,000**, though a few stores (e.g., store 842) reach errors of up to **~R$ 155,000**, mostly stores with high sales volume or atypical behavior.
- Some stores (e.g., 187, 339, 77) had near-perfect predictions, with errors below R$ 12.
- A slight trend of **underestimating sales** was identified toward the most recent period of the series.
- No clear relationship was found between store ID and error magnitude — prediction difficulty relates to each store's individual characteristics, not its identifier.

These outlier cases represent opportunities for future investigation, particularly for stores with higher sales variability.

---



## Key Results

✓ **R² of 0.9461 and MAPE of 5.20%** on the OOT period

✓ Sales forecast for the **next 42 days**, per store

✓ **240 features** covering sales, customers, temporal behavior, and store characteristics

✓ **Optuna optimization** with 50 trials

✓ **Good generalization** between Test and OOT sets

✓ Most predictions show **low absolute error**, concentrated near zero

✓ Identification of stores/periods with higher error, enabling further investigation

---



## Execution Pipeline

```text
Raw Data
    ↓
Exploration
    ↓
Feature Engineering
    ↓
Feature Store
    ↓
Analytical Base Table (ABT)
    ↓
Preprocessing Pipeline
    ↓
Model Comparison
    ↓
XGBoost Selection
    ↓
Optuna Tuning
    ↓
Final Model
    ↓
Test + OOT Evaluation
    ↓
Error Analysis
    ↓
Sales Forecasting
```

---



## Project Structure

```text
rossman-sales-forecast/
├── data/
│   ├── database.db              # Raw source database (sales + store tables) — not versioned
│   └── feature_store.db         # Feature Store built from the raw data — not versioned
├── models/
│   └── xgb_store_forecast       # Trained model artifact (pickle) — not versioned
└── src/
    ├── english/                 # Notebooks and scripts, documented in English
    │   ├── 01-inital_exploration/
    │   │   ├── 01-data_exploration.ipynb
    │   │   └── 02-feature_store.ipynb
    │   ├── 02-feature_store/
    │   │   ├── fs_customer.sql
    │   │   ├── fs_sales.sql
    │   │   ├── fs_store.sql
    │   │   ├── fs_temporal.sql
    │   │   └── ingestion.py
    │   ├── 03-train/
    │   │   ├── abt.sql
    │   │   ├── model_selection.ipynb  # Exploration & model selection notebook
    │   │   ├── preprocessing.py       # NullImputer transformer
    │   │   └── train.py               # Production training script
    │   └── 04-predict/
    │       ├── etl.sql
    │       └── predict.py              # Production prediction script
    └── portuguese/               # Same pipeline, documented in Portuguese
        └── ...
```

> :warning: The `data/` and `models/` folders are empty by default (their contents are excluded via `.gitignore`). You need to provide the raw `data/database.db` and generate the Feature Store and the trained model by running the pipeline below.

---



## How to Run the Project



### 1. Requirements

- Python 3.10+
- Install the dependencies listed in `requirements.txt`:

```bash
pip install -r requirements.txt
```



### 2. Prepare the raw data

Place the raw SQLite database, containing the `sales` and `store` tables (Rossmann dataset), at:

```text
data/database.db
```



### 3. Build the Feature Store

From `src/english/02-feature_store/`, run the ingestion script for each feature group over the desired date range. This reads the corresponding `fs_{table}.sql` query and writes the results into `data/feature_store.db`:

```bash
cd src/english/02-feature_store

python ingestion.py --table sales     --start_date 2013-03-26 --end_date 2015-07-31
python ingestion.py --table store     --start_date 2013-03-26 --end_date 2015-07-31
python ingestion.py --table customer  --start_date 2013-03-26 --end_date 2015-07-31
python ingestion.py --table temporal  --start_date 2013-03-26 --end_date 2015-07-31
```

> Adjust `--start_date` / `--end_date` to the reference-date range you want to process. Re-running for a date already ingested replaces the existing data for that date.



### 4. Explore the data and modeling process (optional)

Open the notebooks in Jupyter to reproduce the exploration, feature analysis, model comparison, and Optuna tuning steps:

```bash
jupyter notebook src/english/01-inital_exploration/01-data_exploration.ipynb
jupyter notebook src/english/03-train/model_selection.ipynb
```

> :warning: `model_selection.ipynb` is intended for **exploration and analysis only**. To train the model and persist the results, use the `train.py` script (step 5).



### 5. Train the final model

From the project root, run the production training script. It reads the ABT from the Feature Store, applies the preprocessing pipeline, fits the tuned XGBoost model, and saves the trained pipeline to `models/xgb_store_forecast`:

```bash
cd src/english/03-train
python train.py
```



### 6. Generate predictions

Run the prediction script to score the current ABT with the trained model and write the results back to the database:

```bash
cd src/english/04-predict
python predict.py
```

The predictions (`IdStore`, `DtRef`, `prediction`) are stored in the `tb_sales` table inside `data/feature_store.db`.

---



## Tech Stack

- **Python** — pandas, NumPy
- **Scikit-learn** — pipelines, preprocessing, custom transformers
- **XGBoost** — final regression model
- **Optuna** — Bayesian hyperparameter optimization
- **SQLAlchemy / SQLite** — Feature Store and Analytical Base Table (ABT)
- **Matplotlib / Seaborn** — exploratory and error analysis visualizations

