/* 6. CONSULTA FINAL:
Liste autores e total de empréstimos 
(mesmo os que possuem 0).
*/

SELECT
    a.nome_autor AS autor,
    COUNT(e.id) AS total_emprestimos
FROM autor a
LEFT JOIN livro l ON a.id = l.id_autor
LEFT JOIN emprestimo e ON l.id = e.id_livro
GROUP BY a.id, a.nome_autor
ORDER BY total_emprestimos DESC;