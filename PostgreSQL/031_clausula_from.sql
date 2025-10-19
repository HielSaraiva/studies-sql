-- Várias tabelas
SELECT
   *
FROM
   waterfall AS w
   JOIN tour AS t ON w.id = t.stop;

-- Extraindo dados de subconsultas
SELECT
   w.name AS waterfall_name,
   o.name AS owner_name
FROM
   (
      SELECT
         *
      FROM
         owner
      WHERE
         type = 'public'
   ) AS o
   JOIN waterfall AS w ON o.id = w.owner_id;

-- Subconsultas com a cláusula WITH
WITH
   o AS (
      SELECT
         *
      FROM
         owner
      WHERE
         type = 'public'
   )
SELECT
   w.name AS waterfall_name,
   o.name AS owner_name
FROM
   o
   JOIN waterfall AS w ON o.id = w.owner_id;