/* 2. Crie um TRIGGER 'tg_atualiza_estoque' que, APÓS um
empréstimo ser registrado,diminua em 1 a 
'quantidade_disponivel' na tabela livro.*/

DELIMITER $$

    CREATE TRIGGER tg_atualiza_estoque
    AFTER INSERT ON emprestimo
    FOR EACH ROW
    BEGIN
        UPDATE livro l
        SET quantidade_disponivel = quantidade_disponivel - 1
        WHERE id = l.id;
    END $$

DELIMITER ;

/* 4. Crie um TRIGGER 'tg_registrar_devolucao' que, 
sempre que o status de um empréstimo
for alterado para 'devolvido', preencha a coluna 
'data_devol' com a data atual (CURDATE())
e insira um registro na tabela log_operacoes.
*/

DELIMITER $$

    CREATE TRIGGER tg_registrar_devolucao
    BEFORE UPDATE ON emprestimo
    FOR EACH ROW 
    BEGIN
        IF NEW.status = 'devolvido' AND OLD.status <> 'devolvido' THEN
            SET NEW.data_devol = CURDATE();
            INSERT INTO log_operacoes (descricao, data_operacao)
            VALUES (
            CONCAT('Empréstimo ID ' , NEW.id , 'devolvido'),
            NOW()
            );
        END IF;
    END $$

DELIMITER ;