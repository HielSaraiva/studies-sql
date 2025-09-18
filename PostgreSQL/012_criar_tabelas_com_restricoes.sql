CREATE TABLE outra_tabela (
   pais VARCHAR(2) NOT NULL,
   nome VARCHAR(15) NOT NULL,
   descricao VARCHAR(50),
   CONSTRAINT pk_outra_tabela 
      PRIMARY KEY (pais, nome)
);

CREATE TABLE minha_tabela (
   id INTEGER NOT NULL,
   pais VARCHAR(2) DEFAULT 'CA' 
      CONSTRAINT chk_pais 
      CHECK (pais IN ('CA', 'US')),
   nome VARCHAR(15),
   cap_nome VARCHAR(15),
   CONSTRAINT pk
      PRIMARY KEY (id),
   CONSTRAINT fk1
      FOREIGN KEY (pais, nome)
      REFERENCES outra_tabela (pais, nome),
   CONSTRAINT unq_pais_nome
      UNIQUE (pais, nome),
   CONSTRAINT chk_upper_name
      CHECK (cap_nome = UPPER(nome))
);

/*
- A palavra-chave CONSTRAINT nomeia a restrição para referência futura e é opcional.
- As palavras-chave de restrição podem aparecer depois do tipo de dados ou ao final de todas as colunas e tipos de dados, dependendo da escolha do usuário.
- Opções de restrição: NOT NULL, DEFAULT, CHECK, UNIQUE, PRIMARY KEY, FOREIGN KEY.
- Ao criar um PK, está sendo imposto que ela deve ser NOT NULL e UNIQUE.
*/

DROP TABLE IF EXISTS outra_tabela, minha_tabela;