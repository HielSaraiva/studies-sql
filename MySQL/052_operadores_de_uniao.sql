-- OPERADORES DE UNIÃO (SET OPERATORS)

-- Os operadores de união combinam resultados de duas ou mais consultas SELECT
-- Requisitos:
-- 1. Mesmo número de colunas em todas as consultas
-- 2. Tipos de dados compatíveis nas colunas correspondentes
-- 3. Ordem das colunas deve ser a mesma

-- 1. UNION
-- Combina resultados e REMOVE duplicatas automaticamente
-- Listar todas as cachoeiras abertas e fechadas separadamente
SELECT 
    name AS waterfall_name,
    'Aberta ao público' AS status
FROM waterfall
WHERE open_to_public = 'y'

UNION

SELECT 
    name AS waterfall_name, 
    'Fechada ao público' AS status
FROM waterfall
WHERE open_to_public = 'n'
ORDER BY waterfall_name
LIMIT 20;

-- Combinar proprietários públicos e privados com identificação
SELECT 
    id,
    name,
    type,
    'Com telefone' AS phone_status
FROM owner
WHERE phone IS NOT NULL AND type = 'public'

UNION

SELECT 
    id,
    name,
    type,
    'Sem telefone' AS phone_status
FROM owner
WHERE phone IS NULL AND type = 'public'
ORDER BY name
LIMIT 15;

-- Listar condados populosos e cachoeiras em condados populosos
SELECT 
    'Condado' AS tipo,
    name AS nome,
    population AS info_numerica
FROM county
WHERE population > 2000000

UNION

SELECT 
    'Cachoeira' AS tipo,
    w.name AS nome,
    c.population AS info_numerica
FROM waterfall w
INNER JOIN county c ON w.county_id = c.id
WHERE c.population > 2000000
ORDER BY tipo, nome
LIMIT 20;

-- 2. UNION ALL
-- Combina resultados e MANTÉM duplicatas
-- Mais rápido que UNION porque não remove duplicatas

-- Comparação entre UNION e UNION ALL
-- Com UNION (remove duplicatas):
SELECT name FROM owner WHERE type = 'public'
UNION
SELECT name FROM owner WHERE phone IS NOT NULL
LIMIT 10;

-- Com UNION ALL (mantém duplicatas):
SELECT name FROM owner WHERE type = 'public'
UNION ALL
SELECT name FROM owner WHERE phone IS NOT NULL
LIMIT 20;

-- Exemplo prático: Consolidar dados de diferentes categorias
SELECT 
    'Tour' AS categoria,
    name AS item_nome,
    id AS item_id
FROM tour
WHERE id <= 10

UNION ALL

SELECT 
    'Cachoeira' AS categoria,
    name AS item_nome,
    id AS item_id
FROM waterfall
WHERE id <= 10

UNION ALL

SELECT 
    'Proprietário' AS categoria,
    name AS item_nome,
    id AS item_id
FROM owner
WHERE id <= 10
ORDER BY categoria, item_id;

-- Análise de dados: combinar totais por tipo
SELECT 
    'Cachoeiras Abertas' AS categoria,
    COUNT(*) AS total
FROM waterfall
WHERE open_to_public = 'y'

UNION ALL

SELECT 
    'Cachoeiras Fechadas' AS categoria,
    COUNT(*) AS total
FROM waterfall
WHERE open_to_public = 'n'

UNION ALL

SELECT 
    'Total de Cachoeiras' AS categoria,
    COUNT(*) AS total
FROM waterfall

UNION ALL

SELECT 
    'Total de Tours' AS categoria,
    COUNT(*) AS total
FROM tour;

-- 3. INTERSECT
-- Retorna apenas registros que aparecem em AMBAS as consultas
-- Remove duplicatas automaticamente

-- Encontrar nomes que aparecem tanto em owners quanto em tours
-- (Exemplo ilustrativo - improvável ter correspondências exatas)
SELECT name FROM owner
INTERSECT
SELECT name FROM tour;

-- Encontrar IDs de cachoeiras que têm tours E são abertas ao público
SELECT id FROM waterfall WHERE open_to_public = 'y'
INTERSECT
SELECT stop FROM tour;

-- 4. EXCEPT / MINUS
-- Retorna registros da primeira consulta que NÃO aparecem na segunda
-- Remove duplicatas automaticamente
-- MySQL usa EXCEPT (padrão SQL), Oracle usa MINUS

-- Encontrar proprietários que NÃO têm cachoeiras
SELECT id, name, type 
FROM owner
EXCEPT
SELECT o.id, o.name, o.type
FROM owner o
INNER JOIN waterfall w ON o.id = w.owner_id;

-- Alternativa com LEFT JOIN para versões antigas:
SELECT o.id, o.name, o.type
FROM owner o
LEFT JOIN waterfall w ON o.id = w.owner_id
WHERE w.id IS NULL
ORDER BY o.name
LIMIT 15;

-- Alternativa com NOT EXISTS para versões antigas:
SELECT id, name, type
FROM owner o
WHERE NOT EXISTS (
    SELECT 1 FROM waterfall w WHERE w.owner_id = o.id
)
ORDER BY name
LIMIT 15;

-- Encontrar condados que NÃO têm cachoeiras
SELECT id, name, population 
FROM county
EXCEPT
SELECT c.id, c.name, c.population
FROM county c
INNER JOIN waterfall w ON c.id = w.county_id;

-- Alternativa com LEFT JOIN:
SELECT c.id, c.name, c.population
FROM county c
LEFT JOIN waterfall w ON c.id = w.county_id
WHERE w.id IS NULL
ORDER BY c.population DESC;

-- DIFERENÇAS ENTRE OS OPERADORES

-- UNION vs UNION ALL:
-- - UNION: Remove duplicatas (mais lento)
-- - UNION ALL: Mantém duplicatas (mais rápido)

-- INTERSECT vs INNER JOIN:
-- - INTERSECT: Trabalha com conjuntos de resultados completos
-- - INNER JOIN: Trabalha com registros individuais e colunas específicas

-- EXCEPT vs LEFT JOIN:
-- - EXCEPT: Mais legível, padrão SQL
-- - LEFT JOIN com IS NULL: Compatível com versões antigas

-- Comparação visual de resultados:
-- UNION: A ∪ B (tudo de A e B, sem repetir)
-- UNION ALL: A + B (tudo de A e B, com repetições)
-- INTERSECT: A ∩ B (apenas o que está em A e B)
-- EXCEPT: A - B (apenas o que está em A mas não em B)