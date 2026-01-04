-- Converter dados em tipo numérico para comparações

-- No MySQL, a conversão é OPCIONAL porque ele faz conversão implícita automaticamente
-- Mas é boa prática usar CAST() para deixar explícito e garantir portabilidade

-- Comparação SEM conversão explícita (MySQL faz automaticamente)

SELECT 
   name,
   phone,
   SUBSTRING(phone, 1, 3) AS codigo_area
FROM owner
WHERE SUBSTRING(phone, 1, 3) = 555
LIMIT 5;

-- Comparação COM conversão explícita (recomendado)

SELECT 
   name,
   phone,
   CAST(SUBSTRING(phone, 1, 3) AS UNSIGNED) AS codigo_area
FROM owner
WHERE CAST(SUBSTRING(phone, 1, 3) AS UNSIGNED) = 555
LIMIT 5;

-- CONVERT() - Alternativa no MySQL

SELECT 
   name,
   phone,
   CONVERT(SUBSTRING(phone, 1, 3), UNSIGNED) AS codigo_area
FROM owner
WHERE CONVERT(SUBSTRING(phone, 1, 3), UNSIGNED) = 555
LIMIT 5;

-- Nota: Use CAST() quando quiser ser explícito ou garantir compatibilidade com outros bancos
