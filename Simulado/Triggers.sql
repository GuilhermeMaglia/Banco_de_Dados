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