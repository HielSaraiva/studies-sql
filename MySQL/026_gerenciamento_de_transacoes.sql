-- Confirme alterações com COMMIT

-- Inicie a transação
START TRANSACTION; -- Uma ou outra
BEGIN;

-- Realize a alteração
SELECT *
FROM tabela_simples;

DELETE FROM tabela_simples
WHERE nome = 'Abirobado';

SELECT *
FROM tabela_simples;

-- Confirme a alteração
COMMIT;


-- Desfaça alterações com ROLLBACK

-- Inicie a transação
START TRANSACTION; -- Uma ou outra
BEGIN;

-- Realize a alteração
SELECT *
FROM tabela_simples;

DELETE FROM tabela_simples
WHERE nome = 'Abirobado';

SELECT *
FROM tabela_simples;

-- Confirme a alteração
ROLLBACK;