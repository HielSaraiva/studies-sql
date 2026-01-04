-- Funções de agregação realizam cálculos em um conjunto de valores e retornam um único valor.
-- São frequentemente usadas com a cláusula GROUP BY para agrupar resultados.

-- Contar total de cachoeiras
SELECT COUNT(*) AS total_cachoeiras
FROM waterfall;

-- Contar cachoeiras abertas ao público
SELECT COUNT(*) AS cachoeiras_publicas
FROM waterfall
WHERE open_to_public = 'y';

-- Contar proprietários únicos (ignorando NULL)
SELECT COUNT(owner_id) AS cachoeiras_com_proprietario
FROM waterfall;

-- Contar valores distintos
SELECT COUNT(DISTINCT county_id) AS condados_com_cachoeiras
FROM waterfall;

-- Soma da população total de todos os condados
SELECT SUM(population) AS populacao_total
FROM county;

-- Soma da população dos condados que têm cachoeiras
SELECT SUM(c.population) AS populacao_com_cachoeiras
FROM county c
   INNER JOIN waterfall w ON c.id = w.county_id;

-- População média dos condados
SELECT AVG(population) AS populacao_media
FROM county;

-- População média dos condados com mais de 1 milhão de habitantes
SELECT AVG(population) AS populacao_media_grandes
FROM county
WHERE population > 1000000;

-- Arredondando a média
SELECT ROUND(AVG(population), 2) AS populacao_media_arredondada
FROM county;

-- Maior população entre os condados
SELECT MAX(population) AS maior_populacao
FROM county;

-- Nome do condado com maior população
SELECT name, population
FROM county
WHERE population = (SELECT MAX(population) FROM county);

-- Menor população entre os condados
SELECT MIN(population) AS menor_populacao
FROM county;

-- Nome do condado com menor população
SELECT name, population
FROM county
WHERE population = (SELECT MIN(population) FROM county);

-- Estatísticas gerais da população
SELECT 
   COUNT(*) AS total_condados,
   SUM(population) AS populacao_total,
   AVG(population) AS populacao_media,
   MIN(population) AS menor_populacao,
   MAX(population) AS maior_populacao,
   MAX(population) - MIN(population) AS diferenca
FROM county;

-- Contar cachoeiras por condado
SELECT 
   c.name AS condado,
   COUNT(w.id) AS quantidade_cachoeiras
FROM county c
   LEFT JOIN waterfall w ON c.id = w.county_id
GROUP BY c.id, c.name
ORDER BY quantidade_cachoeiras DESC;

-- Contar cachoeiras por tipo de proprietário
SELECT 
   o.type AS tipo_proprietario,
   COUNT(w.id) AS quantidade_cachoeiras
FROM owner o
   INNER JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.type;

-- Cachoeiras por status de abertura ao público
SELECT 
   CASE 
      WHEN open_to_public = 'y' THEN 'Aberta ao público'
      ELSE 'Fechada ao público'
   END AS status,
   COUNT(*) AS quantidade
FROM waterfall
GROUP BY open_to_public;

-- População total por condados que têm proprietários públicos ou privados
SELECT 
   o.type AS tipo_proprietario,
   COUNT(DISTINCT c.id) AS quantidade_condados,
   SUM(c.population) AS populacao_total
FROM owner o
   INNER JOIN waterfall w ON o.id = w.owner_id
   INNER JOIN county c ON w.county_id = c.id
GROUP BY o.type;

-- Condados com mais de 1 cachoeira
SELECT 
   c.name AS condado,
   COUNT(w.id) AS quantidade_cachoeiras
FROM county c
   INNER JOIN waterfall w ON c.id = w.county_id
GROUP BY c.id, c.name
HAVING COUNT(w.id) > 1
ORDER BY quantidade_cachoeiras DESC;

-- Proprietários com mais de 2 cachoeiras
SELECT 
   o.name AS proprietario,
   o.type AS tipo,
   COUNT(w.id) AS quantidade_cachoeiras
FROM owner o
   INNER JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name, o.type
HAVING COUNT(w.id) > 2
ORDER BY quantidade_cachoeiras DESC;

-- Condados com população acima da média
SELECT 
   name,
   population,
   population - (SELECT AVG(population) FROM county) AS diferenca_da_media
FROM county
WHERE population > (SELECT AVG(population) FROM county)
ORDER BY population DESC;

-- Proprietários com mais cachoeiras que a média
SELECT 
   o.name AS proprietario,
   COUNT(w.id) AS quantidade_cachoeiras
FROM owner o
   INNER JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name
HAVING COUNT(w.id) > (
   SELECT AVG(qtd)
   FROM (
      SELECT COUNT(*) AS qtd
      FROM waterfall
      WHERE owner_id IS NOT NULL
      GROUP BY owner_id
   ) AS subquery
)
ORDER BY quantidade_cachoeiras DESC;

/*
1. MIN() e MAX() - FUNÇÕES DE AGREGAÇÃO
   - Operam em MÚLTIPLAS LINHAS (conjunto de valores verticais)
   - Retornam UM único valor de toda a coluna
   - Usadas com GROUP BY para agrupar dados
   - Exemplo: MIN(population) retorna a menor população de TODOS os condados

2. LEAST() e GREATEST() - FUNÇÕES DE COMPARAÇÃO
   - Operam em MÚLTIPLAS COLUNAS da MESMA LINHA (valores horizontais)
   - Retornam um valor POR LINHA
   - Comparam valores dentro de uma única linha
   - Exemplo: LEAST(valor1, valor2, valor3) retorna o menor entre esses 3 valores

RESUMO:
- MIN/MAX: Verticais (↓) - agregam múltiplas linhas em um resultado
- LEAST/GREATEST: Horizontais (→) - comparam múltiplos valores na mesma linha
*/