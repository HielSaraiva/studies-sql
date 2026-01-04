-- Converter dados em tipo numérico para comparações

-- Problema: Comparar coluna de texto (phone) com número
-- A coluna phone é VARCHAR, então precisa ser convertida para comparar com números

-- CAST() - Converter string para número

-- Exemplo: Filtrar proprietários com código de área 555
SELECT 
   name,
   phone,
   CAST(SUBSTRING(phone, 1, 3) AS INTEGER) AS codigo_area
FROM owner
WHERE CAST(SUBSTRING(phone, 1, 3) AS INTEGER) = 555
LIMIT 10;

-- Exemplo: Comparar IDs (se fossem string) com número
SELECT 
   id,
   name,
   CAST(id AS INTEGER) AS id_numero
FROM waterfall
WHERE CAST(id AS INTEGER) > 50
LIMIT 10;

-- Operador :: - Forma abreviada no PostgreSQL

-- Mesmo exemplo usando ::
SELECT 
   name,
   phone,
   SUBSTRING(phone, 1, 3)::INTEGER AS codigo_area
FROM owner
WHERE SUBSTRING(phone, 1, 3)::INTEGER = 555
LIMIT 10;

-- Comparar valor de texto com número em cálculo

SELECT 
   name,
   phone,
   SUBSTRING(phone, 1, 3)::INTEGER + 100 AS codigo_modificado
FROM owner
WHERE phone IS NOT NULL
LIMIT 5;
