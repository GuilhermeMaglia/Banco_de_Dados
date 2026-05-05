-- Crie um TRIGGER chamado log_nova_inscricao que, 
-- após cada INSERT na tabela inscricao, insira um registro 
-- na tabela log_inscricao. O log deve conter o ID da 
-- nova inscrição (no campo id_inscricao_ref) e a 
-- ação "NOVA INSCRIÇÃO REALIZADA". 

DELIMITER $$

    CREATE TRIGGER log_nova_inscricao
    AFTER INSERT ON inscricao
    FOR EACH ROW
        INSERT INTO log_inscricao (id_inscricao_ref, acao_realizada, data_log)
        VALUES (NEW.id, 'Nova Inscrição Realizada', CURDATE());
    END$$

DELIMITER ;

-- Crie um TRIGGER chamado log_alteracao_status que seja 
-- acionado após cada UPDATE na coluna status da tabela inscricao. 
-- Este TRIGGER deve registrar a mudança na tabela log_inscricao. 
-- O registro de log deve conter: 
-- • O ID da inscrição afetada (no campo id_inscricao_ref). 
-- • A descrição da ação "STATUS ALTERADO PARA [NOVO STATUS]", 
-- onde [NOVO STATUS] é o valor da coluna status após a atualização. 

DELIMITER $$

    CREATE TRIGGER log_alteracao_status
    AFTER UPDATE ON inscricao
    FOR EACH ROW
    BEGIN
        IF OLD.status <> NEW.status THEN
            INSERT INTO log_inscricao (id_inscricao_ref, acao_realizada, data_log)
            VALUES (
                NEW.id,
                CONCAT('STATUS ALTERADO PARA',  NEW.status),
                NOW()
            );
        END IF;
    END $$

DELIMITER ;

--  Crie um TRIGGER chamado definir_status_padrao que seja acionado 
--  ANTES de cada INSERT na tabela inscricao. A função deste TRIGGER é 
--  garantir que, se a coluna status não for fornecida (ou for NULL) durante a inserção, 
--  ela seja automaticamente preenchida com o valor padrão 'pendente'. 

DELIMITER $$

    CREATE TRIGGER definir_status_padrao
    BEFORE INSERT ON inscricao
    FOR EACH ROW 
    BEGIN
        IF NEW.status IS NULL THEN 
            SET NEW.status = 'pendente';
        END IF;
    END$$

DELIMITER ;