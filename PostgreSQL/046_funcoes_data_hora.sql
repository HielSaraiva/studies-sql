-- Retorne a data ou a hora atual
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;

-- Adicione ou subtraia um intervalo de data ou hora
SELECT CAST(CURRENT_DATE - INTERVAL '1 day' AS DATE);

SELECT CURRENT_TIMESTAMP + INTERVAL '3 hours';

-- Encontre a diferença entre duas datas
/*
SELECT AGE(end_date, start_date) AS day_diff
FROM my_table;
*/

-- Encontrando uma diferença temporal
/*
SELECT EXTRACT(epoch from end_time - start_time) AS time_diff
FROM my_table;
*/

-- Encontrando uma diferença de data e hora
/*
SELECT AGE(end_dt, start_dt) AS hour_diff
FROM my_table;
*/

-- Extraia uma parte de uma data ou hora
/*
SELECT EXTRACT(month FROM CURRENT_DATE);
SELECT DATE_PART('month', CURRENT_DATE);
*/

-- Determinar o dia da semana de uma data
SELECT DATE_PART('dow', date '2020-03-16');
SELECT TO_CHAR(date '2020-03-16', 'day');

-- Função CAST
SELECT CAST('2020-10-15' AS DATE);
SELECT CAST('14:30' AS TIME);
SELECT CAST('2020-10-15 14:30' AS TIMESTAMP);

-- Funções STR_TO_DATE, TO_DATE
SELECT TO_DATE('10-15-22', 'MM-DD-YY');
SELECT TO_TIMESTAMP('2020-10-15 10:30', 'YYYY-MM-DD HH24:MI');