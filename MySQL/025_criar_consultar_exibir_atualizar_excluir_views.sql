/*
- Subconsultas são temporárias
- Views são salvas.
*/

-- Criar view
CREATE VIEW view_simples AS
SELECT *
FROM tabela_simples
WHERE pais = 'BR';

-- Consultar view
SELECT *
FROM view_simples;

-- Exibir views
SHOW FULL TABLES
WHERE table_type = 'VIEW';

-- Atualizar view
CREATE OR REPLACE VIEW view_simples AS
SELECT *
FROM tabela_simples
WHERE pais = 'US';

-- Excluir view
DROP VIEW view_simples;