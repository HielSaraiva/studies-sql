-- EXPRESSÕES DE TABELA COMUNS (CTEs)
-- Common Table Expressions
-- CTEs são resultados temporários nomeados que existem apenas durante a execução de uma query

-- VANTAGENS sobre subconsultas:
-- 1. Maior legibilidade e organização do código
-- 2. Podem ser referenciadas múltiplas vezes na mesma query
-- 3. Suportam recursão (CTEs recursivas)
-- 4. Facilitam manutenção e debugging
-- 5. Melhor documentação do código

-- 1. CTE NÃO RECURSIVA BÁSICA
-- Resultado temporário simples usado uma vez

-- Exemplo 1: Listar cachoeiras de condados populosos
WITH condados_populosos AS (
    SELECT id, name, population
    FROM county
    WHERE population > 2000000
)
SELECT 
    w.name AS waterfall_name,
    cp.name AS county_name,
    cp.population
FROM waterfall w
INNER JOIN condados_populosos cp ON w.county_id = cp.id
ORDER BY cp.population DESC
LIMIT 10;

-- Exemplo 2: Proprietários públicos com suas cachoeiras
WITH proprietarios_publicos AS (
    SELECT id, name, phone, type
    FROM owner
    WHERE type = 'public'
)
SELECT 
    pp.name AS owner_name,
    pp.phone,
    w.name AS waterfall_name,
    w.open_to_public
FROM proprietarios_publicos pp
LEFT JOIN waterfall w ON pp.id = w.owner_id
ORDER BY pp.name, w.name
LIMIT 20;

-- Exemplo 3: Cachoeiras sem proprietário
WITH cachoeiras_sem_dono AS (
    SELECT id, name, open_to_public, county_id
    FROM waterfall
    WHERE owner_id IS NULL
)
SELECT 
    csd.name AS waterfall_name,
    csd.open_to_public,
    c.name AS county_name,
    c.population
FROM cachoeiras_sem_dono csd
INNER JOIN county c ON csd.county_id = c.id
ORDER BY c.population DESC;

-- 2. MÚLTIPLAS CTEs
-- Várias CTEs na mesma consulta para organização

-- Exemplo 1: Análise de cachoeiras por tipo de proprietário e acessibilidade
WITH 
proprietarios_publicos AS (
    SELECT id, name, type
    FROM owner
    WHERE type = 'public'
),
proprietarios_privados AS (
    SELECT id, name, type
    FROM owner
    WHERE type = 'private'
),
cachoeiras_abertas AS (
    SELECT id, name, owner_id, county_id
    FROM waterfall
    WHERE open_to_public = 'y'
)
SELECT 
    'Pública' AS tipo_proprietario,
    COUNT(ca.id) AS total_cachoeiras_abertas
FROM proprietarios_publicos pp
INNER JOIN cachoeiras_abertas ca ON pp.id = ca.owner_id

UNION ALL

SELECT 
    'Privada' AS tipo_proprietario,
    COUNT(ca.id) AS total_cachoeiras_abertas
FROM proprietarios_privados ppv
INNER JOIN cachoeiras_abertas ca ON ppv.id = ca.owner_id;

-- Exemplo 2: Pipeline de transformação de dados
WITH 
-- Passo 1: Calcular estatísticas por condado
stats_condado AS (
    SELECT 
        c.id,
        c.name,
        c.population,
        COUNT(w.id) AS total_waterfalls
    FROM county c
    LEFT JOIN waterfall w ON c.id = w.county_id
    GROUP BY c.id, c.name, c.population
),
-- Passo 2: Filtrar condados relevantes
condados_relevantes AS (
    SELECT *
    FROM stats_condado
    WHERE total_waterfalls > 0
),
-- Passo 3: Classificar por população
condados_classificados AS (
    SELECT 
        *,
        CASE 
            WHEN population > 2000000 THEN 'Muito Grande'
            WHEN population > 1000000 THEN 'Grande'
            WHEN population > 500000 THEN 'Médio'
            ELSE 'Pequeno'
        END AS classificacao
    FROM condados_relevantes
)
SELECT 
    name AS county_name,
    population,
    total_waterfalls,
    classificacao
FROM condados_classificados
ORDER BY population DESC
LIMIT 15;

-- 3. CTE vs SUBCONSULTA - COMPARAÇÃO
-- Mesma lógica implementada das duas formas

-- USANDO SUBCONSULTA (menos legível, não reutilizável):
SELECT 
    w.name AS waterfall_name,
    o.name AS owner_name,
    condado_info.name AS county_name,
    condado_info.population
FROM waterfall w
INNER JOIN owner o ON w.owner_id = o.id
INNER JOIN (
    SELECT id, name, population
    FROM county
    WHERE population > 1500000
) AS condado_info ON w.county_id = condado_info.id
WHERE o.type = 'public'
ORDER BY condado_info.population DESC
LIMIT 10;

-- USANDO CTE (mais legível, melhor organizado):
WITH 
condados_grandes AS (
    SELECT id, name, population
    FROM county
    WHERE population > 1500000
),
proprietarios_publicos AS (
    SELECT id, name, type
    FROM owner
    WHERE type = 'public'
)
SELECT 
    w.name AS waterfall_name,
    pp.name AS owner_name,
    cg.name AS county_name,
    cg.population
FROM waterfall w
INNER JOIN proprietarios_publicos pp ON w.owner_id = pp.id
INNER JOIN condados_grandes cg ON w.county_id = cg.id
ORDER BY cg.population DESC
LIMIT 10;

-- 4. CTE RECURSIVA - CONCEITO
-- CTEs recursivas permitem consultas hierárquicas e iterativas

-- Estrutura de uma CTE recursiva:
-- WITH RECURSIVE nome_cte AS (
--     -- Parte 1: Caso base (anchor member)
--     SELECT ...
--     
--     UNION ALL
--     
--     -- Parte 2: Caso recursivo (recursive member)
--     SELECT ... FROM nome_cte WHERE condição_de_parada
-- )
-- SELECT * FROM nome_cte;

-- 5. CTE RECURSIVA - EXEMPLO: SEQUÊNCIA NUMÉRICA
-- Gerar série de números

-- Gerar números de 1 a 10
WITH RECURSIVE numeros AS (
    -- Caso base: começar com 1
    SELECT 1 AS n
    
    UNION ALL
    
    -- Caso recursivo: adicionar 1 até chegar a 10
    SELECT n + 1
    FROM numeros
    WHERE n < 10
)
SELECT n AS numero
FROM numeros;

-- Gerar números de 1 a 20 e usar para análise
WITH RECURSIVE ids_sequencia AS (
    SELECT 1 AS id
    UNION ALL
    SELECT id + 1
    FROM ids_sequencia
    WHERE id < 20
)
SELECT 
    seq.id,
    w.name AS waterfall_name,
    CASE 
        WHEN w.id IS NULL THEN 'Não existe'
        ELSE 'Existe'
    END AS status
FROM ids_sequencia seq
LEFT JOIN waterfall w ON seq.id = w.id
ORDER BY seq.id;

-- 6. CTE RECURSIVA - EXEMPLO: HIERARQUIA
-- Simulação de estrutura hierárquica

-- Criar tabela temporária para demonstrar hierarquia
-- (Simulando uma estrutura de regiões)
WITH RECURSIVE hierarquia_populacional AS (
    -- Nível 1: Condados muito grandes (> 3 milhões)
    SELECT 
        id,
        name,
        population,
        1 AS nivel,
        'Metrópole' AS categoria,
        name::VARCHAR AS caminho
    FROM county
    WHERE population > 3000000
    
    UNION ALL
    
    -- Nível 2: Condados grandes (1-3 milhões) relacionados por proximidade de população
    SELECT 
        c.id,
        c.name,
        c.population,
        hp.nivel + 1 AS nivel,
        'Grande' AS categoria,
        hp.caminho || ' > ' || c.name AS caminho
    FROM county c
    INNER JOIN hierarquia_populacional hp 
        ON c.population BETWEEN (hp.population * 0.3)::BIGINT AND (hp.population * 0.7)::BIGINT
    WHERE c.population BETWEEN 1000000 AND 3000000
        AND hp.nivel < 2
        AND c.id <> hp.id
)
SELECT 
    nivel,
    categoria,
    name AS county_name,
    population,
    caminho
FROM hierarquia_populacional
ORDER BY nivel, population DESC
LIMIT 20;

-- 7. PERFORMANCE: CTE vs SUBCONSULTA vs TEMP TABLE
-- Quando usar cada abordagem

-- CTE (melhor para legibilidade, queries complexas):
WITH dados_preparados AS (
    SELECT o.id, o.name, o.type, COUNT(w.id) AS total
    FROM owner o
    LEFT JOIN waterfall w ON o.id = w.owner_id
    GROUP BY o.id, o.name, o.type
)
SELECT * FROM dados_preparados WHERE total > 1;

-- Subconsulta (ok para casos simples, uma única referência):
SELECT * 
FROM (
    SELECT o.id, o.name, o.type, COUNT(w.id) AS total
    FROM owner o
    LEFT JOIN waterfall w ON o.id = w.owner_id
    GROUP BY o.id, o.name, o.type
) AS dados_preparados 
WHERE total > 1;

-- Tabela Temporária (melhor para dados referenciados muitas vezes):
CREATE TEMP TABLE temp_dados_preparados AS
SELECT o.id, o.name, o.type, COUNT(w.id) AS total
FROM owner o
LEFT JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name, o.type;

SELECT * FROM temp_dados_preparados WHERE total > 1;
SELECT AVG(total) FROM temp_dados_preparados;
SELECT MAX(total) FROM temp_dados_preparados;

DROP TABLE IF EXISTS temp_dados_preparados;

-- 8. BOAS PRÁTICAS COM CTEs

-- PRÁTICA 1: Use nomes descritivos
WITH 
cachoeiras_publicas_abertas AS (  -- Nome claro e específico
    SELECT w.* 
    FROM waterfall w
    INNER JOIN owner o ON w.owner_id = o.id
    WHERE w.open_to_public = 'y' AND o.type = 'public'
)
SELECT name FROM cachoeiras_publicas_abertas LIMIT 5;

-- PRÁTICA 2: Quebre consultas complexas em passos menores
WITH 
-- Passo 1: Dados base
base_data AS (
    SELECT id, name, county_id FROM waterfall
),
-- Passo 2: Enriquecer com informações
enriched_data AS (
    SELECT bd.*, c.name AS county_name, c.population
    FROM base_data bd
    INNER JOIN county c ON bd.county_id = c.id
),
-- Passo 3: Filtrar e classificar
final_data AS (
    SELECT *, 
        CASE 
            WHEN population > 2000000 THEN 'Alto'
            ELSE 'Normal'
        END AS nivel_populacao
    FROM enriched_data
)
SELECT * FROM final_data ORDER BY population DESC LIMIT 10;

-- PRÁTICA 3: CTEs recursivas sempre precisam de condição de parada
WITH RECURSIVE contador AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM contador WHERE n < 5  -- IMPORTANTE: condição de parada
)
SELECT * FROM contador;

-- 9. LIMITAÇÕES E CONSIDERAÇÕES

-- 1. CTEs são calculadas a cada referência (podem ser materializadas pelo otimizador)
-- 2. CTEs recursivas têm limite de profundidade (max_stack_depth no PostgreSQL)
-- 3. Não podem ter ORDER BY na definição (apenas no SELECT final)
-- 4. Não persistem após a query (diferente de tabelas temporárias)

-- PostgreSQL não tem uma variável específica para limitar recursão de CTEs
-- Mas o limite é controlado pela memória e configuracão do servidor
-- Para verificar limites de pilha:
SHOW max_stack_depth;

-- Exemplo de CTE recursiva que gera 100 números
WITH RECURSIVE numeros_grandes AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numeros_grandes WHERE n < 100
)
SELECT COUNT(*) AS total FROM numeros_grandes;

-- RESUMO: QUANDO USAR CADA TÉCNICA

-- USE CTE quando:
-- Precisar de código mais legível e organizado
-- A mesma subconsulta for referenciada múltiplas vezes
-- Trabalhar com hierarquias ou recursão
-- Quiser documentar passos de transformação de dados

-- USE SUBCONSULTA quando:
-- For uma operação simples e única
-- A subconsulta for referenciada apenas uma vez
-- Não precisar de recursão

-- USE TABELA TEMPORÁRIA quando:
-- Os dados forem usados em múltiplas queries separadas
-- Precisar de índices nos dados intermediários
-- Trabalhar com grandes volumes de dados reutilizados
-- Precisar persistir dados entre diferentes operações
