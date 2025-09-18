-- Exibir restrições
SHOW CREATE TABLE tabela_simples;

-- Incluir restrição
ALTER TABLE tabela_simples
   ADD CONSTRAINT chk_pais_us
   CHECK (nome = 'US');

-- Modificar restrição
ALTER TABLE tabela_simples
   MODIFY nome VARCHAR(30);

-- Excluir restrição
ALTER TABLE tabela_simples
   DROP CHECK chk_pais_us;