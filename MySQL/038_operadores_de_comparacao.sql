/*
Alguns operadores de comparação (símbolos):
!=, <> | verifica se é diferente
<=> | verificação de igualdade null-safe (retorna 0 se uma das colunas forem NULL, retorna 1 se as duas forem NULL)
*/
-- Operadores de comparação (palavra-chave):
-- BETWEEN (combinação de >= e <=)
SELECT
   *
FROM
   county
WHERE
   population BETWEEN 100000 AND 1000000;

-- EXISTS (verifica se uma subconsulta retorna ou não resultados)
-- Donos que têm pelo menos uma cachoeira
SELECT
   o.id,
   o.name
FROM
   owner o
WHERE
   EXISTS (
      SELECT
         *
      FROM
         waterfall w
      WHERE
         w.owner_id = o.id
   );

-- IN (verifica se um valor está contido em uma lista de valores)
SELECT
   o.id,
   o.name
FROM
   owner o
WHERE
   o.type IN ('public');

/*
Ao usar NOT IN, se houver ao menos um valor NULL na coluna de subconsulta,
esta nunca será igual a TRUE, o que significa que nenhuma linha será retornada.
Se houver valores que possam ser NULL na subconsulta, use NOT EXISTS.
*/
SELECT
   o.id,
   o.name
FROM
   owner o
WHERE
   o.id NOT IN(
      SELECT
         w.owner_id
      FROM
         waterfall w
      WHERE
         w.owner_id IS NOT NULL -- Retire e teste, não irá retorna nada.
   );

-- IS NULL (verifica se um valor é nulo)
SELECT
   *
FROM
   owner AS o
WHERE
   o.phone IS NOT NULL;

SELECT
   *
FROM
   waterfall AS w
WHERE
   w.owner_id IS NULL;

-- LIKE (procura uma padrão simples)
-- % representa um ou mais caracteres, _ encontra exatamente um caractere
/*
- MySQL, SQLServer e SQLite, o padrão não diferencia maiúsculas de minúsculas.
- Oracle e PostgreSQL, o padrão diferencia maiúsculas de minúsculas.
*/
SELECT
   o.id,
   o.name
FROM
   owner o
WHERE
   o.name LIKE 'A%';

SELECT
   o.id,
   o.name
FROM
   owner o
WHERE
   o.name LIKE '%ra';

SELECT
   w.id,
   w.name
FROM
   waterfall w
WHERE
   w.name LIKE '%choe%';

SELECT
   o.id,
   o.name
FROM
   owner o
WHERE
   o.name NOT LIKE '_a%';

/*
- Use \ se quiser buscar os caracteres _ e % com seu significado real.
*/
SELECT
   '100%' LIKE '100\%%';