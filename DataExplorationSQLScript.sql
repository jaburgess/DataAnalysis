
select * 
from SQLDataExploration..CovidDeaths 
order by 1,3


select location,date,total_cases,new_cases, total_deaths, population
from SQLDataExploration..CovidDeaths
order by 1,2


--Changing some datatypes in order to preform operations
--data downloaded had datatypes that were not functional for my project

--SELECT total_deaths
--FROM SQLDataExploration..CovidDeaths
--WHERE total_deaths IS NOT NULL
--AND ISNUMERIC(total_deaths) = 0

--SELECT total_cases
--FROM SQLDataExploration..CovidDeaths
--WHERE total_cases IS NOT NULL
--AND ISNUMERIC(total_cases) = 0

--ALTER TABLE SQLDataExploration..CovidDeaths
--ALTER COLUMN total_deaths FLOAT;

--ALTER TABLE SQLDataExploration..CovidDeaths
--ALTER COLUMN total_cases FLOAT;


--Total Cases and Total Deaths
--Display Chance of Death in United States

select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as PercentDeaths
from SQLDataExploration..CovidDeaths
where location  = 'United States'
order by 1,2

--Total Cases and Population
--Display Percent of Population with Covid

select location,date,total_cases,population, (total_cases/population)*100 as PercentPopCovid
from SQLDataExploration..CovidDeaths
where location  = 'United States'
order by 1,2

-- Countries with Highest Covid Case Rate compared to Population
-- Note some inconsistencies with PercentPopulationCases as one person can account for multiple cases

Select Location, Population, MAX(total_cases) as CasesCount,  Max((total_cases/population))*100 as PercentPopulationCases
From SQLDataExploration..CovidDeaths
Group by Location, Population
order by PercentPopulationCases desc 

-- Top 20 Countries with Highest Covid Case Rate compared to Population
-- Note some inconsistencies with PercentPopulationCases as one person can account for multiple cases

Select top 20 
Location, Population, MAX(total_cases) as CasesCount,  Max((total_cases/population))*100 as PercentPopulationCases
From SQLDataExploration..CovidDeaths
Group by Location, Population
order by PercentPopulationCases desc 

--Countries with highest Death Count in relation to Population

Select Location, MAX(total_deaths) as TotalDeathCount
From SQLDataExploration..CovidDeaths
where continent is not null
Group by Location
order by TotalDeathCount desc 

-- Contintents with the highest death count per population

Select location, MAX(total_deaths) as TotalDeathCount
From SQLDataExploration..CovidDeaths
where continent is null
Group by location
order by TotalDeathCount desc 

--Contintents with the highest death count per population
--Excludes some additional 'locations' that the above query had

Select location, MAX(total_deaths) as TotalDeathCount
From SQLDataExploration..CovidDeaths
where continent is null
and location not in ('World','High Income','Upper middle income','Lower middle income','European Union','Low income')
Group by location
order by TotalDeathCount desc 

--Total worldwide cases, deaths and percentage of cases resulting in death

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From SQLDataExploration..CovidDeaths
where continent is not null 
--Group By date
order by 1,2


-- Total Population and Population that is Vaccinated

select deaths.continent, deaths.location, deaths.date, deaths.population, vaccinations.new_vaccinations
from SQLDataExploration..CovidDeaths as deaths
join 
SQLDataExploration..CovidVaccinations as vaccinations
on deaths.location = vaccinations.location and deaths.date = vaccinations.date
where deaths.continent is not null
order by 2,3

--Number of new vaccinations by date and by country with rolling total of vaccinations

Select deaths.continent, deaths.location, deaths.date, deaths.population, vaccination.new_vaccinations
, SUM(cast(vaccination.new_vaccinations as bigint)) 
OVER (Partition by deaths.Location Order by deaths.location, deaths.Date) as RollingVaccinated
From SQLDataExploration..CovidDeaths deaths
Join SQLDataExploration..CovidVaccinations vaccination
	On deaths.location = vaccination.location
	and deaths.date = vaccination.date
where deaths.continent is not null 
--and deaths.location = 'United States'
order by 2,3

--Incorporate CTE to get rolling percentage of populaiton vaccintated by date and by country 

With populationVsVac (continent, location,date,population,new_vaccinations, RollingVaccinated)
as (
Select deaths.continent, deaths.location, deaths.date, deaths.population, vaccination.new_vaccinations
, SUM(cast(vaccination.new_vaccinations as bigint)) 
OVER (Partition by deaths.Location Order by deaths.location, deaths.Date) as RollingVaccinated
From SQLDataExploration..CovidDeaths deaths
Join SQLDataExploration..CovidVaccinations vaccination
	On deaths.location = vaccination.location
	and deaths.date = vaccination.date
where deaths.continent is not null 
--and deaths.location = 'United States'

)
Select * , (RollingVaccinated/population)*100 as RollingPercentVaccinated from populationVsVac


--Using Temp Table to create same output as previous query
--Gets rolling percentage of populaiton vaccintated by date and by country

DROP Table if exists #PercentVaccinated
Create Table #PercentVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentVaccinated
Select deaths.continent, deaths.location, deaths.date, deaths.population, vaccinations.new_vaccinations
, SUM(cast(vaccinations.new_vaccinations as bigint)) OVER (Partition by deaths.Location Order by deaths.location, deaths.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From SQLDataExploration..CovidDeaths deaths
Join SQLDataExploration..CovidVaccinations vaccinations
	On deaths.location = vaccinations.location
	and deaths.date = vaccinations.date
where deaths.continent is not null 
and deaths.location = 'United States'

Select *, (RollingPeopleVaccinated/Population)*100 as RollingPercentVaccinated
From #PercentVaccinated


--Views for later visualization

create view percentPopulationVaccinated as 
select deaths.continent, deaths.location, deaths.date, deaths.population, vaccinations.new_vaccinations
, SUM(cast(vaccinations.new_vaccinations as bigint)) OVER (Partition by deaths.Location Order by deaths.location, deaths.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From SQLDataExploration..CovidDeaths deaths
Join SQLDataExploration..CovidVaccinations vaccinations
	On deaths.location = vaccinations.location
	and deaths.date = vaccinations.date
where deaths.continent is not null 
--and deaths.location = 'United States'

select * from percentPopulationVaccinated

