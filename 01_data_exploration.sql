-- cek database
select database();
select * from ds_salaries;

-- cek tabel
show tables;

-- hitung baris dalam tabel
select count(*) as total_baris from ds_salaries;

-- memhami tipe data
describe ds_salaries;

-- cek data duplicate
select count(*) as total_duplicte from ds_salaries
group by work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size
having count(*) > 1;

-- jabatan kerja dan jumlah karyawanya
select experience_level, count(*) as total_pekerja from ds_salaries
group by experience_level
order by total_pekerja desc;

-- mengecek nilai null
select
	count(*) as total_baris,
    sum(work_year is null) as null_worker,
    sum(experience_level is null) as null_experience_level,
    sum(job_title is null) as null_job_title,
    sum(salary_in_usd is null) as null_salary,
    sum(salary is null) as null_gaji,
    sum(salary_currency is null) as null_currency_salary,
    sum(employee_residence is null) as null_residence,
    sum(remote_ratio is null) as null_remote_ratio,
    sum(company_location is null) as null_company,
    sum(company_size is null) as null_cumpany_size
from ds_salaries;

-- cek duplikat lagi
select work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size, count(*) as jumlah_muncul from ds_salaries
group by work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size
having count(*) > 1
order by jumlah_muncul;

-- berapa baris yang terlibat duplikasi
SELECT
    SUM(jumlah_kemunculan) AS total_baris_dalam_grup_duplikat,
    COUNT(*) AS jumlah_grup_duplikat,
    SUM(jumlah_kemunculan - 1) AS perkiraan_baris_berlebih
FROM (
    SELECT COUNT(*) AS jumlah_kemunculan
    FROM ds_salaries
    GROUP BY
        work_year,
        experience_level,
        employment_type,
        job_title,
        salary,
        salary_currency,
        salary_in_usd,
        employee_residence,
        remote_ratio,
        company_location,
        company_size
    HAVING COUNT(*) > 1
) AS d;

-- rata rata gaji dalam usd di data anylsis
select
	job_title, 
    count(*) as total_dicatat,
    round(avg(salary_in_usd), 2) as rata_gaji_usd
from ds_salaries
where job_title = 'Data Scientist'
order by job_title;

-- rata gaji berdasarkan tipe pekerjaan
select 
	experience_level,
    employment_type,
    count(*) as total_dicatat, round(avg(salary_in_usd)) as rata_gaji_usd
from ds_salaries
group by experience_level, employment_type
order by rata_gaji_usd desc;
-- order by experience_level, employment_type;

-- rata gaji berdasrkan experiencenya
select
	experience_level,
    count(*) as total_dicatat, round(avg(salary_in_usd), 2) as rata_gaji_usd
from ds_salaries
group by experience_level 
order by rata_gaji_usd desc;

-- analisi gaji berdasarkan lokasi yang data analyze
select
	company_location,
    count(*) as total_dicatat, round(avg(salary_in_usd), 2) as rata_gaji_usd
from ds_salaries
where lower(job_title) like '%data analyst%' and employment_type = 'FT' and experience_level in('EN', 'MI')
group by company_location
having count(*) >= 5
order by rata_gaji_usd desc;

-- meelihat apakah rata rata gaji analisis naik tiap tahun
select 
	work_year,
    count(*) as total_dicatat, round(avg(salary_in_usd), 2) as rata_gaji_usd
from ds_salaries
where lower(job_title) like '%data analyst%'
group by work_year
order by work_year;

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





