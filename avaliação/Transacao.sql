/* 5. CONTROLE DE TRANSAÇÃO:
Novo aluno 'Candidato Teste' pegando o livro ID 5. 
Se falhar, desfaça tudo.
*/

START TRANSACTION;

INSERT INTO aluno (nome)
VALUES ('Candidato Teste');

INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo, status)
VALUES (LAST_INSERT_ID(), 5, CURDATE(), 'aberto');

COMMIT