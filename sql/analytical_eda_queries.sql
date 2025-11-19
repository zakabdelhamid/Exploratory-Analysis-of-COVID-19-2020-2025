---- 1. Global Trends Overview

-- Global total cases and deaths over time

SELECT
date,
SUM(total_cases) AS global_total_cases,
SUM(total_deaths) AS global_total_deaths
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- Global daily and smoothed new cases and new deaths 

SELECT
date, 
SUM(new_cases) AS global_new_cases,
SUM(new_cases_smoothed) AS global_new_cases_smoothed,
SUM(new_deaths) AS global_new_deaths,
SUM(new_deaths_smoothed) AS global_new_deaths_smoothed
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;


-- Global vaccination progress over time

SELECT 
date, 
AVG(people_fully_vaccinated_per_hundred) AS global_people_fully_vaccinated_per_hundred,
SUM(people_fully_vaccinated) / SUM(population) * 100 AS global_people_fully_vaccinated_per_hundred_weighted
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

---- 2. Continental Comparison

-- Total cases per million by continent 

SELECT
continent,
SUM(total_cases) / SUM(population) * 1000000 AS total_cases_per_million
FROM dbo.Covid_Clean
WHERE 
    continent IS NOT NULL
    AND date = 
    (
        SELECT MAX(date)
        FROM dbo.Covid_Clean
        WHERE continent IS NOT NULL
          AND total_cases IS NOT NULL
    )
GROUP BY continent
ORDER BY total_cases_per_million DESC;

-- Total deaths per million by continent

SELECT
continent,
SUM(total_deaths) / SUM(population) * 1000000 AS total_deaths_per_million
FROM dbo.Covid_Clean
WHERE 
    continent IS NOT NULL
    AND date = 
    (
        SELECT MAX(date)
        FROM dbo.Covid_Clean
        WHERE continent IS NOT NULL
        AND total_deaths IS NOT NULL
    )
GROUP BY continent
ORDER BY total_deaths_per_million DESC;

-- Vaccination per hundred by continent

WITH last_valid_date AS 
(
    SELECT
    continent,
    MAX(date) AS last_date
    FROM dbo.Covid_Clean
    WHERE continent IS NOT NULL
    AND people_fully_vaccinated IS NOT NULL
    GROUP BY continent
)
SELECT
c.continent,
SUM(c.people_fully_vaccinated) / SUM(c.population) * 100 AS people_fully_vaccinated_per_hundred
FROM dbo.Covid_Clean AS c
INNER JOIN last_valid_date AS l
ON c.continent = l.continent
AND c.date = l.last_date
GROUP BY c.continent
ORDER BY people_fully_vaccinated_per_hundred DESC;

-- Average stringency index by continent and year

SELECT
continent,
YEAR(date) AS year,
AVG(stringency_index) AS avg_stringency_index
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
AND stringency_index IS NOT NULL
GROUP BY continent, YEAR(date)
ORDER BY continent, year 

---- 3. Vaccination vs Mortality Analysis

-- Correlation-ready dataset: vaccination vs mortality

WITH latest_valid_date AS
(
    SELECT
    country,
    MAX(date) AS last_date
    FROM dbo.Covid_Clean
    WHERE 
    continent IS NOT NULL
    AND people_fully_vaccinated_per_hundred IS NOT NULL
    AND total_deaths_per_million IS NOT NULL
    GROUP BY country
)

SELECT
c.country,
c.people_fully_vaccinated_per_hundred,
c.total_deaths_per_million
FROM dbo.Covid_Clean AS c
INNER JOIN latest_valid_date AS l
ON c.country = l.country
AND c.date = l.last_date
WHERE 
c.country IS NOT NULL
ORDER BY country;

-- Mortality evolution before vs after vaccination rollout (simple before/after)

WITH first_vaccination  AS
(
    SELECT
    country,
    MIN(date) AS first_vaccination_date
    FROM dbo.Covid_Clean
    WHERE
    continent IS NOT NULL 
    AND people_fully_vaccinated_per_hundred > 0
    GROUP BY country
),
before_after AS
(
    SELECT 
    c.country,

    -- Before vaccination: average daily new deaths 

    AVG(CASE WHEN c.date < f.first_vaccination_date
        THEN c.new_deaths END) AS avg_new_deaths_before,
       
    -- After vaccination: average daily new deaths
    AVG(CASE WHEN c.date > f.first_vaccination_date
        THEN c.new_deaths END) AS avg_new_deaths_after

    FROM dbo.Covid_Clean AS c
    INNER JOIN first_vaccination AS f
    ON c.country = f.country
    GROUP BY c.country
)
SELECT 
country,
avg_new_deaths_before,
avg_new_deaths_after, 
(avg_new_deaths_before - avg_new_deaths_after) AS reduction_after_vaccination

FROM before_after
WHERE avg_new_deaths_before IS NOT NULL
AND avg_new_deaths_after IS NOT NULL 
ORDER BY reduction_after_vaccination DESC ; 

-- Top 10 countries with the largest drop in new deaths after vaccination 

WITH first_vaccination  AS
(
    SELECT
    country,
    MIN(date) AS first_vaccination_date
    FROM dbo.Covid_Clean
    WHERE
    continent IS NOT NULL 
    AND people_fully_vaccinated_per_hundred > 0
    GROUP BY country
),
before_after AS
(
    SELECT 
    c.country,

    AVG(CASE WHEN c.date < f.first_vaccination_date THEN c.new_deaths END) AS avg_new_deaths_before, 
    AVG(CASE WHEN c.date > f.first_vaccination_date THEN c.new_deaths END) AS avg_new_deaths_after

    FROM dbo.Covid_Clean AS c
    INNER JOIN first_vaccination AS f
    ON c.country = f.country
    GROUP BY c.country
)

SELECT TOP 10 
country,
avg_new_deaths_before,
avg_new_deaths_after, 
(avg_new_deaths_before - avg_new_deaths_after) AS reduction_after_vaccination

FROM before_after
WHERE avg_new_deaths_before IS NOT NULL
AND avg_new_deaths_after IS NOT NULL 
AND (avg_new_deaths_before - avg_new_deaths_after) > 0
ORDER BY reduction_after_vaccination DESC ; 

---- 4. Socio-Economic Drivers of COVID Exposure

-- GDP per capita vs total cases per million (latest date per country)

WITH latest_valid_date AS
(
    SELECT
    country,
    MAX(date) AS last_date
    FROM dbo.Covid_Clean
    WHERE continent IS NOT NULL
    AND gdp_per_capita IS NOT NULL
    AND total_cases_per_million IS NOT NULL
    GROUP BY country
)
SELECT
c.country,
c.gdp_per_capita,
c.total_cases_per_million
FROM dbo.Covid_Clean AS c
INNER JOIN latest_valid_date AS l
ON c.country = l.country
AND c.date = l.last_date
WHERE 
c.continent IS NOT NULL
ORDER BY country;

-- Median age vs total deaths per million

WITH latest_valid_date AS
(
    SELECT
    country,
    MAX(date) AS last_date
    FROM dbo.Covid_Clean
    WHERE continent IS NOT NULL
    AND median_age IS NOT NULL
    AND total_deaths_per_million IS NOT NULL
    GROUP BY country
)
SELECT
c.country,
c.median_age,
c.total_deaths_per_million
FROM dbo.Covid_Clean AS c
INNER JOIN latest_valid_date AS l
ON c.country = l.country
AND c.date = l.last_date
WHERE 
c.continent IS NOT NULL
ORDER BY country;

-- Population density vs total_cases_per_million

WITH latest_values AS
(
SELECT 
country, 
MAX(population_density) AS population_density_final,
MAX(total_cases_per_million) AS total_cases_per_million_final
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
    AND population_density IS NOT NULL
    AND total_cases_per_million IS NOT NULL
GROUP BY country
)
SELECT
    country,
    population_density_final AS population_density,
    total_cases_per_million_final AS total_cases_per_million

FROM latest_values
ORDER BY country;

-- Life expectancy vs total deaths per million

WITH latest_values AS
(
SELECT
country,
MAX(life_expectancy) AS life_expectancy_final,
MAX(total_deaths_per_million) AS total_deaths_per_million_final
FROM dbo.Covid_Clean
WHERE continent IS NOT NULL
    AND life_expectancy IS NOT NULL
    AND total_deaths_per_million IS NOT NULL
GROUP BY country
)
SELECT
country,
life_expectancy_final AS life_expectancy,
total_deaths_per_million_final AS total_deaths_per_million
FROM latest_values
ORDER BY country;

---- 5.Policy Stringency and Spread Dynamics

-- Stringency index volatility by country 

SELECT
    country,
    AVG(stringency_index) AS avg_stringency_index,
    STDEV(stringency_index) AS volatility_stringency_index
FROM dbo.Covid_Clean
WHERE 
    continent IS NOT NULL
    AND stringency_index IS NOT NULL
GROUP BY country
ORDER BY volatility_stringency_index DESC;

-- Countries with consistently high average stringency index

SELECT
    country,
    AVG(stringency_index) AS avg_stringency_index
FROM dbo.Covid_Clean
WHERE 
    continent IS NOT NULL
    AND stringency_index IS NOT NULL
GROUP BY country
HAVING AVG(stringency_index) >= 50
ORDER BY avg_stringency_index DESC, country;

-- Stringency index vs new cases smoothed

WITH latest_values AS
(
    SELECT
    country,
    MAX(stringency_index) AS stringency_index_final,
    MAX(new_cases_smoothed) AS new_cases_smoothed_final
    FROM dbo.Covid_Clean
    WHERE continent IS NOT NULL
    AND stringency_index IS NOT NULL
    AND new_cases_smoothed IS NOT NULL
    GROUP BY country
)

SELECT
country,
stringency_index_final AS stringency_index,
new_cases_smoothed_final AS new_cases_smoothed
FROM latest_values
ORDER BY country;


