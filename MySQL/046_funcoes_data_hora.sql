-- Retorne a data ou a hora atual
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;

-- Adicione ou subtraia um intervalo de data ou hora
SELECT CURRENT_DATE - INTERVAL 1 DAY;
SELECT SUBDATE(CURRENT_DATE, 1);
SELECT DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY);

SELECT CURRENT_TIMESTAMP + INTERVAL 3 HOUR;
SELECT ADDDATE(CURRENT_TIMESTAMP, INTERVAL 3 HOUR);
SELECT DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 3 HOUR);

-- Encontre a diferença entre duas datas
/*
SELECT DATEDIFF(end_date, start_date) AS day_diff
FROM my_table;
*/

-- Encontrando uma diferença temporal
/*
SELECT TIMEDIFF(end_time, start_time) AS time_diff
FROM my_table;
*/

-- Encontrando uma diferença de data e hora
/*
SELECT TIMESTAMPDIFF(hour, start_dt, end_dt) AS hour_diff
FROM my_table;
*/

-- Extraia uma parte de uma data ou hora
/*
SELECT EXTRACT(month FROM CURRENT_DATE);
SELECT MONTH(CURRENT_DATE);
*/

-- Determinar o dia da semana de uma data
SELECT DAYOFWEEK('2020-03-16');
SELECT DAYNAME('2020-03-16');

-- Função CAST
SELECT CAST('2020-10-15' AS DATE);
SELECT CAST('14:30' AS TIME);
SELECT CAST('2020-10-15 14:30' AS DATETIME);

-- Funções STR_TO_DATE, TO_DATE
SELECT STR_TO_DATE('10-15-22', '%m-%d-%y');
SELECT STR_TO_DATE('1030', '%H%i');