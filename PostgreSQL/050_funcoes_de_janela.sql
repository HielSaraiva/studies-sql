-- FUNÇÕES DE JANELA (Window Functions)
-- Permitem realizar cálculos em um conjunto de linhas relacionadas à linha atual

-- 1. ROW_NUMBER() - Atribui um número sequencial para cada linha
SELECT 
   name,
   population,
   ROW_NUMBER() OVER (ORDER BY population DESC) AS ranking_populacao
FROM county
LIMIT 10;

-- 2. RANK() - Atribui um ranking com empates (pula números)
SELECT 
   name,
   population,
   RANK() OVER (ORDER BY population DESC) AS rank_populacao
FROM county
LIMIT 10;

-- 3. DENSE_RANK() - Atribui um ranking sem pular números em caso de empate
SELECT 
   name,
   population,
   DENSE_RANK() OVER (ORDER BY population DESC) AS dense_rank_populacao
FROM county
LIMIT 10;

-- 4. PARTITION BY - Divide os dados em grupos para aplicar a função de janela
-- Ranking de cachoeiras por tipo de proprietário
SELECT 
   w.name AS cachoeira,
   o.type AS tipo_proprietario,
   w.open_to_public,
   ROW_NUMBER() OVER (PARTITION BY o.type ORDER BY w.name) AS numero_por_tipo
FROM waterfall w
   INNER JOIN owner o ON w.owner_id = o.id
LIMIT 20;

-- 5. SUM() OVER - Soma acumulada (running total)
SELECT 
   name,
   population,
   SUM(population) OVER (ORDER BY population DESC) AS soma_acumulada
FROM county
LIMIT 10;

-- 6. AVG() OVER - Média móvel
SELECT 
   name,
   population,
   AVG(population) OVER (ORDER BY population DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS media_movel_3
FROM county
LIMIT 10;

-- 7. COUNT() OVER - Contagem em janela
SELECT 
   w.name AS cachoeira,
   o.type AS tipo_proprietario,
   COUNT(*) OVER (PARTITION BY o.type) AS total_por_tipo
FROM waterfall w
   INNER JOIN owner o ON w.owner_id = o.id
ORDER BY tipo_proprietario, cachoeira
LIMIT 20;

-- 8. LAG() - Acessa o valor da linha anterior
SELECT 
   name,
   population,
   LAG(population, 1) OVER (ORDER BY population DESC) AS populacao_anterior,
   population - LAG(population, 1) OVER (ORDER BY population DESC) AS diferenca
FROM county
LIMIT 10;

-- 9. LEAD() - Acessa o valor da próxima linha
SELECT 
   name,
   population,
   LEAD(population, 1) OVER (ORDER BY population DESC) AS proxima_populacao,
   population - LEAD(population, 1) OVER (ORDER BY population DESC) AS diferenca_para_proximo
FROM county
LIMIT 10;

-- 10. FIRST_VALUE() e LAST_VALUE() - Primeiro e último valor da janela
SELECT 
   name,
   population,
   FIRST_VALUE(name) OVER (ORDER BY population DESC) AS condado_mais_populoso,
   FIRST_VALUE(population) OVER (ORDER BY population DESC) AS maior_populacao
FROM county
LIMIT 10;

-- 11. NTILE() - Divide os dados em N grupos aproximadamente iguais
-- Dividindo condados em 4 quartis por população
SELECT 
   name,
   population,
   NTILE(4) OVER (ORDER BY population DESC) AS quartil
FROM county
LIMIT 20;

-- 12. Exemplo complexo: Ranking de cachoeiras por condado
SELECT 
   c.name AS condado,
   w.name AS cachoeira,
   w.open_to_public,
   ROW_NUMBER() OVER (PARTITION BY c.id ORDER BY w.name) AS numero_no_condado,
   COUNT(*) OVER (PARTITION BY c.id) AS total_cachoeiras_condado
FROM waterfall w
   INNER JOIN county c ON w.county_id = c.id
ORDER BY condado, numero_no_condado
LIMIT 30;

-- 13. Percentual acumulado
SELECT 
   name,
   population,
   SUM(population) OVER (ORDER BY population DESC) AS soma_acumulada,
   SUM(population) OVER () AS total_geral,
   ROUND(SUM(population) OVER (ORDER BY population DESC) * 100.0 / SUM(population) OVER (), 2) AS percentual_acumulado
FROM county
LIMIT 15;

-- 14. ROWS BETWEEN - Definindo janelas personalizadas
-- Média móvel dos últimos 3 registros
SELECT 
   name,
   population,
   AVG(population) OVER (
      ORDER BY population DESC 
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
   ) AS media_3_registros
FROM county
LIMIT 10;

-- 15. RANGE BETWEEN - Baseado em valores, não em linhas
SELECT 
   name,
   population,
   COUNT(*) OVER (
      ORDER BY population 
      RANGE BETWEEN 100000 PRECEDING AND 100000 FOLLOWING
   ) AS condados_populacao_similar
FROM county
LIMIT 15;

-- 16. Combinando múltiplas funções de janela
SELECT 
   o.type AS tipo_proprietario,
   w.name AS cachoeira,
   w.open_to_public,
   ROW_NUMBER() OVER (PARTITION BY o.type ORDER BY w.name) AS numero,
   COUNT(*) OVER (PARTITION BY o.type) AS total_por_tipo,
   COUNT(*) OVER (PARTITION BY o.type, w.open_to_public) AS total_por_tipo_e_acesso
FROM waterfall w
   INNER JOIN owner o ON w.owner_id = o.id
ORDER BY tipo_proprietario, numero
LIMIT 25;

-- 17. Top 3 condados mais populosos usando CTE e funções de janela
WITH ranking_condados AS (
   SELECT 
      name,
      population,
      RANK() OVER (ORDER BY population DESC) AS rank_pop
   FROM county
)
SELECT 
   name,
   population,
   rank_pop
FROM ranking_condados
WHERE rank_pop <= 3;

-- 18. Calculando diferença percentual com a linha anterior
SELECT 
   name,
   population,
   LAG(population) OVER (ORDER BY population DESC) AS pop_anterior,
   ROUND(
      (population - LAG(population) OVER (ORDER BY population DESC)) * 100.0 / 
      LAG(population) OVER (ORDER BY population DESC), 
      2
   ) AS variacao_percentual
FROM county
LIMIT 10;
