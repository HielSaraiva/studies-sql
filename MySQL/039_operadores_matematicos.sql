/*
Operadores matemáticos: +, -, *, /, %
No PostgreSQL, SQLServer e SQLite, dividir um inteiro por outro inteiro resulta em um inteiro.
*/
SELECT
   15 / 2;

SELECT
   15 / 2.0;

SELECT
   CAST(15 AS DECIMAL) / CAST(2 AS DECIMAL);

SELECT
   10 + 3 AS soma,
   10 - 3 AS sub,
   10 * 3 AS mult,
   10 / 3 AS divi,
   10 % 3 AS resto;

/*
Outros operadores matemáticos:
Bitwise: &, |, ^, ~, <<, >>.
Atribuição: +=, -=, *=, /=, %=.
*/
SELECT
   6 & 3 AS bit_and,
   6 | 3 AS bit_or,
   6 ^ 3 AS bit_xor,
   ~ 6 AS bit_not,
   1 << 3 AS shift_left,
   8 >> 2 AS shift_right;
