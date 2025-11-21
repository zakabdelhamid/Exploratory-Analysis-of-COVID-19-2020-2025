| Column Name                             | Definition                                                                 | Data Type |
|------------------------------------------|-------------------------------------------------------------------------------|-----------|
| country                                  | *Country name*                                                               | nvarchar  |
| continent                                | *Continent of the country*                                                   | nvarchar  |
| code                                     | *ISO country code*                                                           | nvarchar  |
| date                                     | *Observation date*                                                           | date      |
| total_cases                              | *Cumulative confirmed COVID-19 cases*                                        | float     |
| new_cases                                | *Daily new confirmed cases*                                                  | float     |
| new_cases_smoothed                       | *7-day smoothed new cases*                                                   | float     |
| total_deaths                             | *Cumulative confirmed COVID-19 deaths*                                       | float     |
| new_deaths                               | *Daily new confirmed deaths*                                                 | float     |
| new_deaths_smoothed                      | *7-day smoothed new deaths*                                                  | float     |
| total_cases_per_million                  | *Cumulative cases per million inhabitants*                                   | float     |
| new_cases_per_million                    | *Daily new cases per million inhabitants*                                    | float     |
| total_deaths_per_million                 | *Cumulative deaths per million inhabitants*                                  | float     |
| new_deaths_per_million                   | *Daily new deaths per million inhabitants*                                   | float     |
| population                               | *Total population*                                                           | float     |
| population_density                       | *Population per km²*                                                         | float     |
| median_age                               | *Median age of the population*                                               | float     |
| life_expectancy                          | *Life expectancy at birth*                                                   | float     |
| gdp_per_capita                           | *GDP per capita (international dollars)*                                     | float     |
| human_development_index                  | *HDI composite indicator*                                                    | float     |
| stringency_index                         | *Government response stringency score (0–100)*                               | float     |
| reproduction_rate                        | *Estimated COVID-19 reproduction rate*                                       | float     |
| total_tests                              | *Cumulative number of COVID-19 tests performed*                              | float     |
| new_tests                                | *Daily new tests performed*                                                  | float     |
| new_tests_smoothed                       | *7-day smoothed number of tests*                                             | float     |
| new_tests_smoothed_per_thousand          | *Smoothed daily tests per thousand inhabitants*                              | float     |
| total_tests_per_thousand                 | *Total tests per thousand inhabitants*                                       | float     |
| new_tests_per_thousand                   | *Daily tests per thousand inhabitants*                                       | float     |
| positive_rate                            | *Share of positive tests among all tests administered*                       | float     |
| tests_per_case                           | *Number of tests conducted per confirmed case*                               | float     |
| total_vaccinations                       | *Total vaccine doses administered*                                           | float     |
| people_vaccinated                        | *Number of people who received at least one dose*                            | float     |
| people_fully_vaccinated                  | *Number of people fully vaccinated*                                          | float     |
| total_boosters                           | *Total booster doses administered*                                           | float     |
| new_vaccinations                         | *Daily new vaccine doses administered*                                       | float     |
| new_vaccinations_smoothed                | *7-day smoothed vaccine doses*                                               | float     |
| total_vaccinations_per_hundred           | *Total doses administered per hundred inhabitants*                           | float     |
| people_vaccinated_per_hundred            | *People vaccinated (at least one dose) per hundred inhabitants*              | float     |
| people_fully_vaccinated_per_hundred      | *Fully vaccinated people per hundred inhabitants*                            | float     |
