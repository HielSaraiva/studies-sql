-- Uma cláusula HAVING sempre vem imediatamente após uma GROUP BY
SELECT
   t.name AS tour_name,
   COUNT(*) AS num_waterfalls
FROM
   waterfall AS w
   INNER JOIN tour AS t ON w.id = t.stop
GROUP BY
   t.name
HAVING
   COUNT(*) > 1;

/*
Where é usado para filtrar em colunas específicas
Having filtra em agregações

*/