

Select *
From PortfolioProject..CovidDeaths
--where continent is not null
--Order by 3,4

Select *
From PortfolioProject..CovidVaccinations
--
--Exec sp_help 'dbo.CovidDeaths'

-- Select Data that we are going to be using 

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
where continent is not null
Order by 1,2

-- Looking at Total cases vs Total Deaths 
-- Shows likelihood of dying from Covid
-- Handled errors related to data type & NULLIF function returns NULL, thus preventing preventing the division by zero error

Select 
	location, 
	date, 
	total_cases, 
	total_deaths, 
	(CONVERT(float, total_deaths) / NULLIF(CONVERT(float,total_cases), 0)) * 100 AS DeathPercentage
FROM 
	PortfolioProject..CovidDeaths
WHERE location = 'United States' and continent is not null
Order by 1,2


-- Looking at Total cases vs Population 

Select 
	location, 
	date, 
	population,
	total_cases,  
	total_deaths / population * 100 as PercentagePolulationInfected
FROM 
	PortfolioProject..CovidDeaths
WHERE location = 'United States' and continent is not null
Order by 1,2


-- Looking at Countrries with Highest Infection Rate compared to Population 

Select 
	location,  
	population,
	MAX(total_cases) as HighestInfectionCount,
	ROUND(MAX(total_cases) / population,4) * 100 as PercentagePopulationInfected
FROM 
	PortfolioProject..CovidDeaths
where continent is not null
Group by location, population
Order by 4 DESC


-- Looking at countries Highest death count per population

Select 
	location,  
	MAX(total_deaths) as TotalDeathCount
FROM 
	PortfolioProject..CovidDeaths
where continent is NOT NULL
Group by location
Order by TotalDeathCount DESC;


------   

Select 
	location,  
	MAX(cast(total_deaths as int)) as TotalDeathCount
FROM 
	PortfolioProject..CovidDeaths
where location is NOT NULL
Group by location
Order by TotalDeathCount DESC;


--Global numbers

CREATE VIEW GlobalNumbers  as
SELECT
	--date,
	SUM(new_cases) AS total_new_cases, 
	SUM(new_deaths) AS total_new_deaths,
	SUM(new_deaths) * 100 / NULLIF(SUM(new_cases), 0) AS DeathPerentage
FROM	
	PortfolioProject..CovidDeaths
--GROUP BY 
	--date
--Order by 1,2










