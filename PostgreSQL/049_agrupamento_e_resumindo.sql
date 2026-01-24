-- Agrupando por várias colunas
SELECT name, MAX(population) as max_population
FROM county
GROUP BY name;

-- Agrupando por uma coluna e resumindo com várias funções agregadas
SELECT name, 
       COUNT(*) as total_counties,
       AVG(population) as avg_population,
       SUM(population) as total_population
FROM county
GROUP BY name;
