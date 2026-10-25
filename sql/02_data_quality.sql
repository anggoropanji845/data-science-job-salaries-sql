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
