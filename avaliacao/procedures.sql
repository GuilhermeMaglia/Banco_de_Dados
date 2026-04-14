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