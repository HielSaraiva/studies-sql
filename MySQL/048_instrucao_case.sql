-- CASE Simples, para uma única coluna de dados
SELECT 
   name,
   population,
   CASE population
      WHEN 50000 THEN 'Cinquenta mil'
      WHEN 100000 THEN 'Cem mil'
   END
FROM county;

-- CASE com múltiplas colunas de dados
/*
   A CASE com múltiplas colunas de dados vai retornar o valor que der True primeiro. 
*/
SELECT 
   name,
   population,
   CASE 
      WHEN population < 50000 THEN 'Pequeno'
      WHEN population BETWEEN 50000 AND 200000 THEN 'Médio'
      ELSE 'Grande'
   END AS tamanho_condado
FROM county;