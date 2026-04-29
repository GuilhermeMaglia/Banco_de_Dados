CREATE DATABASE simulada;

CREATE TABLE aluno (
    id              INT NOT NULL AUTO_INCREMENT,
    nome_aluno      VARCHAR(150) NOT NULL,
    email           VARCHAR(100) NOT NULL,
    data_cadastro   DATE,
    PRIMARY KEY (id)
);

CREATE TABLE curso (
    id              INT NOT NULL AUTO_INCREMENT,
    nome_curso      VARCHAR(100) NOT NULL,
    instrutor       VARCHAR(100),
    carga_horaria   INT,
    PRIMARY KEY (id)
);

CREATE TABLE inscricao (
    id              INT NOT NULL AUTO_INCREMENT,
    id_aluno        INT,
    id_curso        INT,
    data_inscricao  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status          VARCHAR(20),
    PRIMARY KEY (id),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id),
    FOREIGN KEY (id_curso) REFERENCES curso(id)
);

CREATE TABLE log_inscricao (
    id                  INT NOT NULL AUTO_INCREMENT,
    id_inscricao_ref    INT,
    acao_realizada      VARCHAR(50),
    data_log            TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (id_inscricao_ref) REFERENCES inscricao(id)    
);