--- Initial raw data verification :

-- Checking total rows 

SELECT COUNT (*) 
FROM [COVID-19 dataset] AS dataset_rows
ORDER BY 1;

-- Checking table

SELECT TOP 10 *
FROM [COVID-19 dataset]
ORDER BY 1;

-- Checking columns names and data types

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'COVID-19 dataset';

-- Creating a cleaned view for analysis

CREATE VIEW dbo.Covid_Clean AS
SELECT
country,
continent,
code,
CAST(date AS date) AS date,

total_cases,
new_cases,
TRY_CAST(new_cases_smoothed AS float) AS new_cases_smoothed,
total_deaths,
new_deaths,
TRY_CAST(new_deaths_smoothed AS float) AS new_deaths_smoothed,

TRY_CAST(total_cases_per_million AS float) AS total_cases_per_million,
TRY_CAST(new_cases_per_million AS float) AS new_cases_per_million,
TRY_CAST(total_deaths_per_million AS float) AS total_deaths_per_million,
TRY_CAST(new_deaths_per_million AS float) AS new_deaths_per_million,

population,
TRY_CAST(population_density AS float) AS population_density,
TRY_CAST(median_age AS float) AS median_age,
TRY_CAST(life_expectancy AS float) AS life_expectancy,
TRY_CAST(gdp_per_capita AS float) AS gdp_per_capita,
TRY_CAST(human_development_index AS float) AS human_development_index,

TRY_CAST(stringency_index AS float) AS stringency_index,
TRY_CAST(reproduction_rate AS float) AS reproduction_rate,

TRY_CAST(total_tests AS float) AS total_tests,
TRY_CAST(new_tests AS float) AS new_tests,
TRY_CAST(new_tests_smoothed AS float) AS new_tests_smoothed,
TRY_CAST(new_tests_smoothed_per_thousand AS float) AS new_tests_smoothed_per_thousand,

TRY_CAST(total_tests_per_thousand AS float) AS total_tests_per_thousand,
TRY_CAST(new_tests_per_thousand AS float) AS new_tests_per_thousand,
TRY_CAST(positive_rate AS float) AS positive_rate,
TRY_CAST(tests_per_case AS float) AS tests_per_case,

TRY_CAST(total_vaccinations AS float) AS total_vaccinations,
TRY_CAST(people_vaccinated AS float) AS people_vaccinated,
TRY_CAST(people_fully_vaccinated AS float) AS people_fully_vaccinated,
TRY_CAST(total_boosters AS float) AS total_boosters,
TRY_CAST(new_vaccinations AS float) AS new_vaccinations,
TRY_CAST(new_vaccinations_smoothed AS float) AS new_vaccinations_smoothed,
TRY_CAST(total_vaccinations_per_hundred AS float) AS total_vaccinations_per_hundred,
TRY_CAST(people_vaccinated_per_hundred AS float) AS people_vaccinated_per_hundred,
TRY_CAST(people_fully_vaccinated_per_hundred AS float) AS people_fully_vaccinated_per_hundred
FROM [COVID-19 dataset];
GO

--- Basic Sanity check:

-- First rows

SELECT TOP 20 * 
FROM dbo.Covid_Clean
ORDER BY country, date;

-- Row count

SELECT COUNT(*)
FROM [COVID-19 dataset] AS original_dataset_rows;

SELECT COUNT(*)
FROM dbo.Covid_Clean AS cleaned_dataset_rows;

--- Profiling : 

-- Time range

SELECT 
MIN(date) AS min_date,
MAX(date) AS max_date
FROM dbo.Covid_Clean;

-- Number of distinct countries and continents

SELECT 
COUNT(DISTINCT country) AS distinct_countires,
COUNT(DISTINCT continent) AS distinct_continent
FROM dbo.Covid_Clean

-- Number of distinct per country
SELECT 
country,
COUNT(*) AS number_of_lines
FROM dbo.Covid_Clean
GROUP BY country
ORDER BY number_of_lines DESC;

--  Key columns completeness

-- in volume
SELECT 
COUNT(*) AS total_rows,
COUNT(total_cases) AS non_null_total_cases,
COUNT(total_deaths) AS non_null_total_deaths,
COUNT(total_tests) AS non_null_total_tests,
COUNT(total_vaccinations) AS non_null_total_vaccinations,
COUNT(people_fully_vaccinated) AS non_null_people_fully_vaccinated,
COUNT(positive_rate) AS non_null_positive_rate
FROM dbo.Covid_Clean;

-- in percentage %
SELECT
COUNT(*) AS total_rows,
CAST(COUNT(total_cases) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completeness_total_cases_pct,
CAST(COUNT(total_deaths) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completeness_total_deaths_pct, 
CAST(COUNT(total_tests) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completeness_total_tests_pct,
CAST(COUNT(total_vaccinations) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completeness_total_vaccinations_pct,
CAST(COUNT(people_fully_vaccinated) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completeness_people_fully_vaccinated_pct,
CAST(COUNT(positive_rate) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS completeness_positive_rate_pct
FROM dbo.Covid_Clean;

-- Date coverage per country

SELECT
country,
MIN(date) AS first_date,
MAX(date) AS last_date,
DATEDIFF(DAY, MIN(date), MAX(date)) + 1 AS days_intervall,
COUNT(DISTINCT date) AS distinct_date
FROM dbo.Covid_Clean
WHERE country IS NOT NULL
GROUP BY country
ORDER BY first_date, country;

-- Stats (Min, Max, average, standard deviation) 

SELECT
MIN(total_deaths_per_million) AS min_total_deaths_per_million,
MAX(total_deaths_per_million) AS max_total_deaths_per_million,
AVG(total_deaths_per_million) AS avg_total_deaths_per_million,
STDEV(total_deaths_per_million) AS std_total_deaths_per_million
FROM dbo.Covid_Clean;

SELECT
MIN(total_cases_per_million) AS min_total_cases_per_million,
MAX(total_cases_per_million) AS max_total_cases_per_million,
AVG(total_cases_per_million) AS avg_total_cases_per_million,
STDEV(total_cases_per_million) AS std_total_cases_per_million
FROM dbo.Covid_Clean;

SELECT
MIN(new_cases) AS min_new_cases,
MAX(new_cases) AS max_new_cases,
AVG(new_cases) AS avg_new_cases,
STDEV(new_cases) AS std_new_cases
FROM dbo.Covid_Clean;

SELECT
MIN(new_deaths) AS min_new_deaths,
MAX(new_deaths) AS max_new_deaths,
AVG(new_deaths) AS avg_new_deaths,
STDEV(new_deaths) AS std_new_deaths
FROM dbo.Covid_Clean;

SELECT
MIN(total_vaccinations_per_hundred) AS min_total_vaccinations_per_hundred,
MAX(total_vaccinations_per_hundred) AS max_total_vaccinations_per_hundred,
AVG(total_vaccinations_per_hundred) AS avg_total_vaccinations_per_hundred,
STDEV(total_vaccinations_per_hundred) AS std_total_vaccinations_per_hundred
FROM dbo.Covid_Clean;

-- Number of distinct per continent

SELECT 
continent,
COUNT(*) AS number_of_lines
FROM dbo.Covid_Clean
GROUP BY continent
ORDER BY number_of_lines DESC

-- Date coverage per continent

SELECT
continent,
MIN(date) AS first_date,
MAX(date) AS last_date,
DATEDIFF(DAY, MIN(date), MAX(date)) + 1 AS days_intervall,
COUNT(DISTINCT date) AS distinct_date
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY first_date, continent

-- Countries with the highest total cases per million (top 10)

SELECT TOP 10
country,
MAX(total_cases_per_million) AS max_total_cases_per_million
FROM dbo.Covid_Clean
WHERE total_cases_per_million IS NOT NULL
GROUP BY country
ORDER BY max_total_cases_per_million DESC;

-- Countries with the highest total deaths per million (top 10)

SELECT TOP 10
country,
MAX(total_deaths_per_million) AS max_total_deaths_per_million
FROM dbo.Covid_Clean
WHERE total_deaths_per_million IS NOT NULL
GROUP BY country
ORDER BY max_total_deaths_per_million DESC;

-- Countries with the highest daily new_cases (top 10) 

SELECT TOP 10
country,
MAX(new_cases) AS max_new_cases
FROM dbo.Covid_Clean
WHERE new_cases IS NOT NULL
GROUP BY country
ORDER BY max_new_cases DESC;
		----- this query doesn't shows countries but other entities (Europeen Union, world excl. China...)----

-- Countries with negative values on key indicators 

SELECT
country,
date,
total_cases,
new_cases,
total_deaths,
new_deaths,
total_vaccinations,
people_fully_vaccinated
FROM dbo.Covid_Clean
WHERE 
	total_cases < 0 
	OR new_cases < 0
	OR total_deaths< 0
	OR new_deaths < 0
	OR total_vaccinations < 0
	OR people_fully_vaccinated < 0
ORDER BY country, date;

-- Countries with the highest number of NULLs on key indicators (top 10)

SELECT TOP 10
country,
SUM(CASE WHEN total_cases IS NULL THEN 1 ELSE 0 END) AS null_total_cases,
SUM(CASE WHEN total_deaths IS NULL THEN 1 ELSE 0 END) AS null_total_deaths,
SUM(CASE WHEN total_tests IS NULL THEN 1 ELSE 0 END) AS null_total_tests,
SUM(CASE WHEN total_vaccinations IS NULL THEN 1 ELSE 0 END) AS null_total_vaccinations,
SUM(CASE WHEN people_fully_vaccinated IS NULL THEN 1 ELSE 0 END) AS null_people_fully_vaccinated,
SUM(CASE WHEN positive_rate IS NULL THEN 1 ELSE 0 END) AS null_positive_rate,
COUNT(*) AS total_rows_country
FROM dbo.Covid_Clean
GROUP BY country
ORDER BY
(
SUM(CASE WHEN total_cases IS NULL THEN 1 ELSE 0 END)
+ SUM(CASE WHEN total_deaths IS NULL THEN 1 ELSE 0 END)
+ SUM(CASE WHEN total_tests IS NULL THEN 1 ELSE 0 END)
+ SUM(CASE WHEN total_vaccinations IS NULL THEN 1 ELSE 0 END)
+ SUM(CASE WHEN people_fully_vaccinated IS NULL THEN 1 ELSE 0 END)
+ SUM(CASE WHEN positive_rate IS NULL THEN 1 ELSE 0 END)
) 
DESC;

-- Distribution of total_cases_per_million (global)

SELECT
CASE
WHEN total_cases_per_million < 1000 THEN '0–1 000'
WHEN total_cases_per_million < 5000 THEN '1 000–5 000'
WHEN total_cases_per_million < 10000 THEN '5 000–10 000'
WHEN total_cases_per_million < 20000 THEN '10 000–20 000'
ELSE '20 000+'
END AS bucket,
COUNT(*) AS rows_count
FROM dbo.Covid_Clean
WHERE total_cases_per_million IS NOT NULL
GROUP BY
CASE
WHEN total_cases_per_million < 1000 THEN '0–1 000'
WHEN total_cases_per_million < 5000 THEN '1 000–5 000'
WHEN total_cases_per_million < 10000 THEN '5 000–10 000'
WHEN total_cases_per_million < 20000 THEN '10 000–20 000'
ELSE '20 000+'
END
ORDER BY rows_count DESC;

-- Distribution of total_cases_per_million by country (using max values)

WITH country_cases AS 
(
SELECT
country,
MAX(total_cases_per_million) AS max_cases_pm
FROM dbo.Covid_Clean
WHERE total_cases_per_million IS NOT NULL
GROUP BY country
)
SELECT
CASE
WHEN max_cases_pm < 1000 THEN '0–1 000'
WHEN max_cases_pm < 5000 THEN '1 000–5 000'
WHEN max_cases_pm < 10000 THEN '5 000–10 000'
WHEN max_cases_pm < 20000 THEN '10 000–20 000'
ELSE '20 000+'
END AS bucket,
COUNT(*) AS countries_count
FROM country_cases
GROUP BY
CASE
WHEN max_cases_pm < 1000 THEN '0–1 000'
WHEN max_cases_pm < 5000 THEN '1 000–5 000'
WHEN max_cases_pm < 10000 THEN '5 000–10 000'
WHEN max_cases_pm < 20000 THEN '10 000–20 000'
ELSE '20 000+'
END
ORDER BY countries_count DESC;

-- Missing values by continent – counts

SELECT
continent,
    SUM(CASE WHEN total_cases IS NULL THEN 1 ELSE 0 END) AS null_total_cases,
    SUM(CASE WHEN total_deaths IS NULL THEN 1 ELSE 0 END) AS null_total_deaths,
    SUM(CASE WHEN total_tests IS NULL THEN 1 ELSE 0 END) AS null_total_tests,
    SUM(CASE WHEN total_vaccinations IS NULL THEN 1 ELSE 0 END) AS null_total_vaccinations,
    SUM(CASE WHEN people_fully_vaccinated IS NULL THEN 1 ELSE 0 END) AS null_people_fully_vaccinated,
    SUM(CASE WHEN positive_rate IS NULL THEN 1 ELSE 0 END) AS null_positive_rate,
    COUNT(*) AS total_rows_continent
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY continent; 

-- Missing values by continent – completeness percentage %

SELECT
    continent,
    COUNT(*) AS total_rows_continent,
    CAST(SUM(CASE WHEN total_tests IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS pct_null_total_tests,
    CAST(SUM(CASE WHEN total_vaccinations IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS pct_null_total_vaccinations,
    CAST(SUM(CASE WHEN people_fully_vaccinated IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS pct_null_people_fully_vaccinated,
    CAST(SUM(CASE WHEN positive_rate IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS pct_null_positive_rate
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY continent;

-- Missing values summary for key indicators by continent

SELECT
continent,
COUNT(*) AS total_rows_continent,
(
    SUM(CASE WHEN total_tests IS NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN total_vaccinations IS NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN people_fully_vaccinated IS NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN positive_rate IS NULL THEN 1 ELSE 0 END)
) AS total_nulls_key_indicators
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_nulls_key_indicators DESC;
