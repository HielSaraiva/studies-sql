-- Renomeando tabela
ALTER TABLE tabela_simples
RENAME TO tabela_simples_renomeada;

-- Renomeando coluna
ALTER TABLE tabela_simples_renomeada
   RENAME COLUMN id
   TO tabela_id;

DROP TABLE tabela_simples_renomeada;