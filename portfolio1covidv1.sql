create database PortfolioProject
use PortfolioProject


select @@version



--drop table if exists [dbo].[CovidDeaths$]
Select * from [dbo].[CovidDeaths]
Select * from  [dbo].[CovidVaccinations]


Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathPercentage
from [dbo].[CovidDeaths]
order by 1,2

--

Select location, date,population, total_cases, (total_cases/population)*100 as deathPercentage
from [dbo].[CovidDeaths]
order by 1,2

--Countries with highest Infection rates/ population

Select location, population, max(total_cases) as highestInfectionCount, max((total_cases/population))*100 as percentOfPopulationInfected    
from [dbo].[CovidDeaths]
group by location, population
order by percentOfPopulationInfected desc

--Countries with highest death count / population

Select location, max(cast( total_deaths as int)) as totaldeathcount 
from [dbo].[CovidDeaths]
where continent is not null
group by location
order by totaldeathcount desc

--Break down by continent
--continents with highest death counts

Select continent, max(cast( total_deaths as int)) as totaldeathcount 
from [dbo].[CovidDeaths]
where continent is not null
group by continent
order by totaldeathcount desc

--Global numbers

Select  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathPercentage
from [dbo].[CovidDeaths]
where continent is not null
--group by date
order by 1,2

with cte (continent, location, date, population, new_vaccinations,rollingpeoplevaccinated)
as (
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations )) over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from PortfolioProject.dbo.CovidDeaths dea
inner join PortfolioProject.dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (rollingpeoplevaccinated/population)*100
from cte

--using temp table

drop table if exists #percentpopulationvaccinated
create table #percentpopulationvaccinated
(continent nvarchar(255),
location nvarchar(255), 
date datetime, 
population numeric, 
new_vaccinations  numeric,
rollingpeoplevaccinated numeric)

insert into #percentpopulationvaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations )) over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from PortfolioProject.dbo.CovidDeaths dea
inner join PortfolioProject.dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *, (rollingpeoplevaccinated/population)*100
from #percentpopulationvaccinated

create view percentpopulationvaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations )) over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from PortfolioProject.dbo.CovidDeaths dea
inner join PortfolioProject.dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null

Select * from percentpopulationvaccinated











