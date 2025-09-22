-- Índice simples
CREATE INDEX index_simples ON tabela_simples (nome);

-- Índice composto
CREATE INDEX index_composto ON tabela_simples (nome, pais);
