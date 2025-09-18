-- Exibir linhas
SELECT *
FROM tabela_simples;

-- Incluir linhas
INSERT INTO tabela_simples
   (id, pais, nome)
VALUES
   (1, 'BR', 'Abirobado');

-- Excluir linhas
DELETE FROM tabela_simples
WHERE nome = 'Abirobado';