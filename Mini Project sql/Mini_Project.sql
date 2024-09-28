create database IF NOT EXISTS unicorn_companies;
USE unicorn_companies;
create table unicorn(
id INT AUTO_INCREMENT PRIMARY KEY,
    company VARCHAR(255),
    country VARCHAR(100),
    sector VARCHAR(100),
    valuation DECIMAL(10, 2),
    founded_year INT,
    investors TEXT
);
select * from unicorn;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/unicorns.csv' INTO TABLE unicorn
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(company, country, sector, valuation, founded_year, investors);

select * from unicorn;

-- 1- Top 5 Countries by Number of Unicorns
select country, count(*) as count_of_countries
from unicorn
group by country
order by count_of_countries  desc
limit 5;

-- 2- Top 3 Sectors by Average Valuation:
select sector, avg(valuation) as average_valuation
from unicorn
group by sector
order by average_valuation desc
limit 3;

-- 3- Unicorns Founded After 2010
select * from  unicorn
where founded_year > 2010;
-- 4- Total Valuation of Unicorns in the FinTech Sector
select sector, sum(valuation) as total_valuation
from unicorn
where sector = "FinTech"
group by sector;

-- 5- Most Common Investors
SELECT investors, COUNT(*) AS investor_count
FROM unicorn
GROUP BY investors
ORDER BY investor_count DESC
LIMIT 1;

-- Explore trends in the data, such as the growth of unicorns in specific sectors or countries
SELECT sector, founded_year, COUNT(*) AS unicorn_count
FROM unicorn
GROUP BY sector, founded_year
ORDER BY founded_year ASC, unicorn_count DESC;

-- Which investors have the most unicorns in their portfolio?
SELECT investors, COUNT(*) AS investor_count
FROM unicorn
GROUP BY investors
ORDER BY investor_count DESC;


-- Compare valuations of companies founded in different decades to understand growth trends.
SELECT 
    CASE
        WHEN founded_year BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN founded_year BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN founded_year BETWEEN 2010 AND 2019 THEN '2010s'
        ELSE '2020s'
    END AS decade,
    AVG(valuation) AS average_valuation,
    COUNT(*) AS unicorn_count
FROM unicorn
GROUP BY decade
ORDER BY decade ASC;

