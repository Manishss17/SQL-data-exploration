select *from Portproject..CovidDeaths$
order by 3,4

select *from Portproject..CovidVaccinations$
order by 3,4

Select location,date,total_cases, new_cases, total_deaths, population from Portproject..CovidDeaths$ 
order by 1,2

--Finding total cases vs total deaths

Select location,date,total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercent 
from Portproject..CovidDeaths$ 
where location='India'
order by 1,2

--Total cases vs population

Select location,date,total_cases, population, (total_cases/population)*100 as infectionpercent 
from Portproject..CovidDeaths$ 
where location='India'
order by 1,2


--To find countries with highest infection rates

Select location, max(total_cases/population)*100 as Highestinfectionpercent 
from Portproject..CovidDeaths$ 
group by location
order by Highestinfectionpercent desc


--Countries with highest death count per population

Select location, max(cast(total_deaths as int)) as Totaldeathcount
from Portproject..CovidDeaths$
where continent is not null
group by location
order by Totaldeathcount desc


--Let us explore data by continent

Select continent, max(cast(total_deaths as int)) as Totaldeathcount
from Portproject..CovidDeaths$
where continent is not null
group by continent
order by Totaldeathcount desc


--Join covid deaths and covid vaccinations tables

select *
from Portproject..CovidDeaths$ de
join Portproject..CovidVaccinations$ va
on de.location=va.location
and de.date=va.date


--looking for total population vs vaccination
--USE CTE

with PopvsVa (continent, location, date, population, new_vaccinations, rollingpeoplevaccinated)
as
(
select de.continent, de.location, de.date, de.population, va.new_vaccinations,
SUM(Convert(int, va.new_vaccinations)) over (partition by de.location order by de.location,
de.date) as rollingpeoplevaccinated
from Portproject..CovidDeaths$ de
join Portproject..CovidVaccinations$ va
	on de.location=va.location
	and de.date=va.date
where de.continent is not null
)





