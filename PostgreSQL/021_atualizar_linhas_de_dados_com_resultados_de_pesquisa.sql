UPDATE tabela_simples
SET id = (SELECT MIN(id) FROM tabela_simples)
WHERE pais = 'BR';