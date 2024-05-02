#WORLD LAYOFFS CLAEANING
SELECT*
FROM world_layoffs.layoffs;
#REMOVE DUPLICATES
#STANDARDIZE THE DATA
#NULL VALES
#REMOVE COLUMNS

CREATE TABLE world_layoffs.layoffs_Staging#Create a new table for Layoffs
like world_layoffs.layoffs;

SELECT*
FROM world_layoffs.layoffs_Staging;

Insert world_layoffs.layoffs_Staging #Insert records/obeservations
select*
from world_layoffs.layoffs;

#Identify Duplicates
SELECT*,
Row_number() Over(
partition by company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
FROM world_layoffs.layoffs_Staging;

With duplicate_Cte as
(
SELECT*,
Row_number() Over(
partition by company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
FROM world_layoffs.layoffs_Staging
)
Select*
from duplicate_CTE
where row_num >1;

With duplicate_Cte as
(
SELECT*,
Row_number() Over(
partition by company,industry,total_laid_off,percentage_laid_off,`date`,funds_raised_millions,country,stage) as row_num
FROM world_layoffs.layoffs_Staging
)
Select*
from duplicate_CTE
where row_num >1;

With duplicate_Cte as
(
SELECT*,
Row_number() Over(
partition by company,industry,total_laid_off,percentage_laid_off,`date`,funds_raised_millions,country,stage) as row_num
FROM world_layoffs.layoffs_Staging
)
Select*
from duplicate_CTE
where row_num >1;

SELECT*,
Row_number() Over(
partition by company,industry,total_laid_off,percentage_laid_off,`date`,funds_raised_millions,country,stage) as row_num
FROM world_layoffs.layoffs_Staging;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select*
from layoffs_staging2
WHERE row_num>1;

INSERT INTO layoffs_staging2
SELECT*,
Row_number() Over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,funds_raised_millions,country,stage) as row_num
FROM world_layoffs.layoffs_Staging;

Delete
from layoffs_staging2
where row_num>1;

#Standardize data
Select Distinct(trim(company))#to get rid of unnecessary space
from layoffs_staging2;

Update layoffs_staging2
set company=(trim(company));

Select Distinct industry#to get rid of unnecessary space
from layoffs_staging2
order by 1;

Select*
from layoffs_staging2
where industry like 'Crypto%'
order by industry desc;

Update layoffs_staging2
set industry='crypto'
where industry like 'Crypto%'

Select*
from layoffs_staging2
where industry like 'Crypto%'
order by industry desc;

Select distinct(industry)
from layoffs_staging2;

Select distinct country, trim(trailing '.' from country)#trailing means we are looking for something in this case a period
from layoffs_staging2
order by 1;

Update layoffs_staging2
set country=trim(trailing '.' from country)
where country like 'united states%';

Select distinct country
from layoffs_staging2;

Select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

Update layoffs_staging2
set `date`=str_to_date(`date`,'%m/%d/%Y');

Select 
`date`
from layoffs_staging2;

#Convert table to date format when previously it was string
Alter Table layoffs_staging2
Modify Column `date` Date;

Select t1.industry,t2.industry
from layoffs_staging2 t1
join  layoffs_staging2 t2
on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

Update layoffs_staging2
set industry =null
where industry='';

Update layoffs_staging2 t1
join  layoffs_staging2 t2
on t1.company=t2.company
set t1.industry=t2.industry
where (t1.industry is null or t1.industry='')#basically when t1 is blank and t2 isn't t1 should be the same as t2
and t2.industry is not null;

Alter Table layoffs_staging2 
Drop Column row_num;

Select *
from layoffs_staging2;

