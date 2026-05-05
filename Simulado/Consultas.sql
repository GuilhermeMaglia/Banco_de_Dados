SELECT 
    a.nome_aluno,
    c.nome_curso
FROM
    inscricao i
INNER JOIN 
    aluno a ON i.id_aluno = a.id
INNER JOIN 
    curso c ON i.id_curso = c.id
WHERE
    i.status = 'ativo';

-- Crie uma consulta que conte quantas inscrições 
-- cada curso possui.  O resultado deve exibir o 
-- nome do curso e o total de alunos inscritos, 
-- ordenados do curso com mais alunos para o com 
-- menos. 

SELECT 
    c.nome_curso,
    COUNT(i.id_aluno) AS total_alunos
FROM
    curso c
LEFT JOIN 
    inscricao i ON c.id = i.id_curso
GROUP BY
    c.nome_curso
ORDER BY 
    total_alunos DESC;