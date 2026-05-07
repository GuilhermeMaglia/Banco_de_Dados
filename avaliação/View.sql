/* 3. Crie uma VIEW 'v_emprestimos_ativos' que mostre: 
Nome do Aluno, Título do Livro e Status, 
apenas para livros que ainda NÃO foram devolvidos.
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
