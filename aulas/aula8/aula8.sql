DROP DATABASE IF EXISTS aula08; 
CREATE DATABASE aula08; 
USE aula08;


CREATE TABLE departamento ( 
    id  INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(50) NOT NULL 
    ) ENGINE=InnoDB; 
    
CREATE TABLE funcionario ( 
    id       INT AUTO_INCREMENT PRIMARY KEY, 
    nome     VARCHAR(100),
    email    VARCHAR(100),
    salario  DECIMAL(10,2), 
    departamento_id INT, 
    FOREIGN KEY (departamento_id) REFERENCES departamento(id) 
    ) ENGINE=InnoDB;

------------------------------------------------------------------

INSERT INTO departamento (nome) VALUES 
('TI'), ('RH'), ('Financeiro');

INSERT INTO funcionario (nome, email, salario, departamento_id) VALUES 
('João Silva', 'joao@empresa.com', 4500.00, 1), 
('Maria Souza', 'maria@empresa.com', 5200.00, 2), 
('Carlos Lima', 'carlos@empresa.com', 6100.00, 1), 
('Ana Paula', 'ana@empresa.com', 4000.00, 3);

CREATE USER 'consultor'@'localhost' IDENTIFIED BY '1234'; 
CREATE USER 'gerente'@'localhost' IDENTIFIED BY '1234';

----------------------------------------------------------------

GRANT SELECT ON aula08.* TO 'consultor'@'localhost'; 
GRANT ALL PRIVILEGES ON aula08.* TO 'gerente'@'localhost';

CREATE ROLE analista; 
GRANT SELECT, INSERT ON aula08.funcionario TO analista; 
GRANT analista TO 'consultor'@'localhost';

REVOKE analista FROM 'consultor'@'localhost';

----------------------------------------------------------

GRANT SELECT (nome) ON aula08.departamento TO 'gerente'@'localhost';
GRANT SELECT (nome, email) ON aula08.funcionario TO 'consultor'@'localhost';
GRANT UPDATE (email, fone) ON aula08.funcionario TO 'gerente'@'localhost';

