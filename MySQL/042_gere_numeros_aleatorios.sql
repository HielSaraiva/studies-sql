-- Gerar números aleatórios em SQL usando RAND()

-- RAND() - Gerar número aleatório entre 0 e 1

-- Gerar um único número aleatório
SELECT RAND() AS numero_aleatorio;

-- Gerar múltiplos números aleatórios
SELECT 
   RAND() AS aleatorio_1,
   RAND() AS aleatorio_2,
   RAND() AS aleatorio_3;

-- Gerar números aleatórios para cada linha
SELECT 
   name,
   RAND() AS numero_aleatorio
FROM waterfall
LIMIT 10;

-- Números aleatórios entre 0 e 100
SELECT 
   name,
   ROUND(RAND() * 100, 2) AS aleatorio_0_100
FROM county
LIMIT 10;

-- Números inteiros aleatórios entre 1 e 10
SELECT 
   name,
   FLOOR(RAND() * 10) + 1 AS aleatorio_1_10
FROM waterfall
LIMIT 15;

-- Números inteiros aleatórios entre 1 e 100
SELECT 
   name,
   FLOOR(RAND() * 100) + 1 AS aleatorio_1_100
FROM county
LIMIT 10;

-- Números inteiros aleatórios em um intervalo específico (ex: 50 a 150)
SELECT 
   name,
   FLOOR(RAND() * (150 - 50 + 1)) + 50 AS aleatorio_50_150
FROM owner
LIMIT 10;

-- Fórmula geral: FLOOR(RAND() * (max - min + 1)) + min

-- RAND com seed - Gerar números aleatórios reproduzíveis
-- Usando o mesmo seed, obtém-se a mesma sequência de números
SELECT RAND(42) AS primeiro_numero;
SELECT RAND(42) AS mesmo_primeiro_numero;

-- Sequência aleatória com seed
SELECT 
   RAND(100) AS num1,
   RAND() AS num2,
   RAND() AS num3;

-- Ordenar aleatoriamente
SELECT name
FROM waterfall
ORDER BY RAND()
LIMIT 10;

-- Selecionar amostra aleatória de 5 condados
SELECT 
   name,
   population
FROM county
ORDER BY RAND()
LIMIT 5;

-- Atribuir grupos aleatórios (1, 2 ou 3)
SELECT 
   name,
   FLOOR(RAND() * 3) + 1 AS grupo_aleatorio
FROM waterfall
LIMIT 20;

-- Gerar status aleatório (verdadeiro/falso)
SELECT 
   name,
   CASE 
      WHEN RAND() < 0.5 THEN 'Ativo'
      ELSE 'Inativo'
   END AS status_aleatorio
FROM owner
LIMIT 15;

-- Simular probabilidades - 30% chance de "Premium"
SELECT 
   name,
   CASE 
      WHEN RAND() < 0.3 THEN 'Premium'
      ELSE 'Padrão'
   END AS tipo_conta
FROM owner
LIMIT 20;

-- Gerar percentual aleatório (0% a 100%)
SELECT 
   name,
   CONCAT(ROUND(RAND() * 100, 1), '%') AS percentual_aleatorio
FROM county
LIMIT 10;

-- Gerar datas aleatórias (últimos 365 dias)
SELECT 
   name,
   DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY) AS data_aleatoria
FROM waterfall
LIMIT 10;

-- Gerar horas aleatórias do dia
SELECT 
   name,
   TIME(SEC_TO_TIME(FLOOR(RAND() * 86400))) AS hora_aleatoria
FROM tour
LIMIT 10;

-- Atribuir pontuações aleatórias (1 a 5 estrelas)
SELECT 
   name,
   FLOOR(RAND() * 5) + 1 AS estrelas,
   CONCAT(REPEAT('★', FLOOR(RAND() * 5) + 1), REPEAT('☆', 5 - FLOOR(RAND() * 5) - 1)) AS visualizacao
FROM waterfall
LIMIT 10;

-- Gerar preços aleatórios entre 10.00 e 100.00
SELECT 
   name,
   ROUND(RAND() * (100 - 10) + 10, 2) AS preco_aleatorio
FROM tour
LIMIT 15;

-- Simular dados de teste - População com variação aleatória
SELECT 
   name,
   population AS populacao_real,
   ROUND(population * (0.9 + RAND() * 0.2), 0) AS populacao_estimada
FROM county
LIMIT 10;

-- Criar distribuição ponderada (mais resultados próximos de 50)
SELECT 
   ROUND((RAND() + RAND()) * 50, 0) AS numero_ponderado
FROM waterfall
LIMIT 20;

-- Gerar códigos aleatórios de 4 dígitos
SELECT 
   name,
   LPAD(FLOOR(RAND() * 10000), 4, '0') AS codigo
FROM owner
LIMIT 10;

-- Embaralhar IDs para testes
SELECT 
   id,
   name,
   RAND() AS ordem_aleatoria
FROM waterfall
ORDER BY ordem_aleatoria
LIMIT 15;

-- Selecionar aleatoriamente cachoeiras abertas ao público
SELECT 
   name,
   open_to_public
FROM waterfall
WHERE open_to_public = 'y'
ORDER BY RAND()
LIMIT 5;

-- Distribuição de valores em categorias (baixo, médio, alto)
SELECT 
   name,
   CASE 
      WHEN RAND() < 0.33 THEN 'Baixo'
      WHEN RAND() < 0.66 THEN 'Médio'
      ELSE 'Alto'
   END AS prioridade
FROM tour
LIMIT 20;

-- Gerar amostra estratificada (50% de cada tipo)
(SELECT name, type, 'public' AS categoria FROM owner WHERE type = 'public' ORDER BY RAND() LIMIT 5)
UNION ALL
(SELECT name, type, 'private' AS categoria FROM owner WHERE type = 'private' ORDER BY RAND() LIMIT 5);

-- Simular jogo de dados (1 a 6)
SELECT 
   FLOOR(RAND() * 6) + 1 AS dado_1,
   FLOOR(RAND() * 6) + 1 AS dado_2,
   FLOOR(RAND() * 6) + 1 AS dado_3
FROM waterfall
LIMIT 10;

-- Gerar valores booleanos aleatórios (0 ou 1)
SELECT 
   name,
   FLOOR(RAND() * 2) AS valor_booleano,
   IF(RAND() < 0.5, 'Sim', 'Não') AS resposta
FROM county
LIMIT 10;

-- Criar variação aleatória com média e desvio padrão simulados
-- Média 100, variação ±20
SELECT 
   name,
   ROUND(100 + (RAND() - 0.5) * 40, 2) AS valor_com_variacao
FROM owner
LIMIT 10;

-- Gerar múltiplos valores aleatórios para análise
SELECT 
   'Amostra' AS tipo,
   ROUND(AVG(numero), 2) AS media,
   ROUND(MIN(numero), 2) AS minimo,
   ROUND(MAX(numero), 2) AS maximo
FROM (
   SELECT RAND() AS numero FROM waterfall LIMIT 100
) AS aleatorios;
