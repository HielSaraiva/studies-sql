-- Descubrir o tamanho de uma string
SELECT LENGTH(name)
FROM county;

SELECT *
FROM county
WHERE LENGTH(name) >= 10;

-- Alterar a capitalização de uma string
SELECT UPPER(name) AS name
FROM county;

SELECT LOWER(name) AS name
FROM county;

-- Remover caracteres indesejados próximos da string
/*
   Função TRIM() remove os caracteres em branco de ambos os lados de uma String
   É possível especificar qual caracter deve ser removido: TRIM('!' FROM county)
*/

-- Remova caracteres do lado esquerdo ou direito
/*
   TRIM(LEADING '!' FROM county) ou TRIM(TRAILING '!' FROM county) removem caracteres do lado esquerdo e direito, respectivamente
   No MySQL, LTRIM(name) e RTRIM(name) só removem espaços em branco
   Já no PostgreSQL é possível remover caracteres: LTRIM(name, '.! '), removendo todos os caracteres indesejados listados dentro de ''.
*/

-- Concatenar Strings
SELECT CONCAT(id, '_', name) AS id_name
FROM county;

-- Procurar texto em uma String
SELECT *
FROM owner
WHERE phone LIKE '%13%';

-- Extrair parte de uma String
SELECT SUBSTR(phone, 1, 4) AS sub_str
FROm owner;

-- Substituir texto em uma String
SELECT REPLACE(phone, '555', '444') AS new_phone
FROM owner;

-- Excluir texto de uma string
SELECT REPLACE(phone, '555-', '') AS new_phone
FROM owner;

-- Expressões Regulares
-- (regex101.com / regexone.com)

-- REGEXP ou RLIKE (são equivalentes no MySQL)
SELECT *
FROM owner
WHERE phone REGEXP '555';

-- Começa com '555'
SELECT *
FROM owner
WHERE phone REGEXP '^555';

-- Termina com '5678'
SELECT *
FROM owner
WHERE phone REGEXP '5678$';

-- Case-sensitive no MySQL 8.0+ use REGEXP_LIKE
SELECT *
FROM owner
WHERE REGEXP_LIKE(phone, '555', 'c');

-- Converter Dados para um tipo de dado String
SELECT LENGTH(population) AS len_pop
FROM county;