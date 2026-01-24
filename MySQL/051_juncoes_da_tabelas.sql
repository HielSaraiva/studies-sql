-- JUNÇÕES DE TABELAS (JOINS)

-- ANALOGIA COM DIAGRAMAS DE VENN:
-- Imagine dois círculos que se sobrepõem (A e B representando duas tabelas)
-- 
-- INNER JOIN:     Apenas a interseção (parte que se sobrepõe)
-- LEFT JOIN:      Todo o círculo A + interseção
-- RIGHT JOIN:     Todo o círculo B + interseção  
-- FULL OUTER:     Ambos os círculos completos (A + B + interseção)
-- CROSS JOIN:     Cada elemento de A com cada elemento de B (produto cartesiano)
-- SELF JOIN:      Um círculo comparado consigo mesmo

-- 1. INNER JOIN
-- Retorna apenas os registros que têm correspondência em ambas as tabelas

-- Listar cachoeiras com seus respectivos condados
SELECT 
    w.id,
    w.name AS waterfall_name,
    c.name AS county_name,
    c.population
FROM waterfall w
INNER JOIN county c ON w.county_id = c.id
ORDER BY w.id
LIMIT 10;

-- Listar cachoeiras com seus proprietários (apenas as que têm proprietário)
SELECT 
    w.name AS waterfall_name,
    w.open_to_public,
    o.name AS owner_name,
    o.type AS owner_type,
    o.phone
FROM waterfall w
INNER JOIN owner o ON w.owner_id = o.id
ORDER BY w.name
LIMIT 10;

-- Junção com três tabelas: cachoeira, proprietário e condado
SELECT 
    w.name AS waterfall_name,
    o.name AS owner_name,
    o.type AS owner_type,
    c.name AS county_name,
    c.population
FROM waterfall w
INNER JOIN owner o ON w.owner_id = o.id
INNER JOIN county c ON w.county_id = c.id
ORDER BY c.population DESC
LIMIT 10;

-- Junção com quatro tabelas: tour, cachoeira, proprietário e condado
SELECT 
    t.name AS tour_name,
    w.name AS waterfall_name,
    o.name AS owner_name,
    c.name AS county_name
FROM tour t
INNER JOIN waterfall w ON t.stop = w.id
INNER JOIN owner o ON w.owner_id = o.id
INNER JOIN county c ON w.county_id = c.id
ORDER BY t.id
LIMIT 10;

-- 2. LEFT JOIN (LEFT OUTER JOIN)
-- Retorna todos os registros da tabela da esquerda e os correspondentes da direita
-- Se não houver correspondência, retorna NULL para os campos da direita


-- Listar TODAS as cachoeiras, mesmo as que não têm proprietário
SELECT 
    w.id,
    w.name AS waterfall_name,
    w.open_to_public,
    o.name AS owner_name,
    o.type AS owner_type
FROM waterfall w
LEFT JOIN owner o ON w.owner_id = o.id
ORDER BY w.id
LIMIT 15;

-- Encontrar cachoeiras sem proprietário
SELECT 
    w.id,
    w.name AS waterfall_name,
    w.open_to_public,
    c.name AS county_name
FROM waterfall w
LEFT JOIN owner o ON w.owner_id = o.id
INNER JOIN county c ON w.county_id = c.id
WHERE o.id IS NULL
ORDER BY w.name;

-- Listar TODOS os proprietários, mesmo os que não possuem cachoeiras
SELECT 
    o.id,
    o.name AS owner_name,
    o.type,
    COUNT(w.id) AS total_waterfalls
FROM owner o
LEFT JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name, o.type
ORDER BY total_waterfalls DESC, o.name
LIMIT 20;

-- Encontrar proprietários que não possuem nenhuma cachoeira
SELECT 
    o.id,
    o.name AS owner_name,
    o.type,
    o.phone
FROM owner o
LEFT JOIN waterfall w ON o.id = w.owner_id
WHERE w.id IS NULL
ORDER BY o.name
LIMIT 10;

-- 3. RIGHT JOIN (RIGHT OUTER JOIN)
-- Retorna todos os registros da tabela da direita e os correspondentes da esquerda
-- Se não houver correspondência, retorna NULL para os campos da esquerda

-- Listar todos os condados com suas cachoeiras (perspectiva do condado)
SELECT 
    c.name AS county_name,
    c.population,
    w.name AS waterfall_name,
    w.open_to_public
FROM waterfall w
RIGHT JOIN county c ON w.county_id = c.id
ORDER BY c.population DESC
LIMIT 15;

-- Encontrar condados sem cachoeiras
SELECT 
    c.id,
    c.name AS county_name,
    c.population
FROM waterfall w
RIGHT JOIN county c ON w.county_id = c.id
WHERE w.id IS NULL
ORDER BY c.population DESC;

-- 4. CROSS JOIN
-- Retorna o produto cartesiano de duas tabelas (todas as combinações possíveis)
--    Cada linha de A é combinada com TODAS as linhas de B
--    Se A tem 3 linhas e B tem 4 linhas = 12 combinações (3 × 4)
--    Resultado: A1-B1, A1-B2, A1-B3, A1-B4, A2-B1, A2-B2...


-- Combinar cada proprietário com cada condado
-- ATENÇÃO: CROSS JOIN gera muitos resultados!
SELECT 
    o.name AS owner_name,
    o.type,
    c.name AS county_name
FROM owner o
CROSS JOIN county c
WHERE o.id <= 3 AND c.id <= 5
ORDER BY o.id, c.id;

-- 5. SELF JOIN
-- Junção de uma tabela com ela mesma
--    Útil para encontrar relacionamentos dentro da mesma tabela

-- Encontrar cachoeiras do mesmo condado
SELECT 
    w1.name AS waterfall1,
    w2.name AS waterfall2,
    c.name AS county_name
FROM waterfall w1
INNER JOIN waterfall w2 ON w1.county_id = w2.county_id AND w1.id < w2.id
INNER JOIN county c ON w1.county_id = c.id
ORDER BY c.name, w1.name
LIMIT 20;

-- Encontrar cachoeiras com o mesmo proprietário
SELECT 
    w1.name AS waterfall1,
    w2.name AS waterfall2,
    o.name AS owner_name
FROM waterfall w1
INNER JOIN waterfall w2 ON w1.owner_id = w2.owner_id AND w1.id < w2.id
INNER JOIN owner o ON w1.owner_id = o.id
ORDER BY o.name, w1.name
LIMIT 15;

-- Encontrar proprietários do mesmo tipo no mesmo contexto de condados
SELECT DISTINCT
    o1.name AS owner1,
    o2.name AS owner2,
    o1.type
FROM owner o1
INNER JOIN owner o2 ON o1.type = o2.type AND o1.id < o2.id
WHERE o1.type = 'public'
ORDER BY o1.name
LIMIT 10;

-- 6. NATURAL JOIN
-- Une tabelas automaticamente com base em colunas de mesmo nome
-- Não requer cláusula ON - MySQL encontra automaticamente as colunas comuns
-- ATENÇÃO: Pode ser perigoso! Se as tabelas tiverem colunas com mesmo nome
-- mas significados diferentes, pode gerar resultados inesperados
-- NATURAL JOIN não é muito útil com nossas tabelas pois usamos 
-- convenções diferentes (county_id vs id), mas vamos criar um exemplo

-- Criar tabelas temporárias para demonstrar NATURAL JOIN
CREATE TEMPORARY TABLE temp_waterfall_stats (
    id INT,
    name VARCHAR(30),
    visitor_count INT
);

CREATE TEMPORARY TABLE temp_waterfall_reviews (
    id INT,
    name VARCHAR(30),
    rating DECIMAL(3,2)
);

INSERT INTO temp_waterfall_stats (id, name, visitor_count)
VALUES 
    (1, 'Cataratas do Sol', 15000),
    (2, 'Salto da Lua', 8000),
    (3, 'Cachoeira do Grito', 12000);

INSERT INTO temp_waterfall_reviews (id, name, rating)
VALUES 
    (1, 'Cataratas do Sol', 4.8),
    (2, 'Salto da Lua', 4.5),
    (3, 'Cachoeira do Grito', 4.9);

-- NATURAL JOIN - une automaticamente por 'id' e 'name' (colunas comuns)
SELECT *
FROM temp_waterfall_stats
NATURAL JOIN temp_waterfall_reviews;

-- Equivalente ao INNER JOIN explícito:
SELECT 
    s.id,
    s.name,
    s.visitor_count,
    r.rating
FROM temp_waterfall_stats s
INNER JOIN temp_waterfall_reviews r 
    ON s.id = r.id AND s.name = r.name;

-- Limpar tabelas temporárias
DROP TEMPORARY TABLE IF EXISTS temp_waterfall_stats, temp_waterfall_reviews;

-- 7. USANDO CLÁUSULA USING
-- Alternativa ao ON quando as colunas têm o mesmo nome
-- Mais limpo e evita ambiguidade quando os nomes são idênticos

-- Para demonstrar USING, vamos criar uma estrutura onde faz mais sentido
CREATE TEMPORARY TABLE waterfall_normalized (
    waterfall_id INT,
    name VARCHAR(30)
);

CREATE TEMPORARY TABLE waterfall_location (
    waterfall_id INT,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8)
);

INSERT INTO waterfall_location (waterfall_id, latitude, longitude)
VALUES (1, -25.6953, -54.4367), (2, -22.9068, -43.1729), (3, -23.5505, -46.6333);

INSERT INTO waterfall_normalized (waterfall_id, name)
VALUES (1, 'Cataratas do Sol'), (2, 'Salto da Lua'), (3, 'Véu da Noiva');

-- USING: Mais limpo quando as colunas têm o mesmo nome
SELECT *
FROM waterfall_normalized
INNER JOIN waterfall_location USING (waterfall_id);

-- Equivalente usando ON:
SELECT 
    n.waterfall_id,
    n.name,
    l.latitude,
    l.longitude
FROM waterfall_normalized n
INNER JOIN waterfall_location l ON n.waterfall_id = l.waterfall_id;

-- USING com múltiplas colunas
CREATE TEMPORARY TABLE waterfall_details (
    waterfall_id INT,
    name VARCHAR(30),
    height_meters INT
);

INSERT INTO waterfall_details (waterfall_id, name, height_meters)
VALUES (1, 'Cataratas do Sol', 82), (2, 'Salto da Lua', 45), (3, 'Véu da Noiva', 120);

-- USING com duas colunas comuns
SELECT *
FROM waterfall_normalized
INNER JOIN waterfall_details USING (waterfall_id, name);

-- Equivalente usando ON:
SELECT 
    n.waterfall_id,
    n.name,
    d.height_meters
FROM waterfall_normalized n
INNER JOIN waterfall_details d 
    ON n.waterfall_id = d.waterfall_id 
    AND n.name = d.name;

-- LEFT JOIN com USING
SELECT *
FROM waterfall_normalized
LEFT JOIN waterfall_location USING (waterfall_id)
LEFT JOIN waterfall_details USING (waterfall_id, name);

-- Limpar tabelas temporárias
DROP TEMPORARY TABLE IF EXISTS waterfall_normalized, 
                                waterfall_location, 
                                waterfall_details;

-- VANTAGENS DO USING:
-- 1. Código mais limpo e legível
-- 2. Evita duplicação da coluna de junção no resultado
-- 3. Menos verboso que ON quando os nomes são idênticos
-- 4. Previne erros de digitação ao referenciar a mesma coluna

-- DESVANTAGENS DO USING:
-- 1. Só funciona quando as colunas têm EXATAMENTE o mesmo nome
-- 2. Menos flexível que ON para condições complexas
-- 3. Pode ser confuso em joins com múltiplas colunas comuns

-- 8. JUNÇÕES COM CONDIÇÕES COMPLEXAS

-- Cachoeiras públicas em condados populosos
SELECT 
    w.name AS waterfall_name,
    c.name AS county_name,
    c.population,
    o.name AS owner_name
FROM waterfall w
INNER JOIN county c ON w.county_id = c.id
LEFT JOIN owner o ON w.owner_id = o.id
WHERE w.open_to_public = 'y' AND c.population > 1000000
ORDER BY c.population DESC
LIMIT 15;

-- Cachoeiras privadas com proprietários que têm telefone
SELECT 
    w.name AS waterfall_name,
    o.name AS owner_name,
    o.phone,
    c.name AS county_name
FROM waterfall w
INNER JOIN owner o ON w.owner_id = o.id
INNER JOIN county c ON w.county_id = c.id
WHERE o.type = 'private' 
    AND o.phone IS NOT NULL
    AND w.open_to_public = 'y'
ORDER BY w.name
LIMIT 10;

-- 7. JUNÇÕES COM AGREGAÇÕES

-- Contar cachoeiras por condado
SELECT 
    c.name AS county_name,
    c.population,
    COUNT(w.id) AS total_waterfalls
FROM county c
LEFT JOIN waterfall w ON c.id = w.county_id
GROUP BY c.id, c.name, c.population
HAVING total_waterfalls > 0
ORDER BY total_waterfalls DESC, c.population DESC
LIMIT 15;

-- Contar cachoeiras por proprietário
SELECT 
    o.name AS owner_name,
    o.type,
    COUNT(w.id) AS total_waterfalls,
    SUM(CASE WHEN w.open_to_public = 'y' THEN 1 ELSE 0 END) AS open_waterfalls,
    SUM(CASE WHEN w.open_to_public = 'n' THEN 1 ELSE 0 END) AS closed_waterfalls
FROM owner o
LEFT JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name, o.type
HAVING total_waterfalls > 0
ORDER BY total_waterfalls DESC
LIMIT 15;

-- Estatísticas de tours por condado
SELECT 
    c.name AS county_name,
    COUNT(DISTINCT t.id) AS total_tours,
    COUNT(DISTINCT w.id) AS total_waterfalls,
    AVG(c.population) AS avg_population
FROM county c
INNER JOIN waterfall w ON c.id = w.county_id
INNER JOIN tour t ON w.id = t.stop
GROUP BY c.id, c.name
ORDER BY total_tours DESC
LIMIT 10;

-- 10. JUNÇÕES COM SUBCONSULTAS

-- Cachoeiras em condados acima da população média
SELECT 
    w.name AS waterfall_name,
    c.name AS county_name,
    c.population
FROM waterfall w
INNER JOIN county c ON w.county_id = c.id
WHERE c.population > (SELECT AVG(population) FROM county)
ORDER BY c.population DESC
LIMIT 10;

-- Proprietários com mais cachoeiras que a média
SELECT 
    o.name AS owner_name,
    o.type,
    COUNT(w.id) AS total_waterfalls
FROM owner o
INNER JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name, o.type
HAVING total_waterfalls > (
    SELECT AVG(waterfall_count)
    FROM (
        SELECT COUNT(*) AS waterfall_count
        FROM waterfall
        WHERE owner_id IS NOT NULL
        GROUP BY owner_id
    ) AS subquery
)
ORDER BY total_waterfalls DESC;

-- 11. MÚLTIPLAS JUNÇÕES COM FILTROS

-- Tour completo: nome do tour, cachoeira, proprietário e condado
SELECT 
    t.id AS tour_id,
    t.name AS tour_name,
    w.name AS waterfall_name,
    w.open_to_public,
    COALESCE(o.name, 'Sem Proprietário') AS owner_name,
    COALESCE(o.type, 'N/A') AS owner_type,
    c.name AS county_name,
    c.population
FROM tour t
INNER JOIN waterfall w ON t.stop = w.id
LEFT JOIN owner o ON w.owner_id = o.id
INNER JOIN county c ON w.county_id = c.id
WHERE c.population > 800000
ORDER BY c.population DESC, t.name
LIMIT 20;

-- Análise de acessibilidade por tipo de proprietário
SELECT 
    o.type AS owner_type,
    COUNT(w.id) AS total_waterfalls,
    SUM(CASE WHEN w.open_to_public = 'y' THEN 1 ELSE 0 END) AS open_count,
    SUM(CASE WHEN w.open_to_public = 'n' THEN 1 ELSE 0 END) AS closed_count,
    ROUND(SUM(CASE WHEN w.open_to_public = 'y' THEN 1 ELSE 0 END) * 100.0 / COUNT(w.id), 2) AS open_percentage
FROM owner o
INNER JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.type
ORDER BY owner_type;