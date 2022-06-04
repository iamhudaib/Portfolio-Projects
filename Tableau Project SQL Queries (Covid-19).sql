--GLOBAL DEATH PERCENTAGE

Select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, 
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProjects..CovidDeaths
Where continent is not null
Order by 1,2


--TOTAL DEATH COUNT PER CONTINENT

Select location, SUM(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProjects..CovidDeaths
Where continent is null
and location not in ('World','European Union','International')
and location not like '%income'
Group by location
order by TotalDeathCount desc


--COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION 

Select location,population, Max(total_cases) as HighestInfectionRate, (Max(total_cases))/Population*100 as PopulationInfectedPercentage
From PortfolioProjects..CovidDeaths
Where continent is not null
Group by location,population
order by PopulationInfectedPercentage desc


--HIGHEST INFECTION RATE COMPARED TO POPULATION GROUP BY DATE

Select location,population,date, Max(total_cases) as HighestInfectionRate, (Max(total_cases))/Population*100 as PopulationInfectedPercentage
From PortfolioProjects..CovidDeaths
Where continent is not null
Group by location,population,date
order by PopulationInfectedPercentage desc