-- Selecionando colunas
SELECT
   id,
   name
FROM
   owner;

-- Selecionando todas as colunas
SELECT
   * -- Arriscado usar em produção, pois pode ocorrer alguma alteração na tabela
FROM
   owner;

-- Selecionando expressões
SELECT
   name,
   ROUND(population * 0.9, 0)
FROM
   county;

-- Selecionando funções
SELECT
   CURRENT_DATE;

-- Atribuindo Aliases a colunas
SELECT
   id AS county_id,
   name,
   ROUND(population * 0.9, 0) AS estimated_pop
FROM
   county;

-- Qualificando colunas
SELECT
   owner.id,
   owner.name
FROM
   owner;

-- Qualificando tabelas
SELECT
   public.owner.id,
   public.owner.name -- usando o schema
FROM
   public.owner;

-- Aliases de tabela
SELECT
   c.name,
   c.population
FROM
   county as c;

-- Selecionando subconsultas
SELECT
   id,
   name,
   population,
   (
      SELECT
         AVG(population)
      FROM
         county
   ) AS average_pop -- Subconsulta não correlacionada
FROM
   county;

-- Problemas de desempenho das subconsultas correlacionadas
SELECT
   o.id,
   o.name,
   (
      SELECT
         COUNT(*)
      FROM
         waterfall AS w -- Ruim, pois executa a subconsulta para cada linha de dados
      WHERE
         o.id = w.owner_id
   ) AS num_waterfalls
FROM
   owner AS o;

SELECT
   o.id,
   o.name,
   COUNT(w.id) AS num_waterfalls -- Mais otimizado, primeiro faz o JOIN, depois faz a consulta
FROM
   owner AS o
   LEFT JOIN waterfall AS w ON o.id = w.owner_id
GROUP BY
   o.id,
   o.name;

-- DISTINCT
SELECT
   o.type,
   w.open_to_public
FROM
   owner AS o
   JOIN waterfall AS w ON o.id = w.owner_id;

SELECT ALL
   o.type,
   w.open_to_public
FROM
   owner AS o
   JOIN waterfall AS w ON o.id = w.owner_id;

SELECT DISTINCT
   o.type,
   w.open_to_public
FROM
   owner AS o
   JOIN waterfall AS w ON o.id = w.owner_id;

-- COUNT e DISTINCT
SELECT
   COUNT(DISTINCT type) AS unique_value
FROM
   owner;