# SQL Structure Overview  
This document explains the organization and rationale behind the SQL work conducted in the project **Exploratory Analysis of COVID-19 (2020–2025)**.  
The SQL analysis is intentionally divided into two major components:

1. **Data Validation and Profiling**  
2. **Analytical SQL EDA Queries**

This separation reflects a standard data-analysis workflow and ensures clarity, reproducibility, and maintainability for future readers, recruiters, and collaborators.

---

## 1. Data Validation and Profiling 🧹📊  
This first SQL stage focuses on inspecting, cleaning, validating, and understanding the structure and quality of the raw dataset before any analytical work is performed.  
It ensures that all downstream analysis is built on reliable and consistent data.

### 1.1 Raw Data Inspection  
The following checks were performed on the raw table imported from the *Our World in Data* COVID-19 dataset:  
- Row count verification  
- Displaying sample rows  
- Inspecting column names and data types  

These checks confirm that the dataset was imported correctly and help identify potential formatting or structural issues.

### 1.2 Creation of a Cleaned SQL View (`Covid_Clean`)  
A dedicated SQL view was built to standardize the dataset and improve analytical performance.  
Key decisions include:  
- Converting numeric fields using `TRY_CAST` to safely handle non-numeric artifacts  
- Keeping only relevant variables (cases, deaths, vaccinations, testing metrics, demographic indicators, policy indexes, etc.)  
- Preserving the original column names  
- Ensuring that the downstream analysis references a single, clean data source  

This step acts as a lightweight ETL transformation layer inside SQL.

### 1.3 Profiling the Cleaned Dataset  
Several checks were performed to better understand the structure, completeness, and consistency of the cleaned dataset:

- Time coverage (min/max date globally, per country, per continent)  
- Number of distinct countries and continents  
- Completeness of key indicators (absolute counts and percentages)  
- Identification of negative or impossible values  
- Missing-value profiling, globally and by continent  
- Distribution analysis (bucketed histograms via SQL CASE logic)  
- Basic descriptive statistics (min, max, average, standard deviation) for epidemiological variables  

This profiling phase provides a diagnostic view of data reliability and helps guide analytical choices later.

---

## 2. Analytical SQL EDA Queries 📈🔍  
Once the data was validated and understood, the second stage focuses on producing meaningful and interpretable analytical queries aligned with the project’s final research question:

**How have vaccination progress and socio-economic conditions influenced COVID-19 exposure and mortality between 2020 and 2025?**

The analytical SQL layer is intentionally structured into thematic blocks stored in subfolders under `/data/` for clarity and modularity.

### 2.1 Global Trends Overview  
Queries in this block focus on understanding worldwide patterns:  
- Global total cases and deaths over time  
- Global new cases/deaths (daily and smoothed)  
- Global vaccination progress (simple average and population-weighted)  

These outputs give the first high-level view of the pandemic evolution.

### 2.2 Continental Comparison  
This section compares continents using the latest valid values per metric:  
- Total cases per million  
- Total deaths per million  
- Vaccination progress per hundred  
- Stringency index per year  

This block highlights geographical disparities and helps contextualize global patterns.

### 2.3 Vaccination vs Mortality  
Queries here evaluate whether higher vaccination coverage is associated with reduced mortality:  
- Correlation-ready datasets (vaccination vs deaths per million)  
- Before/after vaccination mortality analysis  
- Top countries with the largest reduction in new deaths after vaccination rollout  

These outputs directly address the central analytical question.

### 2.4 Socio-Economic Drivers of COVID Exposure  
To explore structural vulnerabilities, this block analyzes:  
- GDP per capita vs total cases  
- Median age vs total deaths  
- Population density vs exposure  
- Life expectancy vs mortality  

These queries reflect how demographic and economic contexts shaped pandemic outcomes.

### 2.5 Policy Stringency and Spread Dynamics  
Finally, this block examines governmental response measures:  
- Stringency index volatility (stability vs variability of restrictions)  
- Countries with consistently high policy stringency  
- Relationship between stringency and new cases (smoothed)  

This provides insight into the potential alignment (or misalignment) between policy decisions and epidemic trends.

---

## Summary
The overall SQL structure provides a clear separation between **data validation** and **exploratory analytics**, ensuring that the analysis is built on reliable foundations. It results in reproducible and well-documented code, following a logical progression from raw inputs to insight-ready datasets. This organization aligns with industry standards for analytical projects and enhances readability for recruiters assessing SQL proficiency. Together, the two SQL phases form a solid base for the subsequent Python notebook, visualizations, and final analytical narrative.


