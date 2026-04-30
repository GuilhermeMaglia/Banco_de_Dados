
-- Crie uma PROCEDURE 
-- chamada realizar_inscricao(aluno_id INT, curso_id INT) 
-- que receba o ID de um aluno e de um curso e insira um novo 
-- registro na tabela inscricao. 

DELIMITER $$

    CREATE PROCEDURE realizar_inscricao(aluno_id INT, curso_id INT)
    BEGIN 
        INSERT INTO inscricao (id_aluno, id_curso, data_inscricao, status) 
        VALUES (aluno_id, curso_id, CURDATE(), 'ativo');
    END$$

DELIMITER ;


