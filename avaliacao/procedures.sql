/*
5) Crie uma stored procedure chamada alteraValorIngresso(valor) 
que altere o valor de todos os ingressos vendidos para o valor fornecido como parâmetro. 
Após a atualização, a procedure deve listar os ingressos afetados. 
*/

DELIMITER //

    CREATE PROCEDURE alteraValorIngresso (in valor DOUBLE)
    BEGIN

        UPDATE venda
        SET valorIngresso = valor;

    SELECT
        v.id AS ID_venda,
        f.tituloPortugues AS Nome_do_Filme,
        v.data AS Data_Venda,
        v.valorIngresso AS Novo_Valor_Ingresso
    FROM venda v
    JOIN sessao s ON v.idSessao = s.id
    JOIN filme f ON idFilme = f.id;
END //

DELIMITER ;

/* 
6) Crie uma função (MySQL) ou procedure (PostgreSQL) que receba o ID de um usuário 
e atualize a situação de todas as suas parcelas para "PAGA". 
*/

DELIMITER //

    CREATE PROCEDURE pagarParcelasUsuario(IN p_idUsuario INT)
    BEGIN
        UPDATE parcela p
        JOIN venda v ON p.idVenda = v.id
            SET p.Situacao = 'PAGA'
            WHERE v.idUsuario = p_idUsuario;

    SELECT CONCAT('Parcelas do usuário ', p_idUsuario, ' atualizadas com sucesso.') AS Status;
    END //

DELIMITER ;

/*
7) Crie uma stored procedure relVendas(idUsuario) que receba o id de um usuário e liste todas as
 parcelas associadas, juntamente com a situação de pagamento de cada uma
*/

DELIMITER //

    CREATE PROCEDURE relVendas(IN p_idUsuario INT)
    BEGIN
        SELECT
            u.nome AS usuario,
            f.tituloPortugues AS Filme,
            v.id AS ID_Venda,
            p.id AS ID_Parcela,
            p.valor AS Valor_Parcela,
            p.vencimento AS Vencimento,
            p.situacao AS Status_Pagamento
        FROM usuario u
        JOIN venda v ON u.id = v.idUsuario 
        JOIN sessao s ON v.idSessao = s.id 
        JOIN filme f ON s.idFilme = f.id 
        JOIN parcela p ON v.id = p.idVenda
        WHERE u.id = p_idUsuario
        ORDER BY p.vencimento ASC;
END //

DELIMITER ;

/*
8) Crie uma stored procedure visualizaVendas(tipoVenda) 
que receba um parâmetro (1 para à vista, 2 para parcelado) e 
retorne o somatório do valor das vendas para o tipo de pagamento selecionado.
*/

DELIMITER //

    CREATE PROCEDURE visualizaVendas (IN p_idVenda INT)
    BEGIN
        SELECT 
            tp.nome AS Tipo_Pagamento,
            COALESCE(SUM(v.valorIngresso), 0) AS Total_Arrecadado
        FROM tipoPagto tp
        LEFT JOIN venda v ON tp.id = v.idTipoPagto
        WHERE tp.id = p_idVenda
        GROUP BY tp.nome;
END //

DELIMITER ;

/*
 9) Crie uma procedure que receba o nome de um ator e liste todos 
 os filmes em que ele participou. 
*/ 

DELIMITER //

    CREATE PROCEDURE visualizaFilmesAtor(IN nome_ator VARCHAR(45))
    BEGIN
        SELECT
            a.nome AS Ator,
            f.tituloPortugues AS Filme,
            f.duracao AS Duracao_Minutos
        FROM ator a
        JOIN elenco e ON a.id = e.idAtor
        JOIN filme f ON e.idFilme = f.id
        WHERE a.nome LIKE CONCAT('%', nome_ator, '%');
    END //

DELIMITER ;

/* 
10) Crie uma procedure que liste o nome dos atores 
que ainda não participaram de nenhum filme. 
*/ 

DELIMITER // 

    CREATE PROCEDURE atoresSemFilmes()
    BEGIN 
        SELECT
            a.nome AS Ator_Sem_Filme
        FROM ator a
        LEFT JOIN elenco e ON a.id = e.idAtor
        WHERE e.idAtor IS NULL
        ORDER BY a.nome;
    END //

DELIMITER ;

/* 
11) Crie uma procedure que liste o título e o gênero de 
todos os filmes que ainda não foram exibidos em nenhuma
sessão de cinema. 
*/ 

DELIMITER //

    CREATE PROCEDURE filmesSemSessao()
    BEGIN 
        SELECT
            f.tituloPortugues AS Titulo_do_Filme,
            g.nome AS Genero
        FROM filme f 
        JOIN genero g ON f.idGenero = g.id
        LEFT JOIN sessao s ON f.id = s.idFilme
        WHERE s.id IS NULL;
    END //

DELIMITER ;

/* 
12) Crie uma procedure que receba o nome de uma cidade como 
parâmetro e liste todos os cinemas localizados nesta cidade. 
*/ 

DELIMITER //

CREATE PROCEDURE listaCinemaCidade(IN p_nome_cidade VARCHAR(45))
BEGIN
    SELECT 
        c.nome AS Cidade,
        ci.nomeFantasia AS Cinema,
        ci.endereco AS Endereco,
        ci.bairro AS Bairro
    FROM cinema ci
    JOIN cidade c ON ci.idCidade = c.id
    WHERE c.nome LIKE CONCAT('%', p_nome_cidade, '%')
    ORDER BY ci.nomeFantasia;
END //

DELIMITER ;

/* 
13) Crie uma procedure que receba dois parâmetros
(gênero atual e gênero novo) e altere o gênero de 
todos os filmes que correspondam ao gênero atual 
para o novo gênero informado. 
*/ 

DELIMITER //

    CREATE PROCEDURE alteraGenero(
        IN p_genero_atual VARCHAR(45),
        IN p_genero_novo VARCHAR(45)
    )
    BEGIN 
        UPDATE filme f
        JOIN genero g_atual ON f.idGenero = g_atual.id
        JOIN genero g_novo ON g_novo.nome = p_genero_novo
        SET f.idGenero = g_novo.id 
        WHERE g_atual.nome = p_genero_atual;
    END //

DELIMITER ;

/* 
14) Crie uma consulta para listar o título e a 
duração dos filmes de um determinado gênero 
lançados após uma data específica. 
Receba o nome do gênero e a data como parâmetros. 
*/

DELIMITER // 

    CREATE PROCEDURE generoData(
        IN p_nome_genero VARCHAR(45),
        IN p_data_limite DATE
    )
    BEGIN 
        SELECT DISTINCT
            f.tituloPortugues AS Titulo,
            f.duracao AS Duracao_Minutos
        FROM filme f
        JOIN genero g ON f.idGenero = g.id
        JOIN sessao s ON f.id = s.idFilme
        WHERE g.nome = p_nome_genero
            AND s.data > p_data_limite;
    END //

DELIMITER ;

/* 
15) Crie uma consulta que liste todas as sessões 
onde a ocupação do público foi superior a 
80% da capacidade do cinema. 
*/ 

DELIMITER //

    CREATE PROCEDURE altaOcupacao()
    BEGIN 
        SELECT
            f.tituloPortugues AS Filme,
            c.nomeFantasia AS Cinema,
            s.data AS Data_Sessao,
            s.publico AS Publico_Presente,
            c.capacidade AS Capacidade_Total,
            ROUND((s.publico / c.capacidade) * 100, 2) AS Porcentagem_Ocupacao
    FROM sessao s
    JOIN cinema c ON s.idCinema = c.id
    JOIN filme f ON s.idFilme = f.id
    WHERE s.publico > (c.capacidade * 0.8)
    ORDER BY Porcentagem_Ocupacao DESC;
END //

DELIMITER ;