-- Arredondamento e truncagem de números

-- ROUND() - Arredondamento padrão (banker's rounding)

-- Arredondar para inteiro
SELECT 
   name,
   population,
   ROUND(CAST(population AS numeric) / 1000) AS milhares_arredondado
FROM county
LIMIT 5;

-- Arredondar com casas decimais específicas
SELECT 
   name,
   population,
   ROUND(CAST(population AS numeric) / 1000, 2) AS milhares_2_decimais,
   ROUND(CAST(population AS numeric) / 1000000, 3) AS milhoes_3_decimais
FROM county
LIMIT 5;

-- Arredondar números negativos
SELECT 
   ROUND(15.5) AS round_15_5,
   ROUND(15.4) AS round_15_4,
   ROUND(-15.5) AS round_neg_15_5,
   ROUND(-15.4) AS round_neg_15_4;

-- CEIL() / CEILING() - Arredonda sempre para cima

-- Arredondar população para cima
SELECT 
   name,
   CAST(population AS numeric) / 1000 AS valor_exato,
   CEIL(CAST(population AS numeric) / 1000) AS arredondado_cima
FROM county
LIMIT 5;

-- Exemplos com números positivos e negativos
SELECT 
   CEIL(4.2) AS ceil_4_2,
   CEIL(4.8) AS ceil_4_8,
   CEIL(-4.2) AS ceil_neg_4_2,
   CEILING(7.1) AS ceiling_7_1;

-- FLOOR() - Arredonda sempre para baixo

-- Arredondar população para baixo
SELECT 
   name,
   CAST(population AS numeric) / 1000 AS valor_exato,
   FLOOR(CAST(population AS numeric) / 1000) AS arredondado_baixo
FROM county
LIMIT 5;

-- Exemplos com números positivos e negativos
SELECT 
   FLOOR(4.2) AS floor_4_2,
   FLOOR(4.8) AS floor_4_8,
   FLOOR(-4.2) AS floor_neg_4_2,
   FLOOR(-4.8) AS floor_neg_4_8;

-- TRUNC() - Remove casas decimais sem arredondar

-- Truncar população
SELECT 
   name,
   CAST(population AS numeric) / 1000 AS valor_exato,
   TRUNC(CAST(population AS numeric) / 1000, 0) AS truncado_inteiro,
   TRUNC(CAST(population AS numeric) / 1000, 1) AS truncado_1_decimal
FROM county
LIMIT 5;

-- Diferença entre ROUND e TRUNC
SELECT 
   CAST(population AS numeric) / 1000 AS valor_original,
   ROUND(CAST(population AS numeric) / 1000, 1) AS arredondado,
   TRUNC(CAST(population AS numeric) / 1000, 1) AS truncado,
   ROUND(CAST(population AS numeric) / 1000, 1) - TRUNC(CAST(population AS numeric) / 1000, 1) AS diferenca
FROM county
LIMIT 8;

-- Comparação entre todas as funções

SELECT 
   'Positivo 4.7' AS exemplo,
   ROUND(4.7) AS round_result,
   CEIL(4.7) AS ceil_result,
   FLOOR(4.7) AS floor_result,
   TRUNC(4.7, 0) AS truncate_result
UNION ALL
SELECT 
   'Negativo -4.7',
   ROUND(-4.7),
   CEIL(-4.7),
   FLOOR(-4.7),
   TRUNC(-4.7, 0);

-- Aplicações práticas

-- Calcular faixas de população (múltiplos de 100.000)
SELECT 
   name,
   population,
   FLOOR(CAST(population AS numeric) / 100000) * 100000 AS faixa_inferior,
   CEIL(CAST(population AS numeric) / 100000) * 100000 AS faixa_superior
FROM county
LIMIT 10;

-- Arredondar para múltiplos de 5
SELECT 
   id,
   name,
   ROUND(CAST(id AS numeric) / 5) * 5 AS id_arredondado_5
FROM waterfall
LIMIT 10;

-- Calcular porcentagens com diferentes precisões
SELECT 
   type,
   COUNT(*) AS total,
   ROUND(CAST(COUNT(*) * 100.0 AS numeric) / (SELECT COUNT(*) FROM owner), 0) AS porcentagem_0_dec,
   ROUND(CAST(COUNT(*) * 100.0 AS numeric) / (SELECT COUNT(*) FROM owner), 1) AS porcentagem_1_dec,
   ROUND(CAST(COUNT(*) * 100.0 AS numeric) / (SELECT COUNT(*) FROM owner), 2) AS porcentagem_2_dec
FROM owner
GROUP BY type;

-- Normalizar valores em escala 0-10
SELECT 
   name,
   population,
   ROUND(
      CAST((population - (SELECT MIN(population) FROM county)) * 10.0 AS numeric) / 
      CAST(((SELECT MAX(population) FROM county) - (SELECT MIN(population) FROM county)) AS numeric),
      1
   ) AS escala_0_10
FROM county
ORDER BY population DESC
LIMIT 10;
