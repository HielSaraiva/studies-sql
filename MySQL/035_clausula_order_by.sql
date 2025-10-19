SELECT
   COALESCE(o.name, 'Unknown') AS owner,
   w.name AS waterfall_name
FROM
   waterfall AS w
   LEFT JOIN owner AS o ON w.owner_id = o.id;

-- Ordenando
SELECT
   COALESCE(o.name, 'Unknown') AS owner,
   w.name AS waterfall_name
FROM
   waterfall AS w
   LEFT JOIN owner AS o ON w.owner_id = o.id
ORDER BY
   owner,
   waterfall_name;

-- DESC e ASC
SELECT
   COALESCE(o.name, 'Unknown') AS owner,
   w.name AS waterfall_name
FROM
   waterfall AS w
   LEFT JOIN owner AS o ON w.owner_id = o.id
ORDER BY
   owner DESC,
   waterfall_name ASC;

-- Posição numérica da coluna
SELECT
   COALESCE(o.name, 'Unknown') AS owner,
   w.name AS waterfall_name
FROM
   waterfall AS w
   LEFT JOIN owner AS o ON w.owner_id = o.id
ORDER BY
   1 DESC,
   2 ASC;

/*
   Order by não pode ser usado em subconsultas
*/