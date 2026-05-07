/*
Sistema de Gerenciamento de Biblioteca Acadêmica
*/

DROP DATABASE IF EXISTS aula10;
CREATE DATABASE aula10;
USE aula10;

CREATE TABLE autor (
    id            INT AUTO_INCREMENT,
    nome_autor    VARCHAR(150) NOT NULL,
    nacionalidade VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE livro (
    id                    INT AUTO_INCREMENT,
    titulo                VARCHAR(200) NOT NULL,
    id_autor              INT,
    quantidade_disponivel INT DEFAULT 5,
    PRIMARY KEY (id),
    FOREIGN KEY (id_autor) REFERENCES autor(id)
);

CREATE TABLE aluno (
    id            INT AUTO_INCREMENT,
    nome_aluno    VARCHAR(150) NOT NULL,
    email         VARCHAR(100) UNIQUE,
    data_adesao   DATE,
    PRIMARY KEY (id)
);

CREATE TABLE emprestimo (
    id             INT AUTO_INCREMENT,
    id_aluno       INT,
    id_livro       INT,
    data_saida     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_devol     DATE DEFAULT NULL, -- Fica vazio até a devolução real
    status         VARCHAR(20) DEFAULT 'aberto',
    PRIMARY KEY (id),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id),
    FOREIGN KEY (id_livro) REFERENCES livro(id)
);

CREATE TABLE log_operacoes (
    id            INT AUTO_INCREMENT,
    descricao     VARCHAR(255),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

INSERT INTO autor (nome_autor, nacionalidade) VALUES 
('Gladimir', 'Uruguaio'), 
('Edécio', 'Brasileiro'), 
('Angelo', 'Brasileiro'), 
('Monks', 'Espanhol'), 
('Wagner', 'Brasileiro'), 
('Guto', 'Brasileiro');

INSERT INTO aluno (nome_aluno, email, data_adesao) VALUES 
('Elinton', 'elinton.p@uol.com.br', CURDATE()),
('Júlia', 'julia.santos@bol.com.br', CURDATE()),
('Henrique', 'henrique88@zipmail.com.br', CURDATE()),
('Ryan', 'ryan_dev@aol.com', CURDATE()),
('Louise', 'louise_v@terra.com.br', CURDATE()),
('Heitor', 'heitor.oliveira@ig.com.br', CURDATE()),
('Manoela', 'manu_rs@bol.com.br', CURDATE()),
('Eduardo', 'edu_farias@ajato.com.br', CURDATE()),
('Ramon', 'ramon.valdez@uol.com.br', CURDATE()),
('Guilherme', 'gui_gui@superig.com.br', CURDATE());

INSERT INTO livro (titulo, id_autor, quantidade_disponivel) VALUES 
('Dominando SQL', 1, 3),
('Desenvolvimento Web Moderno', 2, 5),
('Lógica e Algoritmos', 3, 2),
('Segurança em Nuvem', 4, 4),
('Sistemas Distribuídos', 1, 2);

/* 1. Crie uma PROCEDURE 'registrar_emprestimo' que receba o ID do aluno e o ID do livro.
Ela deve inserir o registro na tabela emprestimo. Note que 'data_devol' não deve ser preenchida aqui.

TESTE: Execute para o aluno Ryan (ID 4) pegando o livro 'Segurança em Nuvem' (ID 4).
VERIFICAÇÃO: O campo data_devol deve estar como NULL.
*/

DELIMITER $$

    CREATE PROCEDURE registrar_emprestimo(id_aluno INT, id_livro INT)
    BEGIN 
        INSERT INTO emprestimo (id_aluno, id_livro, data_saida, status)
        VALUES (id_aluno, id_livro, CURDATE(), status);
    END$$

DELIMITER ;

/* 2. Crie um TRIGGER 'tg_atualiza_estoque' que, APÓS um empréstimo ser registrado,
diminua em 1 a 'quantidade_disponivel' na tabela livro.

TESTE: Henrique (ID 3) pegando 'Lógica e Algoritmos' (ID 3).
VERIFICAÇÃO: A quantidade do livro ID 3 deve diminuir de 2 para 1 unidade.
*/

DELIMITER $$

    CREATE TRIGGER tg_atualiza_estoque
    AFTER INSERT ON emprestimo
    FOR EACH ROW
    BEGIN
        UPDATE livro l
        SET quantidade_disponivel = quantidade_disponivel - 1
        WHERE id = l.id;
    END $$

DELIMITER ;

/* 3. Crie uma VIEW 'v_emprestimos_ativos' que mostre: Nome do Aluno, Título do Livro 
e Status, apenas para livros que ainda NÃO foram devolvidos.
*/

CREATE VIEW v_emprestimos_ativos AS 
SELECT
    a.nome_aluno AS aluno_nome,
    l.titulo AS titulo_livro,
    e.status
FROM 
    emprestimo e
JOIN
    aluno a ON e.id_aluno = a.id
JOIN 
    livro l ON e.id_livro = l.id
WHERE
    e.status <> 'devolvido';

/* 4. Crie um TRIGGER 'tg_registrar_devolucao' que, sempre que o status de um empréstimo
for alterado para 'devolvido', preencha a coluna 'data_devol' com a data atual (CURDATE())
e insira um registro na tabela log_operacoes.

TESTE: Altera o status do empréstimo do Ryan (criado na questão 3) para 'devolvido'.
VERIFICAÇÃO: A data_devol deve ser preenchida automaticamente e o log gerado.
*/

DELIMITER $$

    CREATE TRIGGER tg_registrar_devolucao
    BEFORE UPDATE ON emprestimo
    FOR EACH ROW 
    BEGIN
        IF NEW.status = 'devolvido' AND OLD.status <> 'devolvido' THEN
            SET NEW.data_devol = CURDATE();
            INSERT INTO log_operacoes (descricao, data_operacao)
            VALUES (
            CONCAT('Empréstimo ID ' , NEW.id , 'devolvido'),
            NOW()
            );
        END IF;
    END $$

DELIMITER ;

/* 5. CONTROLE DE TRANSAÇÃO:
Novo aluno 'Candidato Teste' pegando o livro ID 5. Se falhar, desfaça tudo.
*/

START TRANSACTION;

INSERT INTO aluno (nome)
VALUES ('Candidato Teste');

INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo, status)
VALUES (LAST_INSERT_ID(), 5, CURDATE(), 'aberto');

COMMIT

/* 6. CONSULTA FINAL:
Liste autores e total de empréstimos (mesmo os que possuem 0).
*/

SELECT
    a.nome_autor AS autor,
    COUNT(e.id) AS total_emprestimos
FROM autor a
LEFT JOIN livro l ON a.id = l.id_autor
LEFT JOIN emprestimo e ON l.id = e.id_livro
GROUP BY a.id, a.nome_autor
ORDER BY total_emprestimos DESC;