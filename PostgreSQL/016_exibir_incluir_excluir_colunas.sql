-- Exibir colunas
\d tabela_simples  ; -- Funciona apenas no terminal

-- Incluir coluna
ALTER TABLE tabela_simples
   ADD descricao VARCHAR(30);

-- Excluir coluna
ALTER TABLE tabela_simples
   DROP COLUMN descricao;