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
