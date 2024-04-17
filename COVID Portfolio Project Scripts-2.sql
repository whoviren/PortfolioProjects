
-- Looking at Total Population vs Vaccinations

Select 
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	sum(vac.new_vaccinations) OVER (PARTITION BY dea.location Order by dea.location, dea.Date) 
	as RollingPeopleVaccinated
From
	PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		and dea.date = vac.date
ORDER BY 2,3


-- Use CTE 

With PopvsVac (Continent, Location, date, Population,new_vaccinations, RollingPeopleVaccinated)
as 
(
Select 
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	sum(vac.new_vaccinations) OVER (PARTITION BY dea.location Order by dea.location, dea.Date) 
	as RollingPeopleVaccinated
From
	PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		and dea.date = vac.date
--ORDER BY 2,3
)
Select *, 
	(RollingPeopleVaccinated/Population)*100  AS PercentageofPeopleVaccinated
FROM PopvsVac


-- TEMP TABLE 

Drop Table if exists #PercentagePopulationVaccinated
Create Table #PercentagePopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentagePopulationVaccinated
Select 
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	sum(vac.new_vaccinations) OVER (PARTITION BY dea.location Order by dea.location, dea.Date) 
	as RollingPeopleVaccinated
From
	PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		and dea.date = vac.date
--ORDER BY 2,3
Select *, 
	(RollingPeopleVaccinated/Population)*100  AS PercentageofPeopleVaccinated
FROM #PercentagePopulationVaccinated



--- Creating view to store data for later visualisations

Create view PercentagePopulationVaccinated AS
Select 
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	sum(vac.new_vaccinations) OVER (PARTITION BY dea.location Order by dea.location, dea.Date) 
	as RollingPeopleVaccinated
From
	PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		and dea.date = vac.date
--ORDER BY 2,3



