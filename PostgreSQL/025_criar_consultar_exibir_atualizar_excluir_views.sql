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
SELECT table_name
FROM information_schema.views
WHERE table_schema NOT IN
   ('information_schema', 'pg_catalog');

-- Atualizar view
CREATE OR REPLACE VIEW view_simples AS
SELECT *
FROM tabela_simples
WHERE pais = 'US';

-- Excluir view
DROP VIEW view_simples;