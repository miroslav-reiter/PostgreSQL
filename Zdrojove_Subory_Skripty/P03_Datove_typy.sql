SELECT continent, sum(population) as "Pocet obyvatelov Zeme"
FROM public.world
group by continent
order by sum(population) DESC
limit 3;

SELECT continent, count(population) as "Pocet krajin Zeme"
FROM public.world
group by continent
order by count(population) DESC

