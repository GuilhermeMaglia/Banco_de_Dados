--  Utilizando controle de transação (START TRANSACTION, COMMIT, ROLLBACK), 
--  execute os seguintes passos:  
--  a. Inicie uma transação.  
--  b. Insira uma nova inscricao para o aluno de id = 2 no curso de id = 3.  
--  c. Atualize o status dessa mesma inscricao para 'concluída'.  
--  d. Se ambos os comandos forem bem-sucedidos, confirme a transação. 
--  Caso contrário, reverta todas as alterações. 

START TRANSACTION;

INSERT INTO inscricao (id_aluno, id_curso, data_inscricao, status)
VALUES (2, 3, CURDATE(), 'ativo');

UPDATE inscricao
SET status = 'concluida'
WHERE id_aluno = 2 AND id_curso = 3;

COMMIT;

