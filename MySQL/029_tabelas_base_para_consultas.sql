-- Criando tabelas
CREATE TABLE IF NOT EXISTS county (
   id INT AUTO_INCREMENT,
   name VARCHAR(30) NOT NULL,
   population BIGINT NOT NULL,
   CONSTRAINT pk_county PRIMARY KEY (id),
   CONSTRAINT unq_name_county UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS owner (
   id INT AUTO_INCREMENT,
   name VARCHAR(30) NOT NULL,
   phone VARCHAR(12),
   type VARCHAR(7) NOT NULL,
   CONSTRAINT pk_owner PRIMARY KEY (id),
   CONSTRAINT unq_owner_name UNIQUE (name),
   CONSTRAINT chk_owner_type CHECK (type IN ('public', 'private'))
);

CREATE TABLE IF NOT EXISTS waterfall (
   id INT AUTO_INCREMENT,
   name VARCHAR(30) NOT NULL,
   open_to_public CHAR(1) NOT NULL DEFAULT 'n',
   owner_id INT,
   county_id INT NOT NULL,
   CONSTRAINT pk_waterfall PRIMARY KEY (id),
   CONSTRAINT fk_waterfall_o FOREIGN KEY (owner_id) REFERENCES owner (id),
   CONSTRAINT fk_waterfall_c FOREIGN KEY (county_id) REFERENCES county (id),
   CONSTRAINT unq_waterfall_name UNIQUE (name),
   CONSTRAINT chk_waterfall_open_to_public CHECK (LOWER(open_to_public) IN ('y', 'n'))
);

CREATE TABLE IF NOT EXISTS tour (
   id INT AUTO_INCREMENT,
   name VARCHAR(30) NOT NULL,
   stop INT NOT NULL,
   CONSTRAINT pk_tour PRIMARY KEY (id),
   CONSTRAINT fk_tour_w FOREIGN KEY (stop) REFERENCES waterfall (id),
   CONSTRAINT unq_tour_name UNIQUE (name)
);

-- Inserindo dados nas tabelas
INSERT INTO
   county (name, population)
VALUES
   ('Los Angeles', 10014009),
   ('Cook', 5150233),
   ('Harris', 4713325),
   ('Maricopa', 4485579),
   ('San Diego', 3338575),
   ('Miami-Dade', 2701201),
   ('Kings', 2648488),
   ('Dallas', 2613539),
   ('Queens', 2253858),
   ('Riverside', 2470546),
   ('King', 2268754),
   ('Wayne', 1759335),
   ('Clark', 2231641),
   ('Tarrant', 2054452),
   ('Broward', 1957440),
   ('Middlesex', 1572979),
   ('Fairfax', 1147532),
   ('New York', 1628706),
   ('Suffolk', 1550921),
   ('Allegheny', 1223348),
   ('Hennepin', 1269040),
   ('Montgomery', 1050688),
   ('Alameda', 1663110),
   ('Denver', 715522),
   ('Duval', 957750),
   ('Sacramento', 1552058),
   ('Franklin', 1327117),
   ('Philadelphia', 1584064),
   ('St. Louis', 994205),
   ('Mecklenburg', 1129528),
   ('Hartford', 894014),
   ('Contra Costa', 1153526),
   ('Pinellas', 977232),
   ('Palm Beach', 1496770),
   ('Oakland', 1269223),
   ('Cuyahoga', 1235071),
   ('Wake', 1129410),
   ('Honolulu', 987654),
   ('Erie', 919349),
   ('Macomb', 872930),
   ('Salt Lake', 1185244),
   ('Pima', 1047240),
   ('El Paso', 837854),
   ('Prince George', 918073),
   ('Baltimore', 828233),
   ('Marion', 970034),
   ('Milwaukee', 945034),
   ('Delaware', 558999),
   ('Fulton', 1063991),
   ('Shelby', 930777),
   ('Orange', 1400844),
   ('Bexar', 2003554),
   ('Fresno', 999101),
   ('Jackson', 699709),
   ('Jefferson', 667232),
   ('Monroe', 741770),
   ('Dane', 561504),
   ('Hidalgo', 868353),
   ('San Bernardino', 2181655),
   ('Essex', 783705),
   ('Gwinnett', 942627),
   ('DuPage', 927233),
   ('Norfolk', 706245);

INSERT INTO
   owner (name, phone, type)
VALUES
   ('TechCorp Inc.', '555-101-1234', 'private'),
   ('Governo Municipal', '555-202-5678', 'public'),
   ('E-commerce Solutions', '555-303-9012', 'private'),
   (
      'Parque Nacional da Montanha',
      '555-404-3456',
      'public'
   ),
   ('Grupo Varejista', '555-505-7890', 'private'),
   ('Prefeitura Central', '555-606-2345', 'public'),
   ('Global Finance', '555-707-6789', 'private'),
   (
      'Estado de Minas Gerais',
      '555-808-1234',
      'public'
   ),
   ('Consultoria Alpha', '555-909-5678', 'private'),
   (
      'Agência de Meio Ambiente',
      '555-110-9012',
      'public'
   ),
   ('Fábrica de Inovação', '555-221-3456', 'private'),
   ('Secretaria de Saúde', '555-332-7890', 'public'),
   ('Rede de Hotéis Luxo', '555-443-2345', 'private'),
   (
      'Governo do Rio de Janeiro',
      '555-554-6789',
      'public'
   ),
   ('Construtora Fortes', '555-665-1234', 'private'),
   ('Instituto de Pesquisa', '555-776-5678', 'public'),
   ('Startup Criativa', '555-887-9012', 'private'),
   ('Polícia Federal', '555-998-3456', 'public'),
   (
      'Empresa de Logística A.',
      '555-009-7890',
      'private'
   ),
   ('Câmara dos Deputados', '555-112-2345', 'public'),
   ('Software Ltda.', '555-223-6789', 'private'),
   (
      'Prefeitura de São Paulo',
      '555-334-1234',
      'public'
   ),
   ('Indústria Quimica', '555-445-5678', 'private'),
   ('Governo de Brasília', '555-556-9012', 'public'),
   ('Fazenda Agro.', '555-667-3456', 'private'),
   ('Universidade Federal', '555-778-7890', 'public'),
   ('Escola de Idiomas', '555-889-2345', 'private'),
   (
      'Ministério da Educação',
      '555-990-6789',
      'public'
   ),
   ('Grupo de Mídia X', '555-123-1234', 'private'),
   (
      'Serviço de Limpeza Pública',
      '555-456-5678',
      'public'
   ),
   (
      'Empresa de Eletricidade',
      '555-789-9012',
      'private'
   ),
   ('Órgão de Trânsito', '555-012-3456', 'public'),
   ('Restaurante Tempero', '555-345-7890', 'private'),
   ('Correios do Brasil', '555-678-2345', 'public'),
   (
      'Comércio de Ferramentas',
      '555-901-6789',
      'private'
   ),
   ('Secretaria de Obras', '555-234-1234', 'public'),
   (
      'Clínica Médica Bem Estar',
      '555-567-5678',
      'private'
   ),
   ('Parque Estadual', '555-890-9012', 'public'),
   ('Estúdio de Design', '555-123-3456', 'private'),
   ('Governo do Paraná', '555-456-7890', 'public'),
   (
      'Transportadora Rápida',
      '555-789-2345',
      'private'
   ),
   (
      'Prefeitura de Curitiba',
      '555-012-6789',
      'public'
   ),
   ('Loja de Roupas', '555-345-1234', 'private'),
   ('Secretaria de Cultura', '555-678-5678', 'public'),
   ('Companhia de Seguros', '555-901-9012', 'private'),
   ('Instituto Histórico', '555-234-3456', 'public'),
   ('Fábrica de Pneus', '555-567-7890', 'private'),
   (
      'Sindicato dos Trabalhadores',
      '555-890-2345',
      'public'
   ),
   (
      'Empresa de Cosméticos',
      '555-123-6789',
      'private'
   ),
   (
      'Prefeitura de Salvador',
      '555-456-1234',
      'public'
   ),
   ('Clínica Veterinária', '555-999-9999', 'private'),
   ('Agência de Turismo', '555-888-8888', 'private'),
   (
      'Governo do Mato Grosso',
      '555-777-7777',
      'public'
   ),
   ('Indústria de Bebidas', NULL, 'private'),
   (
      'Secretaria de Esportes',
      '555-666-6666',
      'public'
   ),
   ('Jardim Botânico', '555-555-5555', 'public'),
   ('Academia de Artes', '555-444-4444', 'private'),
   ('Governo de Goiás', '555-333-3333', 'public'),
   ('Loja de Eletrônicos', NULL, 'private'),
   (
      'Prefeitura de Campinas',
      '555-222-2222',
      'public'
   ),
   ('Rede de Restaurantes', '555-111-1111', 'private'),
   (
      'Associação de Moradores',
      '555-000-0000',
      'public'
   ),
   (
      'Escritório de Advocacia',
      '555-123-4567',
      'private'
   ),
   ('Governo de Pernambuco', '555-765-4321', 'public'),
   ('Empresa de Roupas', '555-987-6543', 'private'),
   ('Secretaria de Habitação', NULL, 'public'),
   (
      'Comércio de Alimentos',
      '555-135-7924',
      'private'
   ),
   ('Governo da Bahia', '555-246-8013', 'public'),
   ('Companhia Aérea', '555-101-2020', 'private'),
   ('Cemitério Municipal', '555-303-4040', 'public'),
   ('Empresa de Segurança', NULL, 'private'),
   ('Governo do Ceará', '555-505-6060', 'public'),
   ('Hotel da Orla', '555-707-8080', 'private'),
   ('Secretaria de Turismo', '555-909-1010', 'public'),
   (
      'Indústria de Calçados',
      '555-212-3232',
      'private'
   ),
   (
      'Prefeitura de Fortaleza',
      '555-434-5454',
      'public'
   ),
   ('Consultoria Financeira', NULL, 'private'),
   (
      'Governo do Rio Grande do Sul',
      '555-656-7676',
      'public'
   ),
   ('Fazenda Orgânica', '555-878-9898', 'private'),
   (
      'Secretaria de Inovação',
      '555-090-9090',
      'public'
   );

INSERT INTO
   waterfall (name, open_to_public, owner_id, county_id)
VALUES
   ('Cataratas do Sol', 'y', 2, 1),
   ('Salto da Lua', 'n', 5, 2),
   ('Cachoeira do Grito', 'y', 1, 3),
   ('Véu da Noiva', 'y', 4, 4),
   ('Corredeiras do Dragão', 'n', NULL, 5),
   ('Cachoeira Sete Quedas', 'y', 3, 6),
   ('Queda do Trovão', 'y', 6, 7),
   ('Salto Esmeralda', 'y', 8, 8),
   ('Gruta Secreta', 'n', NULL, 9),
   ('Catarata das Araras', 'y', 7, 10),
   ('Cachoeira dos Macacos', 'y', 9, 11),
   ('Salto do Rio Claro', 'y', 10, 12),
   ('Queda da Borboleta', 'y', 12, 13),
   ('Véu de Cristal', 'y', 11, 14),
   ('Corredeira da Pedra Branca', 'n', 15, 15),
   ('Cachoeira do Abismo', 'y', 13, 16),
   ('Salto da Esperança', 'y', 14, 17),
   ('Queda da Floresta', 'n', NULL, 18),
   ('Catarata do Paraíso', 'y', 16, 19),
   ('Cachoeira do Cedro', 'y', 17, 20),
   ('Salto do Índio', 'y', 18, 21),
   ('Véu de Prata', 'y', 20, 22),
   ('Cachoeira da Estrela', 'y', 19, 23),
   ('Queda da Luz', 'n', 21, 24),
   ('Corredeiras da Serra', 'y', 22, 25),
   ('Salto da Paz', 'y', 23, 26),
   ('Cachoeira da Bica', 'y', 24, 27),
   ('Queda do Gigante', 'y', 25, 28),
   ('Véu de Ouro', 'y', 26, 29),
   ('Cataratas do Vale', 'y', 27, 30),
   ('Salto da Fênix', 'y', 28, 31),
   ('Cachoeira do Vento', 'n', NULL, 32),
   ('Queda do Arroio', 'y', 29, 33),
   ('Véu de Diamante', 'y', 30, 34),
   ('Corredeiras do Sol', 'y', 31, 35),
   ('Cachoeira do Pico', 'y', 32, 36),
   ('Salto do Cerrado', 'n', 33, 37),
   ('Queda da Ilha', 'y', 34, 38),
   ('Cachoeira do Poço', 'y', 35, 39),
   ('Véu de Esmeralda', 'y', 36, 40),
   ('Cataratas da Chuva', 'y', 37, 41),
   ('Salto do Lobo', 'y', 38, 42),
   ('Cachoeira da Serra Alta', 'y', 39, 43),
   ('Queda da Pedra', 'n', 40, 44),
   ('Véu de Safira', 'y', 41, 45),
   ('Corredeira do Cânion', 'y', 42, 46),
   ('Cachoeira do Eco', 'y', 43, 47),
   ('Salto do Lago Azul', 'y', 44, 48),
   ('Queda da Águia', 'n', NULL, 49),
   ('Catarata da Garganta', 'y', 45, 50),
   ('Cachoeira do Oásis', 'y', 1, 31),
   ('Salto do Crepúsculo', 'y', 2, 32),
   ('Queda da Caverna', 'n', 3, 33),
   ('Véu do Sertão', 'y', 4, 34),
   ('Corredeira da Montanha', 'y', 5, 35),
   ('Cachoeira do Deserto', 'n', NULL, 36),
   ('Salto da Serra Dourada', 'y', 6, 37),
   ('Queda do Sol Poente', 'y', 7, 38),
   ('Gruta da Floresta', 'n', 8, 39),
   ('Cataratas da Chuva Tropical', 'y', 9, 40),
   ('Cachoeira do Gavião', 'y', 10, 41),
   ('Salto da Jibóia', 'y', 11, 42),
   ('Queda do Riacho', 'y', 12, 43),
   ('Véu de Vidro', 'y', 13, 44),
   ('Corredeira da Ilha', 'n', NULL, 45),
   ('Cachoeira do Planalto', 'y', 14, 46),
   ('Salto do Mar', 'y', 15, 47),
   ('Queda da Ponte', 'n', 16, 48),
   ('Catarata do Vale Verde', 'y', 17, 49),
   ('Cachoeira do Moinho', 'y', 18, 50),
   ('Salto do Passarinho', 'y', 19, 1),
   ('Queda do Bambu', 'y', 20, 2),
   ('Cachoeira do Pescador', 'y', 21, 3),
   ('Véu da Tartaruga', 'n', 22, 4),
   ('Corredeira da Raposa', 'y', 23, 5),
   ('Salto do Peixe Dourado', 'y', 24, 6),
   ('Cachoeira do Eco Perdido', 'y', 25, 7),
   ('Queda do Leão', 'y', 26, 8),
   ('Véu do Pássaro', 'n', NULL, 9),
   ('Cachoeira da Nascente', 'y', 27, 10);

INSERT INTO
   tour (name, stop)
VALUES
   ('Rota das Cataratas', 1),
   ('Expedição Salto da Lua', 2),
   ('Tour da Cachoeira do Grito', 3),
   ('Passeio Véu da Noiva', 4),
   ('Trilha do Dragão', 5),
   ('Aventura nas Sete Quedas', 6),
   ('Caminhada do Trovão', 7),
   ('Roteiro Esmeralda', 8),
   ('Tour Gruta Secreta', 9),
   ('Expedição Araras', 10),
   ('Passeio dos Macacos', 11),
   ('Rota do Rio Claro', 12),
   ('Aventura da Borboleta', 13),
   ('Tour do Véu de Cristal', 14),
   ('Trilha da Pedra Branca', 15),
   ('Roteiro do Abismo', 16),
   ('Passeio Salto da Esperança', 17),
   ('Aventura na Floresta', 18),
   ('Tour do Paraíso', 19),
   ('Caminhada do Cedro', 20),
   ('Rota do Índio', 21),
   ('Expedição Véu de Prata', 22),
   ('Tour da Estrela', 23),
   ('Passeio da Luz', 24),
   ('Trilha da Serra', 25),
   ('Rota da Paz', 26),
   ('Caminhada da Bica', 27),
   ('Aventura do Gigante', 28),
   ('Tour do Véu de Ouro', 29),
   ('Passeio das Cataratas do Vale', 30),
   ('Expedição Fênix', 31),
   ('Rota do Vento', 32),
   ('Trilha do Arroio', 33),
   ('Aventura do Diamante', 34),
   ('Tour do Sol', 35),
   ('Passeio do Pico', 36),
   ('Caminhada do Cerrado', 37),
   ('Rota da Ilha', 38),
   ('Expedição do Poço', 39),
   ('Tour Véu de Esmeralda', 40),
   ('Aventura da Chuva', 41),
   ('Caminhada do Lobo', 42),
   ('Trilha da Serra Alta', 43),
   ('Rota da Pedra', 44),
   ('Passeio Véu de Safira', 45),
   ('Tour do Cânion', 46),
   ('Expedição do Eco', 47),
   ('Aventura do Lago Azul', 48),
   ('Caminhada da Águia', 49),
   ('Rota da Garganta', 50),
   ('Tour Cachoeira do Eco', 77),
   ('Roteiro Sete Quedas', 6),
   ('Tour Gruta da Caverna', 53),
   ('Expedição do Deserto', 56),
   ('Tour da Serra Alta', 43),
   ('Caminhada do Arroio', 33),
   ('Passeio da Serra Dourada', 57),
   ('Rota do Crepúsculo', 52),
   ('Caminhada do Moinho', 70),
   ('Aventura da Pedra', 44),
   ('Passeio do Vento', 32),
   ('Tour do Lobo', 42),
   ('Caminhada do Cânion', 46),
   ('Aventura da Raposa', 75),
   ('Passeio do Poço', 39),
   ('Tour da Nascente', 80),
   ('Rota do Leão', 78),
   ('Caminhada do Bambu', 72),
   ('Passeio da Fênix', 31),
   ('Tour do Oásis', 51);

-- Deletando tabelas
DROP TABLE IF EXISTS waterfall,
owner,
county,
tour;