-- Inserindo pedidos 
INSERT INTO pedidos (cliente_id, valor, data_pedido) VALUES
()



CREATE OR REPLACE FUNCTION log_pedido_insert() 
RETURNS TRIGGER AS $$ 
BEGIN 
 INSERT INTO log_pedidos (mensagem) VALUES 
 ('Novo pedido inserido para o cliente ID ' || NEW.cliente_id); 
 RETURN NEW; END; 
 $$ LANGUAGE plpgsql; 
 CREATE TRIGGER trg_pedidos_AI 
 AFTER INSERT ON pedidos 
 FOR EACH ROW EXECUTE 
 FUNCTION log_pedido_insert();




 CREATE OR REPLACE FUNCTION log_delete_cliente() 
 RETURNS TRIGGER AS $$ 
 BEGIN INSERT INTO log_pedidos (mensagem) VALUES 
 ('Cliente ID ' || OLD.id || ' será removido: ' || OLD.nome); 
 RETURN OLD; END; $$ LANGUAGE plpgsql; CREATE TRIGGER trg_clientes_BD BEFORE DELETE ON clientes 
 FOR EACH ROW EXECUTE 
 FUNCTION log_delete_cliente();




 -- PROCEDURE para inserir novo cliente (PostgreSQL) 
 CREATE OR REPLACE PROCEDURE 
 inserir_cliente( IN nome_cli TEXT, IN email_cli TEXT ) 
 LANGUAGE plpgsql 
 AS $$ 
 BEGIN 
 INSERT INTO clientes (nome, email) VALUES 
 (nome_cli, email_cli); 
 END; 
 $$;




 -- FUNÇÃO para verificar total de pedidos por cliente (PostgreSQL)] 
 CREATE OR REPLACE FUNCTION total_pedidos(id_cliente INT) 
 RETURNS INT AS $$ 
 DECLARE total INT; 
 BEGIN SELECT COUNT(*) 
 INTO total FROM 
 pedidos WHERE cliente_id = id_cliente; 
 RETURN total; 
 END; $$ 
 LANGUAGE plpgsql;




 -- FUNÇÃO com retorno de múltiplas colunas-- Retorna nome, email e total de pedidos de um cliente-- PostgreSQL 
 CREATE OR REPLACE FUNCTION dados_cliente(id_cliente INT) 
 RETURNS TABLE(nome TEXT, email TEXT, total_pedidos INT) AS $$ 
 BEGIN 
 RETURN QUERY 
 SELECT c.nome, c.email, COUNT(p.id) 
 FROM clientes c LEFT JOIN pedidos p ON c.id = p.cliente_id 
 WHERE c.id = id_cliente 
 GROUP BY c.nome, c.email; 
 END; 
 $$ LANGUAGE plpgsql;




 -- VIEW que retorna nome, email e total de pedidos por cliente-- PostgreSQL e MySQL 
 CREATE VIEW dados_cliente_view AS 
 SELECT 
    c.id, 
    c.nome, 
    c.email, 
    COUNT(p.id) AS total_pedidos 
 FROM 
 clientes c 
 LEFT JOIN 
    pedidos p ON c.id = p.cliente_id 
 GROUP BY 
    c.id, c.nome, c.email;




-- Visão (VIEW) simples com JOIN
CREATE VIEW resumo_pedidos 
AS SELECT c.nome, COUNT(p.id) AS total_pedidos, SUM(p.valor) AS 
valor_total FROM clientes c 
LEFT JOIN pedidos p ON c.id = p.cliente_id 
GROUP BY c.nome;




-- View com filtro 
CREATE VIEW clientes_com_pedidos AS 
SELECT c.* FROM clientes c 
WHERE EXISTS 
( SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id );




 --Uma função que retorne nome, total de pedidos e valor total por cliente
CREATE OR REPLACE FUNCTION total(id_cliente INT) 
 RETURNS INT AS $$ 
 DECLARE total INT; 
 BEGIN SELECT COUNT(*) 
 INTO total FROM 
 pedidos WHERE cliente_id = id_cliente; 
 RETURN total; 
 END; $$ 
 LANGUAGE plpgsql;