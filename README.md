# Data Science Job Salaries — SQL Analysis

## Project Overview

This project explores the Data Science Job Salaries dataset using MySQL to investigate salary patterns across experience levels, employment types, job roles, company locations, and work years.

The project demonstrates SQL skills in data exploration, data quality checks, aggregation, filtering, Common Table Expressions (CTEs), window functions, and JOIN operations.

## Objectives

- Explore the dataset structure and record distribution.
- Check for missing values and duplicate records.
- Compare average salaries across experience levels and employment types.
- Analyze Data Analyst salaries by company location.
- Examine annual salary trends from 2020 to 2022.
- Compare Mid-level and Senior Data Analyst salaries over time.

## Dataset

- **Name:** Data Science Job Salaries
- **Source:** [Kaggle — Data Science Job Salaries](https://www.kaggle.com/datasets/ruchi798/data-science-job-salaries)
- **Records:** 607
- **Original columns:** 11
- **SQL tool:** MySQL Workbench

The dataset includes work year, experience level, employment type, job title, salary, salary currency, salary in USD, employee residence, remote ratio, company location, and company size.

## SQL Skills Demonstrated

- `SELECT`, `WHERE`, `LIKE`, and `ORDER BY`
- Aggregate functions: `COUNT()`, `AVG()`, and `SUM()`
- `GROUP BY` and `HAVING`
- NULL and duplicate checks
- Common Table Expressions (CTEs)
- Window functions using `LAG()`
- `JOIN` for year-over-year salary comparisons

## Key Findings

- Executive-level records had the highest average salary among the four experience levels in the dataset.
- For full-time Data Analyst records at entry and mid levels, the United States had the highest average salary among the countries returned by the analysis, subject to a minimum of five records per country.
- The average salary for Data Analyst-related job titles increased from USD 58,838.69 in 2020 to USD 98,760.49 in 2022.
- The year-over-year average salary growth in the filtered records was 59.49% in 2021 and 5.24% in 2022.
- In the full-time Data Analyst comparison, the Senior-to-Mid-level average salary gap was larger in 2022 than in 2021.

## Limitations

- The dataset covers 2020–2022 and should not be interpreted as a representation of the current salary market.
- Salary averages can be affected by sample size, job composition, country, and employment type.
- Duplicate-looking records were identified for investigation; they were not automatically removed.
- The findings describe the available records and do not establish causal relationships.

## Author
Created as a SQL portfolio project to practice data exploration, data quality assessment, and salary analysis using MySQL.
