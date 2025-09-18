CREATE TABLE minha_tabela (
   u_id SERIAL,
   pais VARCHAR(2),
   nome VARCHAR(15)
);

INSERT INTO 
   minha_tabela (pais, nome)
VALUES
   ('BR', 'Brasil'),
   ('US', 'America'),
   ('FR', 'Franca');

DROP TABLE IF EXISTS minha_tabela;  