/*
Operadores lógicos comuns:
- AND
- OR
- NOT

Resultam em:
- TRUE
- FALSE
- NULL

AND:
- TRUE se ambas forem TRUE, FALSE se alguma for FALSE, caso contrário, NULL.

OR:
- TRUE se alguma for TRUE, FALSE se as duas forem FALSE, caso contrário, NULL.

NOT:
- TRUE se for FALSE, FALSE se for TRUE, caso contrário, NULL.
*/
SELECT
   *
FROM
   owner
WHERE
   phone IS NOT NULL
   AND (type = 'public');