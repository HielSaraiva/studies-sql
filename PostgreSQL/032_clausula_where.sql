-- Exibir principais linhas de dados com LIMIT
SELECT
   *
FROM
   waterfall
LIMIT
   10;

-- Predicados
SELECT
   id,
   name
FROM
   waterfall
WHERE
   name NOT LIKE '%Falls%';

-- Vários predicados
SELECT
   id,
   name
FROM
   waterfall
WHERE
   name NOT LIKE '%Falls%'
   AND owner_id IS NULL;

-- Filtrando em subconsultas
SELECT
   w.name
FROM
   waterfall AS w
WHERE
   w.open_to_public = 'y'
   AND w.county_id IN (
      SELECT
         c.id
      FROM
         county AS c
      WHERE
         c.name = 'Cook'
   );