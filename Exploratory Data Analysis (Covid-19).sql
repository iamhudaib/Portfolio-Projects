--COVID DEATHS

Select *
From PortfolioProjects..CovidDeaths
Order by 3,4

--Drop the rows where continent is null

Select *
From PortfolioProjects..CovidDeaths
Where continent is not null
Order by 3,4

--Select Data that we are going to use

Select Location,date,total_cases,new_cases,total_deaths,population
From PortfolioProjects..CovidDeaths
Where continent is not null
Order by 1,2

--BASED ON COUNTRY

--Country Wise Total Cases vs Total Deaths (Death Percentage)

Select Location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProjects..CovidDeaths
Where continent is not null
Order by 1,2

--United States (Death Percentage)

Select Location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProjects..CovidDeaths
Where location like '%states%'
and continent is not null
Order by 1,2

--Country Wise Total Cases vs Population (Population Infected Percentage)

Select Location,date,Population,total_cases,(total_cases/population)*100 as PopulationInfectedPercentage
From PortfolioProjects..CovidDeaths
Where continent is not null
Order by 1,2

--India (Population Infected Percentage)

Select Location,date,Population,total_cases,(total_cases/population)*100 as PopulationInfectedPercentage
From PortfolioProjects..CovidDeaths
Where location like 'India'
and continent is not null
Order by 1,2

--Countries with Highest Infection Rate compared to Population

Select location, Max(total_cases) as HighestInfectionRate, (Max(total_cases))/Population*100 as PopulationInfectedPercentage
From PortfolioProjects..CovidDeaths
Where continent is not null
Group by location,population
order by PopulationInfectedPercentage desc

--Countries with Highest Death Count 
--(Here Max(total_deaths) are in varchar so cast it into int)

Select location, Max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProjects..CovidDeaths
Where continent is not null
Group by location
order by TotalDeathCount desc

--BASED ON CONTINENT

--Countries with Highest Death Count 

Select continent, Max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProjects..CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

--GLOBAL NUMBERS

--Date Wise Death Percentage

Select date, SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, 
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProjects..CovidDeaths
Where continent is not null
Group by date
Order by 1,2


--COVID VACCINATIONS

Select *
From PortfolioProjects..CovidVaccinations
Order by 3,4

--Join Both Tables on Location,Date

Select *
From PortfolioProjects..CovidDeaths dea
JOIN PortfolioProjects..CovidVaccinations vac
On dea.location = vac.location 
and dea.date = vac.date

--Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProjects..CovidDeaths dea
Join PortfolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

--Rolling People Vaccinated

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int))
OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProjects..CovidDeaths dea
Join PortfolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

--Creating a View to Store Data for Visualizations

Create View PopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int))
OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProjects..CovidDeaths dea
Join PortfolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 


