-- Gerar números aleatórios em SQL usando RANDOM()

-- RANDOM() - Gerar número aleatório entre 0 e 1

-- Gerar um único número aleatório
SELECT RANDOM() AS numero_aleatorio;

-- Gerar múltiplos números aleatórios
SELECT 
   RANDOM() AS aleatorio_1,
   RANDOM() AS aleatorio_2,
   RANDOM() AS aleatorio_3;

-- Gerar números aleatórios para cada linha
SELECT 
   name,
   RANDOM() AS numero_aleatorio
FROM waterfall
LIMIT 10;

-- Números aleatórios entre 0 e 100
SELECT 
   name,
   ROUND(CAST(RANDOM() * 100 AS numeric), 2) AS aleatorio_0_100
FROM county
LIMIT 10;

-- Números inteiros aleatórios entre 1 e 10
SELECT 
   name,
   FLOOR(RANDOM() * 10) + 1 AS aleatorio_1_10
FROM waterfall
LIMIT 15;

-- Números inteiros aleatórios entre 1 e 100
SELECT 
   name,
   FLOOR(RANDOM() * 100) + 1 AS aleatorio_1_100
FROM county
LIMIT 10;

-- Números inteiros aleatórios em um intervalo específico (ex: 50 a 150)
SELECT 
   name,
   FLOOR(RANDOM() * (150 - 50 + 1)) + 50 AS aleatorio_50_150
FROM owner
LIMIT 10;

-- Fórmula geral: FLOOR(RANDOM() * (max - min + 1)) + min

-- SETSEED() - Gerar números aleatórios reproduzíveis
-- Usando o mesmo seed, obtém-se a mesma sequência de números
SELECT SETSEED(0.42);
SELECT RANDOM() AS primeiro_numero;

SELECT SETSEED(0.42);
SELECT RANDOM() AS mesmo_primeiro_numero;

-- Sequência aleatória com seed (valores entre 0 e 1)
SELECT SETSEED(0.5);
SELECT 
   RANDOM() AS num1,
   RANDOM() AS num2,
   RANDOM() AS num3;

-- Ordenar aleatoriamente
SELECT name
FROM waterfall
ORDER BY RANDOM()
LIMIT 10;

-- Selecionar amostra aleatória de 5 condados
SELECT 
   name,
   population
FROM county
ORDER BY RANDOM()
LIMIT 5;

-- Atribuir grupos aleatórios (1, 2 ou 3)
SELECT 
   name,
   FLOOR(RANDOM() * 3) + 1 AS grupo_aleatorio
FROM waterfall
LIMIT 20;

-- Gerar status aleatório (verdadeiro/falso)
SELECT 
   name,
   CASE 
      WHEN RANDOM() < 0.5 THEN 'Ativo'
      ELSE 'Inativo'
   END AS status_aleatorio
FROM owner
LIMIT 15;

-- Simular probabilidades - 30% chance de "Premium"
SELECT 
   name,
   CASE 
      WHEN RANDOM() < 0.3 THEN 'Premium'
      ELSE 'Padrão'
   END AS tipo_conta
FROM owner
LIMIT 20;

-- Gerar percentual aleatório (0% a 100%)
SELECT 
   name,
   ROUND(CAST(RANDOM() * 100 AS numeric), 1) || '%' AS percentual_aleatorio
FROM county
LIMIT 10;

-- Gerar datas aleatórias (últimos 365 dias)
SELECT 
   name,
   CURRENT_DATE - CAST(FLOOR(RANDOM() * 365) AS integer) AS data_aleatoria
FROM waterfall
LIMIT 10;

-- Gerar horas aleatórias do dia
SELECT 
   name,
   (INTERVAL '1 second' * FLOOR(RANDOM() * 86400))::TIME AS hora_aleatoria
FROM tour
LIMIT 10;

-- Atribuir pontuações aleatórias (1 a 5 estrelas)
SELECT 
   name,
   FLOOR(RANDOM() * 5) + 1 AS estrelas,
   REPEAT('★', CAST(FLOOR(RANDOM() * 5) + 1 AS integer)) || 
   REPEAT('☆', CAST(5 - FLOOR(RANDOM() * 5) - 1 AS integer)) AS visualizacao
FROM waterfall
LIMIT 10;

-- Gerar preços aleatórios entre 10.00 e 100.00
SELECT 
   name,
   ROUND(CAST(RANDOM() * (100 - 10) + 10 AS numeric), 2) AS preco_aleatorio
FROM tour
LIMIT 15;

-- Simular dados de teste - População com variação aleatória
SELECT 
   name,
   population AS populacao_real,
   ROUND(CAST(population * (0.9 + RANDOM() * 0.2) AS numeric), 0) AS populacao_estimada
FROM county
LIMIT 10;

-- Criar distribuição ponderada (mais resultados próximos de 50)
SELECT 
   ROUND(CAST((RANDOM() + RANDOM()) * 50 AS numeric), 0) AS numero_ponderado
FROM waterfall
LIMIT 20;

-- Gerar códigos aleatórios de 4 dígitos
SELECT 
   name,
   LPAD(FLOOR(RANDOM() * 10000)::text, 4, '0') AS codigo
FROM owner
LIMIT 10;

-- Embaralhar IDs para testes
SELECT 
   id,
   name,
   RANDOM() AS ordem_aleatoria
FROM waterfall
ORDER BY ordem_aleatoria
LIMIT 15;

-- Selecionar aleatoriamente cachoeiras abertas ao público
SELECT 
   name,
   open_to_public
FROM waterfall
WHERE open_to_public = 'y'
ORDER BY RANDOM()
LIMIT 5;

-- Distribuição de valores em categorias (baixo, médio, alto)
SELECT 
   name,
   CASE 
      WHEN RANDOM() < 0.33 THEN 'Baixo'
      WHEN RANDOM() < 0.66 THEN 'Médio'
      ELSE 'Alto'
   END AS prioridade
FROM tour
LIMIT 20;

-- Gerar amostra estratificada (50% de cada tipo)
(SELECT name, type, 'public' AS categoria FROM owner WHERE type = 'public' ORDER BY RANDOM() LIMIT 5)
UNION ALL
(SELECT name, type, 'private' AS categoria FROM owner WHERE type = 'private' ORDER BY RANDOM() LIMIT 5);

-- Simular jogo de dados (1 a 6)
SELECT 
   FLOOR(RANDOM() * 6) + 1 AS dado_1,
   FLOOR(RANDOM() * 6) + 1 AS dado_2,
   FLOOR(RANDOM() * 6) + 1 AS dado_3
FROM waterfall
LIMIT 10;

-- Gerar valores booleanos aleatórios (0 ou 1)
SELECT 
   name,
   FLOOR(RANDOM() * 2) AS valor_booleano,
   CASE WHEN RANDOM() < 0.5 THEN 'Sim' ELSE 'Não' END AS resposta
FROM county
LIMIT 10;

-- Criar variação aleatória com média e desvio padrão simulados
-- Média 100, variação ±20
SELECT 
   name,
   ROUND(CAST(100 + (RANDOM() - 0.5) * 40 AS numeric), 2) AS valor_com_variacao
FROM owner
LIMIT 10;

-- Gerar múltiplos valores aleatórios para análise
SELECT 
   'Amostra' AS tipo,
   ROUND(CAST(AVG(numero) AS numeric), 2) AS media,
   ROUND(CAST(MIN(numero) AS numeric), 2) AS minimo,
   ROUND(CAST(MAX(numero) AS numeric), 2) AS maximo
FROM (
   SELECT RANDOM() AS numero FROM waterfall LIMIT 100
) AS aleatorios;

-- Gerar número inteiro aleatório em intervalo
SELECT 
   name,
   FLOOR(RANDOM() * (100 - 10 + 1))::integer + 10 AS aleatorio_10_100
FROM county
LIMIT 10;
