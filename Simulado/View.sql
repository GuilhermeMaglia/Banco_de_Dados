--  Crie uma VIEW chamada v_inscricoes_detalhadas que exiba o 
--  nome do aluno (nome_aluno), o email, 
--  o nome do curso e a data da inscrição. 

CREATE VIEW v_inscricoes_detalhadas AS
SELECT 
    a.nome_aluno,
    a.email,
    c.nome_curso,
    i.data_inscricao
FROM 
    inscricao i 
JOIN 
    aluno a ON i.id_aluno = a.id 
JOIN
    curso c ON i.id_curso = c.id;