INSERT INTO curso (nome_curso, instrutor, carga_horaria) VALUES
('Introdução à Programação', 'Carlos Silva', 40),
('Banco de Dados Relacionais', 'Mariana Souza', 60),
('Desenvolvimento Web com JavaScript', 'João Pereira', 50),
('Machine Learning Básico', 'Ana Costa', 45),
('Redes de Computadores', 'Ricardo Almeida', 55),
('Engenharia de Software', 'Fernanda Lima', 70),
('Segurança da Informação', 'Paulo Mendes', 35),
('Análise de Dados com Python', 'Beatriz Rocha', 65);

UPDATE curso
SET instrutor = 'Gldimir Catarino'
WHERE id = 1;

INSERT INTO aluno (nome_aluno, email, data_cadastro) VALUES
('Lucas Andrade', 'lucas.andrade@email.com', '2026-04-01'),
('Mariana Oliveira', 'mariana.oliveira@email.com', '2026-04-02'),
('João Pedro Santos', 'joao.santos@email.com', '2026-04-03'),
('Ana Beatriz Costa', 'ana.costa@email.com', '2026-04-04'),
('Rafael Lima', 'rafael.lima@email.com', '2026-04-05'),
('Fernanda Rocha', 'fernanda.rocha@email.com', '2026-04-06'),
('Gabriel Martins', 'gabriel.martins@email.com', '2026-04-07'),
('Camila Ferreira', 'camila.ferreira@email.com', '2026-04-08'),
('Thiago Almeida', 'thiago.almeida@email.com', '2026-04-09'),
('Juliana Souza', 'juliana.souza@email.com', '2026-04-10'),
('Bruno Carvalho', 'bruno.carvalho@email.com', '2026-04-11'),
('Patrícia Mendes', 'patricia.mendes@email.com', '2026-04-12'),
('Felipe Barbosa', 'felipe.barbosa@email.com', '2026-04-13'),
('Carolina Ribeiro', 'carolina.ribeiro@email.com', '2026-04-14'),
('Daniel Correia', 'daniel.correia@email.com', '2026-04-15');

