-- Exibir colunas
DESCRIBE tabela_simples;

-- Incluir coluna
ALTER TABLE tabela_simples
   ADD descricao VARCHAR(30);

-- Excluir coluna
ALTER TABLE tabela_simples
   DROP COLUMN descricao;