-- Inteiros
TINYINT -- 1 byte
SMALLINT -- 2 bytes
MEDIUMINT -- 3 bytes
INT -- 4 bytes
INTEGER -- 4 bytes
BIGINT -- 8 bytes

-- Decimais (Valores exatos)
DECIMAL
NUMERIC

-- Ponto flutuante (Valores aproximados)
FLOAT -- 4 bytes
FLOAT -- 8 bytes
DOUBLE -- 8 bytes

-- Strings
CHAR -- 255 caracteres
VARCHAR -- 65535 caracteres
TINYTEXT -- 255 bytes
TEXT -- 65535 bytes
MEDIUMTEXT -- 16777215 bytes
LONGTEXT -- 4294967295 bytes

-- Unidoce (Normalmente os caracteres são armazenados como ASCII)
NCHAR -- Como CHAR, mas para dados Unicode
NVARCHAR -- Como VARCHAR, mas para dados Unicode

-- Datas e/ou Horas
/*
- Datas seguem o padrão: YYYY-MM-DD
- Horas seguem o formato: 10:30:00 / 10:30:12.345678 / 10:30:12.345678 -06:00
- Horas aceitam 6 casas decimais mais granulares
- Horas aceitam fuso horário
*/
DATE -- YYYY-MM-DD
TIME -- hh:mm:ss
DATETIME -- YYYY-MM-DD hh:mm:ss
TIMESTAMP -- YYYY-MM-DD hh:mm:ss (Tem fuso horário associado)
YEAR -- YYYY

-- Boolean
BOOLEAN -- TRUE ou FALSE

-- Binários
BINARY -- 255 bytes
VARBINARY -- 65535 bytes
TINYBLOB -- 
BLOB
MEDIUMBLOB
LONGBLOB