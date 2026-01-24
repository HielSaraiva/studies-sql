-- Soluções práticas para problemas comuns em SQL

-- 1. ENCONTRAR LINHAS COM VALORES DUPLICADOS

-- 1.1. Retornar todas as combinações exclusivas (remover duplicatas)
-- Usando DISTINCT para obter valores únicos
SELECT DISTINCT county_id
FROM waterfall
ORDER BY county_id;

-- Combinações exclusivas de múltiplas colunas
SELECT DISTINCT open_to_public, county_id
FROM waterfall
ORDER BY county_id, open_to_public;

-- 1.2. Retornar apenas as linhas com valores duplicados
-- Encontrar counties que têm mais de uma cachoeira
SELECT 
   county_id,
   COUNT(*) as quantidade_cachoeiras
FROM waterfall
GROUP BY county_id
HAVING COUNT(*) > 1
ORDER BY quantidade_cachoeiras DESC;

-- Ver detalhes das cachoeiras em counties duplicados
SELECT w.*
FROM waterfall w
WHERE w.county_id IN (
   SELECT county_id
   FROM waterfall
   GROUP BY county_id
   HAVING COUNT(*) > 1
)
ORDER BY w.county_id, w.name;

-- Encontrar nomes de owners que aparecem mais de uma vez
-- (neste caso não acontece por causa da constraint UNIQUE)
SELECT 
   name,
   COUNT(*) as quantidade
FROM owner
GROUP BY name
HAVING COUNT(*) > 1;

-- Encontrar tours que param na mesma cachoeira
SELECT 
   stop,
   COUNT(*) as quantidade_tours,
   STRING_AGG(name, ', ' ORDER BY name) as nomes_tours
FROM tour
GROUP BY stop
HAVING COUNT(*) > 1
ORDER BY quantidade_tours DESC;


-- 2. SELECIONAR LINHAS COM O VALOR MÁXIMO DE OUTRA COLUNA

-- 2.1. County com a maior população
SELECT *
FROM county
WHERE population = (SELECT MAX(population) FROM county);

-- 2.2. Top 5 counties com maior população
SELECT *
FROM county
ORDER BY population DESC
LIMIT 5;

-- 2.3. Cachoeira com o maior ID de county (último county alfabeticamente)
SELECT w.*, c.name as county_name
FROM waterfall w
INNER JOIN county c ON w.county_id = c.id
WHERE w.county_id = (SELECT MAX(county_id) FROM waterfall);

-- 2.4. Owner com o maior número de cachoeiras
SELECT 
   o.id,
   o.name,
   o.type,
   COUNT(w.id) as quantidade_cachoeiras
FROM owner o
INNER JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name, o.type
HAVING COUNT(w.id) = (
   SELECT MAX(cachoeiras_count)
   FROM (
      SELECT COUNT(*) as cachoeiras_count
      FROM waterfall
      WHERE owner_id IS NOT NULL
      GROUP BY owner_id
   ) as contagens
);

-- 2.5. Para cada county, a cachoeira com o menor ID (primeira registrada)
SELECT w1.*
FROM waterfall w1
WHERE w1.id = (
   SELECT MIN(w2.id)
   FROM waterfall w2
   WHERE w2.county_id = w1.county_id
)
ORDER BY w1.county_id;

-- Alternativa usando WINDOW FUNCTION (mais eficiente)
SELECT *
FROM (
   SELECT 
      w.*,
      ROW_NUMBER() OVER (PARTITION BY county_id ORDER BY id) as rn
   FROM waterfall w
) as ranked
WHERE rn = 1
ORDER BY county_id;


-- 3. CONCATENAR TEXTO DE VÁRIOS CAMPOS

-- 3.1. Concatenar campos de uma mesma linha
-- Informações completas do owner em um único campo
SELECT 
   id,
   name || ' (' || type || ')' as owner_info
FROM owner
LIMIT 10;

-- Endereço completo de cachoeira com county
SELECT 
   w.id,
   w.name || ' - ' || c.name || ' County' as localizacao_completa
FROM waterfall w
INNER JOIN county c ON w.county_id = c.id
LIMIT 10;

-- Concatenar com verificação de NULL
SELECT 
   id,
   name ||
      COALESCE(' | Phone: ' || phone, ' | Phone: N/A') ||
      ' | Type: ' ||
      type as owner_completo
FROM owner
LIMIT 10;

-- Usando || com COALESCE para lidar com NULLs
SELECT 
   id,
   name || COALESCE(' | ' || phone, '') || ' | ' || type as owner_info
FROM owner
LIMIT 10;

-- 3.2. Concatenar campos de várias linhas em um único resultado
-- Listar todos os nomes de cachoeiras em uma única string
SELECT STRING_AGG(name, ', ' ORDER BY name) as todas_cachoeiras
FROM waterfall;

-- Limitar o tamanho do resultado (primeiras 10)
SELECT STRING_AGG(name, ', ' ORDER BY name) as primeiras_cachoeiras
FROM (SELECT name FROM waterfall LIMIT 10) as subset;

-- Cachoeiras agrupadas por county
SELECT 
   c.name as county_name,
   COUNT(w.id) as total_cachoeiras,
   STRING_AGG(w.name, ' | ' ORDER BY w.name) as lista_cachoeiras
FROM county c
INNER JOIN waterfall w ON c.id = w.county_id
GROUP BY c.id, c.name
ORDER BY total_cachoeiras DESC
LIMIT 10;

-- Tours agrupados por cachoeira
SELECT 
   w.name as cachoeira,
   COUNT(t.id) as total_tours,
   STRING_AGG(t.name, '; ' ORDER BY t.name) as tours_disponiveis
FROM waterfall w
INNER JOIN tour t ON w.id = t.stop
GROUP BY w.id, w.name
HAVING COUNT(t.id) > 1
ORDER BY total_tours DESC;

-- Concatenar com formatação customizada
SELECT 
   o.name as proprietario,
   'Cachoeiras: [' ||
      STRING_AGG('"' || w.name || '"', ', ' ORDER BY w.name) ||
      ']' as cachoeiras_json_style
FROM owner o
INNER JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name
LIMIT 5;

-- 4. ENCONTRAR TABELAS COM UM NOME DE COLUNA ESPECÍFICO

-- 4.1. Buscar tabelas que contêm a coluna 'name'
SELECT 
   TABLE_NAME,
   COLUMN_NAME,
   DATA_TYPE,
   CHARACTER_MAXIMUM_LENGTH,
   IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'public'
   AND COLUMN_NAME = 'name'
ORDER BY TABLE_NAME;

-- 4.2. Buscar tabelas que contêm colunas com 'id' no nome
SELECT 
   TABLE_NAME,
   COLUMN_NAME,
   UDT_NAME as COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'public'
   AND COLUMN_NAME LIKE '%id%'
ORDER BY TABLE_NAME, COLUMN_NAME;

-- 4.3. Buscar tabelas que têm chave estrangeira
SELECT DISTINCT
   TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'public'
   AND POSITION_IN_UNIQUE_CONSTRAINT IS NOT NULL
ORDER BY TABLE_NAME;

-- 4.4. Informações detalhadas de colunas em uma tabela específica
SELECT 
   COLUMN_NAME,
   DATA_TYPE,
   IS_NULLABLE,
   COLUMN_DEFAULT,
   CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'public'
   AND TABLE_NAME = 'waterfall'
ORDER BY ORDINAL_POSITION;

-- 4.5. Encontrar todas as constraints de uma tabela
SELECT 
   CONSTRAINT_NAME,
   CONSTRAINT_TYPE,
   TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'public'
   AND TABLE_NAME = 'waterfall';

-- 5. ATUALIZAR TABELA BASEADO EM OUTRA TABELA

-- 5.1. Criar tabela temporária para testes
CREATE TEMP TABLE waterfall_backup AS
SELECT * FROM waterfall;

-- 5.2. Atualizar open_to_public baseado no tipo do owner
-- Marcar como público ('y') todas as cachoeiras de owners públicos
UPDATE waterfall w
SET open_to_public = 'y'
FROM owner o
WHERE w.owner_id = o.id
   AND o.type = 'public';

-- Verificar as mudanças
SELECT 
   w.name as cachoeira,
   w.open_to_public,
   o.name as proprietario,
   o.type
FROM waterfall w
LEFT JOIN owner o ON w.owner_id = o.id
WHERE w.open_to_public = 'y'
LIMIT 10;

-- 5.3. Atualizar múltiplas colunas baseado em joins complexos
-- Exemplo: criar coluna temporária para teste
ALTER TABLE waterfall_backup ADD COLUMN county_population BIGINT;

-- Atualizar com a população do county correspondente
UPDATE waterfall_backup wb
SET county_population = c.population
FROM county c
WHERE wb.county_id = c.id;

-- Verificar resultado
SELECT 
   name as cachoeira,
   county_id,
   county_population
FROM waterfall_backup
LIMIT 10;

-- 5.4. Atualizar apenas registros que coincidem com condições específicas
-- Restaurar tabela de backup
DROP TABLE IF EXISTS waterfall_backup;
CREATE TEMP TABLE waterfall_backup AS
SELECT * FROM waterfall;

-- Atualizar owner_id baseado em match de county específicos
UPDATE waterfall_backup w
SET owner_id = 2  -- Governo Municipal
FROM county c
WHERE w.county_id = c.id
   AND c.population > 2000000
   AND w.owner_id IS NULL;

-- Verificar quais foram atualizados
SELECT 
   w.name as cachoeira,
   c.name as county,
   c.population,
   w.owner_id
FROM waterfall_backup w
INNER JOIN county c ON w.county_id = c.id
WHERE c.population > 2000000
ORDER BY c.population DESC;

-- 5.5. Atualizar usando subconsulta
-- Criar outra tabela de teste
CREATE TEMP TABLE county_stats AS
SELECT 
   county_id,
   COUNT(*) as total_waterfalls,
   SUM(CASE WHEN open_to_public = 'y' THEN 1 ELSE 0 END) as public_waterfalls
FROM waterfall
GROUP BY county_id;

-- Adicionar colunas para teste
ALTER TABLE county_stats 
ADD COLUMN has_many_waterfalls CHAR(1) DEFAULT 'n';

-- Atualizar baseado em agregação
UPDATE county_stats
SET has_many_waterfalls = 'y'
WHERE total_waterfalls > (
   SELECT AVG(total_waterfalls)
   FROM (
      SELECT COUNT(*) as total_waterfalls
      FROM waterfall
      GROUP BY county_id
   ) as avg_calc
);

-- Ver resultado
SELECT 
   cs.*,
   c.name as county_name
FROM county_stats cs
INNER JOIN county c ON cs.county_id = c.id
WHERE cs.has_many_waterfalls = 'y'
ORDER BY cs.total_waterfalls DESC;

-- Limpar tabelas temporárias
DROP TABLE IF EXISTS waterfall_backup;
DROP TABLE IF EXISTS county_stats;

-- OUTROS CASOS COMUNS

-- 6.1. Encontrar registros órfãos (sem relação)
-- Cachoeiras sem owner
SELECT 
   id,
   name,
   owner_id
FROM waterfall
WHERE owner_id IS NULL;

-- 6.2. Encontrar registros sem referências inversas
-- Owners que não têm cachoeiras
SELECT o.*
FROM owner o
LEFT JOIN waterfall w ON o.id = w.owner_id
WHERE w.id IS NULL;

-- 6.3. Contar relacionamentos
-- Quantas cachoeiras cada owner possui
SELECT 
   o.id,
   o.name,
   o.type,
   COUNT(w.id) as total_cachoeiras
FROM owner o
LEFT JOIN waterfall w ON o.id = w.owner_id
GROUP BY o.id, o.name, o.type
ORDER BY total_cachoeiras DESC, o.name
LIMIT 15;

-- 6.4. Encontrar gaps em sequências numéricas
-- IDs faltantes na sequência de waterfalls
SELECT 
   (t1.id + 1) as id_faltando_inicio,
   (MIN(t2.id) - 1) as id_faltando_fim
FROM waterfall t1
LEFT JOIN waterfall t2 ON t1.id < t2.id
GROUP BY t1.id
HAVING (t1.id + 1) < MIN(t2.id)
ORDER BY t1.id;

-- 6.5. Ranking com empates
-- Ranking de counties por população (usando DENSE_RANK)
SELECT 
   name,
   population,
   DENSE_RANK() OVER (ORDER BY population DESC) as ranking
FROM county
ORDER BY ranking, name
LIMIT 15;