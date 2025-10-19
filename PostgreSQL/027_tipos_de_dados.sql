-- Inteiros
SMALLINT -- 2 bytes
INT -- 4 bytes
INTEGER -- 4 bytes
BIGINT -- 8 bytes

-- Decimais (Valores exatos)
DECIMAL
NUMERIC

-- Ponto flutuante (Valores aproximados)
REAL -- 4 bytes
DOUBLE PRECISION -- 8 bytes

-- Strings
CHAR -- 10485760 caracteres
VARCHAR -- 10485760 caracteres
TEXT -- Varia bytes

-- Unidoce (Normalmente os caracteres são armazenados como ASCII)
CHAR -- CHAR suporta dados Unicode
VARCHAR -- VARCHAR suporta dados Unicode

-- Datas e/ou Horas
/*
- Datas seguem o padrão: YYYY-MM-DD
- Horas seguem o formato: 10:30:00 / 10:30:12.345678 / 10:30:12.345678 -06:00
- Horas aceitam 6 casas decimais mais granulares
- Horas aceitam fuso horário
*/
DATE -- YYYY-MM-DD
TIME -- hh:mm:ss
TIME WITH TIME ZONE -- hh:mm:ss+tz
TIMESTAMP -- YYYY-MM-DD hh:mm:ss 
TIMESTAMP WITH TIME ZONE -- YYYY-MM-DD hh:mm:ss+tz

-- Boolean
BOOLEAN -- TRUE ou FALSE

-- Binários
BYTEA