CREATE TABLE nova_tabela_duas_colunas (
   id INTEGER,
   nome VARCHAR(15)
);

INSERT INTO nova_tabela_duas_colunas
   (id, nome)
SELECT id, nome
FROM tabela_simples
WHERE id >=2;