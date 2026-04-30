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