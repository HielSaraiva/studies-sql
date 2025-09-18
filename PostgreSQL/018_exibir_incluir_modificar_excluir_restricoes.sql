-- Exibir restrições
\d tabela_simples  ; -- Apenas no terminal

-- Incluir restrição
ALTER TABLE tabela_simples
   ADD CONSTRAINT chk_pais_us
   CHECK (nome = 'US');

-- Modificar restrição
ALTER TABLE tabela_simples
   ALTER nome TYPE VARCHAR(30);

-- Excluir restrição
ALTER TABLE tabela_simples
   DROP CONSTRAINT chk_pais_us;