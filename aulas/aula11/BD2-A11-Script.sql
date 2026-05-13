DROP TABLE IF EXISTS criador;
CREATE TABLE IF NOT EXISTS criador (
  id   INT(8)  NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS animal;
CREATE TABLE IF NOT EXISTS animal (
  id        INT(8)  NOT NULL AUTO_INCREMENT,
  sexo      CHAR(1) NOT NULL,
  idCriador INT(8)  NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE animal
  ADD CONSTRAINT FK_criador FOREIGN KEY (idCriador) REFERENCES criador (id);

INSERT INTO criador (nome)
VALUES
('Pablitus'),
('Angelina'),
('ReiDecio'),
('GladiMau');

INSERT INTO animal (sexo, idCriador)
VALUES
('F', 1),
('F', 2),
('F', 3),
('F', 1),
('F', 2),
('F', 1),
('F', 2),
('M', 1),
('M', 2),
('M', 1),
('M', 3),
('M', 1),
('M', 3),
('M', 1),
('M', 2),
('M', 1),
('M', 1),
('M', 1),
('M', 1),
('F', 2),
('F', 3),
('M', 3);

SELECT * FROM criador;

SELECT * FROM animal;

SELECT
  criador.nome       AS 'Criador',
  animal.sexo        AS 'Animal Sexo',
  COUNT(animal.sexo) AS 'Total'
FROM criador
LEFT JOIN animal ON criador.id = animal.idCriador
GROUP BY criador.nome, animal.sexo
ORDER BY criador.nome;


SELECT
  criador.nome as Criador,
  SUM(CASE WHEN (animal.sexo = 'F') THEN 1 ELSE 0 END) AS 'Total Femeas',
  SUM(CASE WHEN (animal.sexo = 'M') THEN 1 ELSE 0 END) AS 'Total Machos',
  COUNT(animal.sexo) AS 'Total Geral'
FROM criador
LEFT JOIN animal ON criador.id = animal.idCriador
GROUP BY criador.nome
ORDER BY criador.nome;


DROP TABLE IF EXISTS pergunta;
CREATE TABLE pergunta (
   id        INT(11) NOT NULL AUTO_INCREMENT,
   descricao VARCHAR(256) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE KEY (descricao)
);

DROP TABLE IF EXISTS reposta;
CREATE TABLE resposta (
   id         INT(11) NOT NULL AUTO_INCREMENT,
   idPergunta INT(11) NOT NULL,
   resposta VARCHAR(256) NOT NULL DEFAULT 'Sem resposta',
   PRIMARY KEY (id)
);

ALTER TABLE resposta
  ADD CONSTRAINT FK_pergunta FOREIGN KEY (idPergunta) REFERENCES pergunta (id);

INSERT INTO pergunta
VALUES
(1, 'Qual SGBD você prefere?'),
(2, 'Qual SGBD você irá usar em seu próximo projeto?');

INSERT INTO resposta
VALUES
(1,1,'MySQL'),
(2,1,'MySQL'),
(3,1,'MySQL'),
(4,1,'Oracle'),
(5,1,'PostgreSQL'),
(6,1,'MySQL'),
(9,1,'MSSQLServer'),
(10,1,'MySQL'),
(11,1,'Oracle'),
(12,1,'PostgreSQL'),
(13,1,'MySQL'),
(16,1,'MySQL'),
(17,1,'MySQL'),
(18,1,'Oracle'),
(19,1,'PostgreSQL'),
(20,1,'MySQL'),
(23,2,'Oracle'),
(29,2,'MySQL'),
(30,2,'MySQL'),
(31,2,'MySQL'),
(32,2,'MySQL'),
(33,2,'MySQL'),
(34,2,'PostgreSQL'),
(35,2,'PostgreSQL'),
(36,2,'PostgreSQL'),
(52,2,'Oracle'),
(53,2,'Oracle'),
(54,2,'Oracle'),
(55,2,'Oracle'),
(56,2,'Oracle'),
(57,2,'Oracle'),
(58,2,'MySQL'),
(59,2,'MySQL'),
(60,2,'MySQL'),
(61,2,'MySQL'),
(62,2,'MySQL'),
(63,2,'MySQL'),
(64,2,'MySQL'),
(65,2,'MSSQLServer'),
(66,2,'MySQL'),
(67,2,'MySQL'),
(68,2,'MySQL'),
(69,2,'MySQL'),
(70,2,'MySQL'),
(71,2,'MySQL'),
(72,2,'MySQL'),
(73,2,'MySQL'),
(74,2,'MySQL'),
(75,2,'MSSQLServer'),
(76,2,'MySQL'),
(77,2,'MySQL'),
(78,2,'PostgreSQL'),
(79,2,'PostgreSQL'),
(80,2,'PostgreSQL'),
(81,2,'MSSQLServer'),
(82,2,'PostgreSQL'),
(83,2,'PostgreSQL');

-- Consulta normal
SELECT pergunta.descricao, resposta.resposta, COUNT(resposta.resposta)
FROM  pergunta
LEFT JOIN resposta ON pergunta.id = resposta.idPergunta
GROUP BY pergunta.descricao, resposta.resposta
ORDER BY pergunta.descricao;


SELECT
  pergunta.descricao,
  SUM(IF(resposta.resposta = 'MySQL',       1, 0)) AS 'MySQL',
  SUM(IF(resposta.resposta = 'Oracle',      1, 0)) AS 'Oracle',
  SUM(IF(resposta.resposta = 'PostgreSQL',  1, 0)) AS 'PostgreSQL',
  SUM(IF(resposta.resposta = 'MSSQLServer', 1, 0)) AS 'MSSQLServer'
FROM pergunta
INNER JOIN resposta ON resposta.idPergunta = pergunta.id
GROUP BY pergunta.id, pergunta.descricao
ORDER BY pergunta.descricao;

  SELECT
    pergunta.descricao,
    SUM(CASE WHEN (resposta.resposta = 'MySQL')       THEN 1 ELSE 0 END) AS 'MySQL',
    SUM(CASE WHEN (resposta.resposta = 'Oracle')      THEN 1 ELSE 0 END) AS 'Oracle',
    SUM(CASE WHEN (resposta.resposta = 'PostgreSQL')  THEN 1 ELSE 0 END) AS 'PostgreSQL',
    SUM(CASE WHEN (resposta.resposta = 'MSSQLServer') THEN 1 ELSE 0 END) AS 'MSSQLServer'
  FROM pergunta
  INNER JOIN resposta ON resposta.idPergunta = pergunta.id
  GROUP BY pergunta.id, pergunta.descricao
  ORDER BY pergunta.descricao;

-- Mais um exemplo de x
DROP TABLE IF EXISTS teste_pivot;
CREATE TABLE teste_pivot (
  id      INT NOT NULL AUTO_INCREMENT,
  empresa VARCHAR(45) DEFAULT NULL,
  meio    VARCHAR(45) DEFAULT NULL,
  qtd     INT DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM;

INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Krolow', 'IMPRESSO', 1);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Krolow', 'IMPRESSO', 1);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Krolow', 'IMPRESSO', 3);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Krolow', 'IMPRESSO', 1);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Guanabara', 'SMS', NULL);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Guanabara', 'IMPRESSO', 1);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Guanabara', 'IMPRESSO', 1);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Guanabara', 'IMPRESSO', 2);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Guanabara', 'IMPRESSO', 4);
INSERT INTO teste_pivot (empresa, meio, qtd) VALUES ('Guanabara', 'IMPRESSO', 4);

SELECT empresa, meio, qtd, COUNT(qtd) 
FROM teste_pivot 
GROUP BY empresa, meio, qtd
ORDER BY empresa, meio, qtd;


SELECT  p.empresa,
    COUNT(
        CASE 
            WHEN p.meio='SMS' 
            THEN 1 
            ELSE NULL 
        END
    ) AS 'SMS',
    COUNT(
        CASE 
            WHEN p.meio='IMPRESSO' AND p.qtd = '1' 
            THEN p.qtd 
            ELSE NULL 
        END
    ) AS 'IMPR.1pg',
    COUNT(
        CASE 
            WHEN p.meio='IMPRESSO' AND p.qtd = '2' 
            THEN p.qtd 
            ELSE NULL 
        END
    ) AS 'IMPR.2pg',
    COUNT(
        CASE 
            WHEN p.meio='IMPRESSO' AND p.qtd = '3' 
            THEN p.qtd 
            ELSE NULL 
        END
    ) AS 'IMPR.3pg',
    COUNT(
        CASE 
            WHEN p.meio='IMPRESSO' AND p.qtd = '4' 
            THEN p.qtd 
            ELSE NULL 
        END
    ) AS 'IMPR.4pg'
FROM    teste_pivot p
GROUP BY p.empresa
ORDER BY p.empresa;
