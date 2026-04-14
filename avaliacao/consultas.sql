/*
1) Crie uma consulta que liste o nome do filme e o somatório do valor dos ingressos vendidos, 
considerando apenas as vendas com pagamento parcelado. Agrupe os resultados por filme.
*/

SELECT 
    f.tituloPortugues AS Nome_do_Filme, 
    SUM(v.valorIngresso) AS Total_Vendas_Parceladas
FROM filme f
JOIN sessao s ON f.id = s.idFilme
JOIN venda v ON s.id = v.idSessao
JOIN tipoPagto tp ON v.idTipoPagto = tp.id
WHERE tp.nome = 'Parcelado'
GROUP BY f.id, f.tituloPortugues;

/* 
2) Modifique a consulta anterior para listar apenas os filmes 
com mais de 3 ingressos vendidos. Utilize a cláusula HAVING para realizar o filtro. 
*/ 

SELECT 
    f.tituloPortugues AS Nome_do_Filme, 
    SUM(v.valorIngresso) AS Total_Vendas_Parceladas,
    COUNT(v.id) AS Qtn_ingressos
FROM filme f
JOIN sessao s ON f.id = s.idFilme
JOIN venda v ON s.id = v.idSessao
JOIN tipoPagto tp ON v.idTipoPagto = tp.id
WHERE tp.nome = 'Parcelado'
GROUP BY f.id, f.tituloPortugues
HAVING COUNT(v.id) > 3;

/*
 3) Crie uma consulta para listar a quantidade de usuários 
 que efetuaram compras à vista. 
*/ 

SELECT 
    COUNT(DISTINCT v.idUsuario) AS Qtd_vendas_Vista
FROM venda v
JOIN tipoPagto tp ON v.idTipoPagto = tp.id
WHERE tp.nome = 'A Vista';

/*
 4) Modifique a consulta anterior para exibir o nome dos 
usuários e a quantidade total de compras à vista feitas por cada um. 
*/ 

SELECT 
    u.nome AS Nome_do_usuario,
    COUNT(v.id) AS Total_de_Compras_Vista
FROM usuario u
JOIN venda v ON u.id = v.idUsuario
JOIN tipoPagto tp ON v.idTipoPagto = tp.id
WHERE tp.nome = 'A Vista'
GROUP BY u.id, u.nome;
