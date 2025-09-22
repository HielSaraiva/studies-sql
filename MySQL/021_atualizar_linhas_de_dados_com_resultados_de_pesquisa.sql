/*O MySQL não permite atualizar uma tabela com o uso de uma consulta na mesma tabela*/

UPDATE tabela_simples
SET id = (SELECT MIN(id) FROM tabela_simples) --> Poderia caso fosse outra tabela
WHERE pais = 'BR';