-- Funções matemáticas realizam operações e cálculos numéricos sobre valores

-- ABS() - Valor absoluto (remove o sinal negativo)

-- Diferença absoluta entre população e a média
SELECT 
   name,
   population,
   ROUND(AVG(population) OVER(), 0) AS media,
   ABS(population - AVG(population) OVER()) AS diferenca_absoluta
FROM county
ORDER BY diferenca_absoluta DESC
LIMIT 10;

-- SIGN() - Retorna o sinal do número (-1, 0, ou 1)

-- Verifica se a população está acima, abaixo ou igual à média
SELECT 
   name,
   population,
   SIGN(population - 1000000) AS comparacao,
   CASE 
      WHEN SIGN(population - 1000000) = 1 THEN 'Acima de 1 milhão'
      WHEN SIGN(population - 1000000) = 0 THEN 'Igual a 1 milhão'
      ELSE 'Abaixo de 1 milhão'
   END AS categoria
FROM county
LIMIT 15;

-- POWER() / POW() - Eleva um número a uma potência

-- População ao quadrado (para cálculos estatísticos)
SELECT 
   name,
   population,
   POWER(population, 2) AS populacao_quadrado,
   POW(population, 0.5) AS raiz_quadrada_alt
FROM county
ORDER BY population DESC
LIMIT 10;

-- SQRT() - Raiz quadrada

-- Raiz quadrada da população
SELECT 
   name,
   population,
   ROUND(SQRT(population), 2) AS raiz_quadrada,
   ROUND(population / SQRT(population), 2) AS densidade_relativa
FROM county
ORDER BY population DESC
LIMIT 10;

-- EXP() - Exponencial (e^x)

-- Crescimento exponencial simulado
SELECT 
   id,
   name,
   population,
   ROUND(EXP(1), 4) AS numero_euler,
   ROUND(population * EXP(0.05), 2) AS projecao_crescimento_5pct
FROM county
LIMIT 10;

-- LOG() - Logaritmo natural (base e)

-- Logaritmo natural da população
SELECT 
   name,
   population,
   ROUND(LOG(population), 4) AS log_natural,
   ROUND(LOG(population) / LOG(10), 4) AS log_base10_calculado
FROM county
ORDER BY population DESC
LIMIT 10;

-- LN() - Logaritmo natural (alias de LOG)

-- LN é idêntico a LOG no MySQL
SELECT 
   name,
   population,
   ROUND(LN(population), 4) AS ln_populacao,
   ROUND(LOG(population), 4) AS log_populacao
FROM county
LIMIT 10;

-- LOG10() - Logaritmo base 10

-- Escala logarítmica da população
SELECT 
   name,
   population,
   ROUND(LOG10(population), 2) AS escala_log10,
   FLOOR(LOG10(population)) AS ordem_magnitude
FROM county
ORDER BY population DESC
LIMIT 15;

-- MOD() - Resto da divisão (módulo)

-- Verificar números pares/ímpares
SELECT 
   id,
   name,
   population,
   MOD(population, 2) AS resto_divisao_2,
   CASE 
      WHEN MOD(population, 2) = 0 THEN 'Par'
      ELSE 'Ímpar'
   END AS paridade
FROM county
LIMIT 15;

-- Agrupar por faixa usando módulo
SELECT 
   id,
   name,
   MOD(id, 10) AS grupo,
   COUNT(*) OVER(PARTITION BY MOD(id, 10)) AS quantidade_grupo
FROM waterfall
LIMIT 20;

-- PI() - Constante Pi (3.141592...)

-- Calcular área de círculo imaginário baseado em população
SELECT 
   name,
   population,
   ROUND(PI(), 6) AS pi,
   ROUND(PI() * POWER(SQRT(population/1000), 2), 2) AS area_proporcional
FROM county
LIMIT 10;

-- CEIL() / CEILING() - Arredonda para cima

-- Arredondar população para milhares
SELECT 
   name,
   population,
   CEIL(population / 1000) AS milhares_arredondado_cima,
   CEIL(population / 100000) * 100000 AS centena_milhar_cima
FROM county
LIMIT 10;

-- FLOOR() - Arredonda para baixo

-- Arredondar população para baixo
SELECT 
   name,
   population,
   FLOOR(population / 1000) AS milhares_arredondado_baixo,
   FLOOR(population / 100000) * 100000 AS centena_milhar_baixo
FROM county
LIMIT 10;

-- ROUND() - Arredondamento padrão

-- Arredondar para diferentes casas decimais
SELECT 
   name,
   population,
   ROUND(population / 1000, 0) AS milhares,
   ROUND(population / 1000, 1) AS milhares_1_decimal,
   ROUND(population / 1000000, 2) AS milhoes_2_decimais
FROM county
LIMIT 10;

-- TRUNCATE() - Truncar casas decimais

-- Diferença entre ROUND e TRUNCATE
SELECT 
   name,
   population / 1000 AS valor_original,
   ROUND(population / 1000, 1) AS arredondado,
   TRUNCATE(population / 1000, 1) AS truncado
FROM county
LIMIT 10;

-- RAND() - Número aleatório entre 0 e 1

-- Gerar números aleatórios
SELECT 
   name,
   RAND() AS aleatorio,
   ROUND(RAND() * 100, 2) AS aleatorio_0_100,
   FLOOR(RAND() * 10) + 1 AS aleatorio_1_10
FROM waterfall
LIMIT 10;

-- Ordenar aleatoriamente
SELECT name
FROM waterfall
ORDER BY RAND()
LIMIT 10;

-- DEGREES() e RADIANS() - Conversão de ângulos

-- Converter radianos para graus e vice-versa
SELECT 
   PI() AS pi_radianos,
   DEGREES(PI()) AS pi_graus,
   RADIANS(180) AS graus_180_em_radianos,
   RADIANS(360) AS graus_360_em_radianos;

-- SIN(), COS(), TAN() - Funções trigonométricas

-- Funções trigonométricas com ângulos comuns
SELECT 
   0 AS angulo_graus,
   RADIANS(0) AS angulo_radianos,
   SIN(RADIANS(0)) AS seno,
   COS(RADIANS(0)) AS cosseno,
   TAN(RADIANS(0)) AS tangente
UNION ALL
SELECT 
   30,
   RADIANS(30),
   ROUND(SIN(RADIANS(30)), 4),
   ROUND(COS(RADIANS(30)), 4),
   ROUND(TAN(RADIANS(30)), 4)
UNION ALL
SELECT 
   45,
   RADIANS(45),
   ROUND(SIN(RADIANS(45)), 4),
   ROUND(COS(RADIANS(45)), 4),
   ROUND(TAN(RADIANS(45)), 4)
UNION ALL
SELECT 
   60,
   RADIANS(60),
   ROUND(SIN(RADIANS(60)), 4),
   ROUND(COS(RADIANS(60)), 4),
   ROUND(TAN(RADIANS(60)), 4)
UNION ALL
SELECT 
   90,
   RADIANS(90),
   ROUND(SIN(RADIANS(90)), 4),
   ROUND(COS(RADIANS(90)), 4),
   NULL;

-- Combinando múltiplas funções matemáticas

-- Análise estatística completa
SELECT 
   'Total' AS metrica,
   COUNT(*) AS quantidade,
   SUM(population) AS soma,
   ROUND(AVG(population), 2) AS media,
   ROUND(SQRT(AVG(POWER(population - (SELECT AVG(population) FROM county), 2))), 2) AS desvio_padrao,
   MIN(population) AS minimo,
   MAX(population) AS maximo
FROM county;

-- Normalização de valores (escala 0-1)
SELECT 
   name,
   population,
   ROUND(
      (population - (SELECT MIN(population) FROM county)) / 
      ((SELECT MAX(population) FROM county) - (SELECT MIN(population) FROM county)),
      4
   ) AS populacao_normalizada
FROM county
ORDER BY population DESC
LIMIT 15;