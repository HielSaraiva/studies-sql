-- group by
SELECT
   t.name AS tour_name,
   COUNT(*) AS num_waterfalls
FROM
   waterfall AS w
   INNER JOIN tour AS t ON w.id = t.stop
GROUP BY
   t.name;