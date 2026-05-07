/* 1. Crie uma PROCEDURE 'registrar_emprestimo' que receba 
o ID do aluno e o ID do livro. Ela deve inserir o registro 
na tabela emprestimo. Note que 'data_devol' não deve ser 
preenchida aqui.*/

DELIMITER $$

    CREATE PROCEDURE registrar_emprestimo(id_aluno INT, id_livro INT)
    BEGIN 
        INSERT INTO emprestimo (id_aluno, id_livro, data_saida, status)
        VALUES (id_aluno, id_livro, CURDATE(), status);
    END$$

DELIMITER ;
