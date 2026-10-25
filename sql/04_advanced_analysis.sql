-- upgrade
with gaji_tahunan as (
	select work_year,
		count(*) as total_dicatat,
		avg(salary_in_usd) as gaji_usd
    from ds_salaries
    where lower(job_title) like '%data analyst%'
    group by work_year
)
select 
	work_year,
    total_dicatat,
    round(gaji_usd, 2) as gaji_usd,
    round(lag(gaji_usd) over (order by work_year), 2) as gaji_sebelumnya,
    round(
		(
			(gaji_usd - lag(gaji_usd) over (order by work_year))
			/nullif(lag(gaji_usd) over (order by work_year), 0)
            )* 100,
            2
		) as pertumbuhan
from gaji_tahunan
order by work_year;

-- join
WITH salary_by_level AS (
    SELECT
        work_year,
        experience_level,
        COUNT(*) AS total_records,
        AVG(salary_in_usd) AS avg_salary_usd
    FROM ds_salaries
    WHERE LOWER(job_title) LIKE '%data analyst%'
      AND employment_type = 'FT'
      AND experience_level IN ('MI', 'SE')
    GROUP BY work_year, experience_level
)
SELECT
    mi.work_year,
    mi.avg_salary_usd AS avg_mid_salary,
    se.avg_salary_usd AS avg_senior_salary,
    ROUND(
        se.avg_salary_usd - mi.avg_salary_usd,
        2
    ) AS salary_difference
FROM salary_by_level AS mi
JOIN salary_by_level AS se
    ON mi.work_year = se.work_year
WHERE mi.experience_level = 'MI'
  AND se.experience_level = 'SE'
ORDER BY mi.work_year;

-- revisi 
WITH salary_by_level AS (
    SELECT
        work_year,
        experience_level,
        COUNT(*) AS total_records,
        AVG(salary_in_usd) AS avg_salary_usd
    FROM ds_salaries
    WHERE LOWER(job_title) LIKE '%data analyst%'
      AND employment_type = 'FT'
      AND experience_level IN ('MI', 'SE')
    GROUP BY work_year, experience_level
)
SELECT
    mi.work_year,
    mi.total_records AS records_mid,
    se.total_records AS records_senior,
    ROUND(mi.avg_salary_usd, 2) AS avg_mid_salary,
    ROUND(se.avg_salary_usd, 2) AS avg_senior_salary,
    ROUND(
        se.avg_salary_usd - mi.avg_salary_usd,
        2
    ) AS salary_difference
FROM salary_by_level AS mi
JOIN salary_by_level AS se
    ON mi.work_year = se.work_year
WHERE mi.experience_level = 'MI'
  AND se.experience_level = 'SE'
ORDER BY mi.work_year;
