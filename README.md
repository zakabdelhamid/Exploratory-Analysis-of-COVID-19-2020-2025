# 📊 Exploratory Analysis of COVID-19 (2020–2025)

This project presents a full exploratory analysis of the global COVID-19 pandemic between 2020 and 2025, using the complete dataset from Our World in Data.  
It combines SQL (data validation, profiling, analytical queries) and Python (Pandas, NumPy, Matplotlib, Seaborn) to transform raw data into interpretable insights.

**Keywords:** SQL, Python, Data Analysis, COVID-19, Vaccination, Mortality, Global Health, EDA, Data Visualization

---

## 🧭 1. Executive Summary

This project delivers a structured end-to-end exploration of COVID-19 dynamics over a five-year period.  
The analysis integrates:

- global case and mortality trends,  
- vaccination rollout,  
- continental disparities,  
- socio-economic and demographic drivers,  
- policy responses measured through the stringency index.

The result is a clear, methodical narrative supported by SQL aggregations and Python visualizations.

---

## 💡 2. Business Problem

**Main analytical question:**

> To what extent can differences in COVID-19 exposure, mortality, and transmission between countries be explained by vaccination coverage, demographic structure, and the strictness of public health policies?

This problem enables a multi-dimensional analysis of pandemic dynamics and supports nuanced interpretation across countries.

---

## 🧩 3. Methodology

### 3.1. Data Source

All data comes from the Our World in Data COVID-19 dataset, covering cases, deaths, vaccinations, demographics, policies, and socio-economic indicators.

---

### 3.2. Phase 1 — SQL: Data Validation and Profiling

Key steps:

- structural inspection and column selection  
- creation of a cleaned analytical table (`Covid_Clean`)  
- missing-value profiling  
- statistical profiling of numerical variables  
- completeness checks by country and continent  
- verification of temporal coverage  

All SQL scripts are stored under `/sql/Data Validation and Profiling`.

---

### 3.3. Phase 2 — SQL: Analytical EDA Queries

Analytical queries are grouped into five blocks:

1. Global Trends Overview  
2. Continental Comparison  
3. Vaccination vs Mortality Analysis  
4. Socio-Economic Drivers  
5. Policy Stringency and Spread Dynamics  

All query outputs were exported to CSV for Python visualization.  
Scripts are stored under `/sql/Analytical SQL Queries`.

---

### 3.4. Phase 3 — Python EDA and Visualization

Using Pandas, NumPy, Matplotlib, and Seaborn, the notebook transforms SQL outputs into visual analyses:

- temporal line charts  
- bar charts for continental differences  
- scatterplots with regression lines  
- before/after analyses  
- policy vs transmission comparisons  

The full notebook is available under `/notebooks/`.

---

## 📈 4. Results and Key Insights

### Global Dynamics
- Cases and deaths increase sharply until early 2023, then stabilize.  
- Major transmission waves occur between 2020 and 2023 before declining to near zero in 2024–2025.  
- Vaccination increases quickly in 2021–2022 and plateaus around 70–75 percent globally.

### Continental Disparities
- Europe and Oceania show the highest infection levels.  
- Africa reports the lowest, partly due to demographics and under-reporting.  
- Mortality patterns reflect similar differences.

### Vaccination and Mortality
- Vaccination rate shows weak direct correlation with cumulative mortality.  
- High heterogeneity reflects timing, demographics, variant waves, and healthcare capacity.  
- Before/after analyses show mortality reductions in most countries, but increases where major waves arrived post-rollout.

### Socio-Economic and Demographic Factors
- Higher life expectancy correlates with higher mortality due to age structure.  
- GDP per capita and population density influence outcomes but non-linearly.

### Policy Stringency
- Strict long-term policies do not ensure lower transmission.  
- Volatile policies correspond to inconsistent epidemic control.

---

## 💼 5. Analytical Conclusion

The analysis shows that global COVID-19 outcomes result from the combined effects of vaccination timing, demographic vulnerability, policy responses, socio-economic structure, health-system capacity, and timing of variant waves.  
No single indicator sufficiently explains differences between countries; a multidimensional approach is necessary.

---

## 🛠️ 6. Technologies and Skills Used

**Languages:** SQL, Python  
**Libraries:** Pandas, NumPy, Matplotlib, Seaborn  
**Tools:** SQL Server, Google Colab, GitHub  

Skills demonstrated:

- data validation and profiling  
- analytical SQL  
- manipulation of large real-world datasets  
- data visualization and interpretation  
- end-to-end analytical workflow structuring

---

## 🔗 7. Repository Structure

```text
├── README.md
├── sql/
│   ├── Data Validation and Profiling/
│   ├── Analytical SQL Queries/
│   └── notes_sql_structure.mds/
├── data/
│   ├── Global Trends Overview/
│   ├── Continental Comparison/
│   ├── Vaccination vs Mortality Analysis/
│   ├── Socio-Economic Drivers/
│   ├── Policy Stringency and Spread Dynamics/
│   └── data_dictionary.md
├── notebooks/
│   ├── Exploratory Analysis of COVID-19 (2020–2025).ipynb
│   └── key_insights.md
└── figures/
    ├── fig01. Global total COVID-19 cases and deaths over time (2020–2025).png
    ├── fig02. Global daily and smoothed new COVID-19 cases & new COVID-19 deaths (2020–2025).png
    ├── fig03. Global vaccination progress (2020–2025).png
    ├── fig04 COVID-19 Cases per Million by Continent (Latest Available Data).png
    ├── fig05. COVID-19 Deaths per Million by Continent (Latest Available Data).png
    ├── fig06 COVID-19 Vaccination per Hundred by Continent (Latest Available Data).png
    ├── fig07. Vaccination vs COVID-19 Mortality by Country.png
    ├── fig08. Change in COVID-19 Mortality Before vs After Vaccination Rollout (Top decreases & increases).png
    ├── fig09. Life expectancy vs COVID-19 mortality (outliers removed).png
    ├── fig10 Top 20 Countries with Highest Volatility in COVID-19 Stringency Index (2020–2025).png
    ├── fig11. Top 20 Countries with the Highest Average COVID-19 Stringency Index (2020–2025).png
    ├── fig12. Volatile COVID-19 Policies and Transmission (2020–2025).png
    └── fig13. Strict COVID-19 Policies and Transmission (2020–2025).png
```

---

## 🚀 8. Next Steps / Future Improvements

Building on the conclusion that COVID-19 outcomes emerge from a **multidimensional interplay** of factors rather than any single driver, several extensions can strengthen and deepen the analysis:

1. **Integrate more socio-economic indicators**  
   Incorporate GDP per capita, healthcare capacity (ICU beds, physicians per 1,000), and inequality indices to better quantify structural drivers of mortality and transmission.

2. **Add demographic granularity**  
   Use age-group distributions rather than life expectancy alone to more precisely capture vulnerability patterns across countries.

3. **Expand policy analysis**  
   Evaluate not only the stringency index but also sub-components (school closures, travel bans, testing policy) to assess which measures correlate most with reduced transmission.

4. **Conduct time-series modeling**  
   Apply forecasting methods (ARIMA, Prophet, LSTM) to examine the persistence of trends and anticipate future waves under different scenarios.

5. **Measure temporal alignment**  
   Compare the timing of vaccination peaks, variant waves, and policy changes to better understand causal sequence effects.

6. **Develop interactive dashboards**  
   Build interactive visual interfaces (Plotly, Power BI) enabling dynamic filtering by region, indicator, or time period.

7. **Assess reporting quality and bias**  
   Incorporate OWID metadata to adjust analyses for under-reporting, delayed reporting, or missing values—particularly relevant for Africa and parts of Asia.

8. **Cluster countries by pandemic profiles**  
   Apply unsupervised learning (k-means, hierarchical clustering) to group countries according to combined indicators (mortality, vaccination, demographics, policy), allowing clearer typologies.

9. **Explore causal inference techniques**  
   Use methods such as difference-in-differences or synthetic control where applicable, to estimate the causal impact of interventions in specific countries.

These extensions would help transform the exploratory analysis into a more comprehensive assessment of the pandemic’s global dynamics.

---

## 🔁 9. Reproducibility


- All datasets are public and freely available through **Our World in Data**.  
- The provided SQL scripts and Python notebooks ensure **full reproducibility**.  
- The project demonstrates a **practical, analytical, and business-oriented approach** to public data exploration at an intermediate SQL level.
📘 **Interactive Notebook:**  
You can view the full visualization notebook here → [Google Colab Link](https://colab.research.google.com/drive/11tM5MNj3r0UBzhZIqL0-k6-OBF1rPxE2?usp=sharing)

