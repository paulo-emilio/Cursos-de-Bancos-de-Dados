--INNER JOIN
SELECT V.MATRICULA, V.NOME, COUNT(N.MATRICULA) AS CONTAGEM_NOTAS
FROM TABELA_DE_VENDEDORES V
INNER JOIN NOTAS_FISCAIS N
ON V.MATRICULA = N.MATRICULA
GROUP BY V.MATRICULA, V.NOME
ORDER BY CONTAGEM_NOTAS DESC;

--desafio pr�prio
SELECT P.NOME_DO_PRODUTO, COUNT(I.QUANTIDADE) AS CONTAGEM
FROM TABELA_DE_PRODUTOS P
INNER JOIN ITENS_NOTAS_FISCAIS I
ON I.CODIGO_DO_PRODUTO = P.CODIGO_DO_PRODUTO
GROUP BY P.NOME_DO_PRODUTO;

--DESAFIO: produtos que venderam mais que 394000, apare�a n�o somente o c�digo do produto, mas tamb�m o nome do produto.
SELECT I.CODIGO_DO_PRODUTO, P.NOME_DO_PRODUTO, SUM(I.QUANTIDADE) AS QUANTIDADE 
FROM TABELA_DE_PRODUTOS P
INNER JOIN ITENS_NOTAS_FISCAIS I
ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
GROUP BY I.CODIGO_DO_PRODUTO, P.NOME_DO_PRODUTO 
HAVING SUM(QUANTIDADE) > 394000 
ORDER BY SUM(QUANTIDADE) DESC;


--LEFT JOIN

SELECT DISTINCT TC.CPF AS CPF_DO_CADASTRO, TC.NOME AS NOME_DO_CLIENTE, NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC 
INNER JOIN NOTAS_FISCAIS NF 
ON TC.CPF = NF.CPF;

SELECT COUNT(*) FROM TABELA_DE_CLIENTES;

INSERT INTO TABELA_DE_CLIENTES 
(CPF, NOME, ENDERECO_1, ENDERECO_2,
BAIRRO, CIDADE, ESTADO, CEP, DATA_DE_NASCIMENTO, IDADE, GENERO,
LIMITE_DE_CREDITO, VOLUME_DE_COMPRA, PRIMEIRA_COMPRA)
VALUES ('23412632331', 'Juliana Silva', 'Rua Tramanda�', ' ', 'Bangu', 'Rio de
Janeiro', 'RJ', '23400000', '1989-02-04', 33, 'F', '180000', '24500', 0);

SELECT DISTINCT 
TC.CPF AS CPF_DO_CADASTRO, TC.NOME AS NOME_DO_CLIENTE, NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC 
LEFT JOIN NOTAS_FISCAIS NF 
ON TC.CPF = NF.CPF;

--WHERE ___ IS NULL
SELECT DISTINCT 
TC.CPF AS CPF_DO_CADASTRO,
TC.NOME AS NOME_DO_CLIENTE,
NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC 
LEFT JOIN NOTAS_FISCAIS NF ON TC.CPF = NF.CPF 
WHERE NF.CPF IS NULL


--RIGHT JOIN
SELECT DISTINCT 
TV.NOME AS NOME_DO_VENDEDOR, 
TV.BAIRRO AS BAIRRO_DO_VENDEDOR,
TC.BAIRRO AS BAIRRO_DO_CLIENTE, 
TC.NOME AS NOME_DO_CLIENTE 
FROM TABELA_DE_CLIENTES TC 
RIGHT JOIN TABELA_DE_VENDEDORES TV 
ON TC.BAIRRO = TV.BAIRRO;


--FULL JOIN

SELECT DISTINCT 
TV.NOME AS NOME_DO_VENDEDOR, 
TV.BAIRRO AS BAIRRO_DO_VENDEDOR,
TC.BAIRRO AS BAIRRO_DO_CLIENTE, 
TC.NOME AS NOME_DO_CLIENTE 
FROM TABELA_DE_CLIENTES TC 
RIGHT JOIN TABELA_DE_VENDEDORES TV 
ON TC.BAIRRO = TV.BAIRRO 
WHERE TC.NOME IS NULL;

SELECT DISTINCT 
TV.NOME AS NOME_DO_VENDEDOR, 
TV.BAIRRO AS BAIRRO_DO_VENDEDOR,
TC.BAIRRO AS BAIRRO_DO_CLIENTE, 
TC.NOME AS NOME_DO_CLIENTE 
FROM TABELA_DE_CLIENTES TC 
LEFT JOIN TABELA_DE_VENDEDORES TV 
ON TC.BAIRRO = TV.BAIRRO 
WHERE TV.NOME IS NULL;

--SUBSTITUINDO OS 2 ANTERIORES:
SELECT DISTINCT 
TV.NOME AS NOME_DO_VENDEDOR, 
TV.BAIRRO AS BAIRRO_DO_VENDEDOR,
TC.BAIRRO AS BAIRRO_DO_CLIENTE, 
TC.NOME AS NOME_DO_CLIENTE 
FROM TABELA_DE_CLIENTES TC 
FULL JOIN TABELA_DE_VENDEDORES TV 
ON TC.BAIRRO = TV.BAIRRO;


--UNION

SELECT DISTINCT BAIRRO FROM TABELA_DE_CLIENTES;
--12 BAIROS -> CLIENTES

SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;
--4 BAIROS -> VENDEDORES

SELECT DISTINCT BAIRRO FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

--UNION ALL

SELECT DISTINCT BAIRRO FROM TABELA_DE_CLIENTES
UNION ALL
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

--UNION COM OUTRA COLUNA DIFERENCIANDO AS ORIGENS: MESMA QUANTIDADE DO UNION ALL
SELECT DISTINCT BAIRRO, 'Cliente' AS ORIGEM FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO, 'Vendedor' FROM TABELA_DE_VENDEDORES;


--SUBQUERY

SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;
SELECT * FROM TABELA_DE_CLIENTES
WHERE BAIRRO IN 
('Copacabana', 'Jardins', 'Santo Amaro', 'Tijuca'); 

--usando subquery
SELECT * FROM TABELA_DE_CLIENTES
WHERE BAIRRO IN 
(SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES); 


--DESAFIO:
SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO, SUM(INF.QUANTIDADE) AS QUANTIDADE 
FROM ITENS_NOTAS_FISCAIS  INF
INNER JOIN TABELA_DE_PRODUTOS TP 
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO 
HAVING SUM(INF.QUANTIDADE) > 394000 
ORDER BY SUM(INF.QUANTIDADE) DESC;
--Ela nos d� os produtos cuja soma das vendas s�o maiores que 394000.
--Levando isso em considera��o, liste os sabores destes produtos que s�o selecionados nesta consulta.

SELECT DISTINCT SABOR 
FROM TABELA_DE_PRODUTOS
WHERE CODIGO_DO_PRODUTO IN 
   (SELECT INF.CODIGO_DO_PRODUTO
	FROM ITENS_NOTAS_FISCAIS  INF
	INNER JOIN TABELA_DE_PRODUTOS TP 
	ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
	GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO 
	HAVING SUM(INF.QUANTIDADE) > 394000);


--MAIS SUBQUERY

--HAVING:
SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO 
FROM TABELA_DE_PRODUTOS 
GROUP BY EMBALAGEM 
HAVING AVG(PRECO_DE_LISTA) <= 10;
--IGUAL A ESSA SUBQUERY:
SELECT MEDIA_EMBALAGENS.EMBALAGEM, MEDIA_EMBALAGENS.PRECO_MEDIO 
FROM (
    SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO 
    FROM TABELA_DE_PRODUTOS 
    GROUP BY EMBALAGEM
) MEDIA_EMBALAGENS 
WHERE MEDIA_EMBALAGENS.PRECO_MEDIO <= 10;

--DESAFIO: Uma vez que essa consulta foi realizada nestes moldes, refa�a esta consulta usando Subconsultas.
SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO, SUM(INF.QUANTIDADE) AS QUANTIDADE 
FROM ITENS_NOTAS_FISCAIS  INF
INNER JOIN TABELA_DE_PRODUTOS TP 
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO HAVING SUM(INF.QUANTIDADE) > 394000 
ORDER BY SUM(INF.QUANTIDADE) DESC;

--SUBQUERY 
SELECT QTD_PRODUTOS_MAIS_VENDIDOS.COD_PRODUTO,
       QTD_PRODUTOS_MAIS_VENDIDOS.NOME_PRODUTO,
       QTD_PRODUTOS_MAIS_VENDIDOS.QUANTIDADE
FROM (  SELECT INF.CODIGO_DO_PRODUTO AS COD_PRODUTO, TP.NOME_DO_PRODUTO AS NOME_PRODUTO, SUM(INF.QUANTIDADE) AS QUANTIDADE
        FROM ITENS_NOTAS_FISCAIS  INF
        INNER JOIN TABELA_DE_PRODUTOS TP 
        ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
        GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO  
        ) QTD_PRODUTOS_MAIS_VENDIDOS
WHERE QTD_PRODUTOS_MAIS_VENDIDOS.QUANTIDADE > 394000
ORDER BY QTD_PRODUTOS_MAIS_VENDIDOS.QUANTIDADE DESC


--VIEW

--SERA MELHORADO COM A VIEW:
SELECT MEDIA_EMBALAGENS.EMBALAGEM, MEDIA_EMBALAGENS.PRECO_MEDIO 
FROM (SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO 
		FROM TABELA_DE_PRODUTOS 
		GROUP BY EMBALAGEM) MEDIA_EMBALAGENS 
WHERE MEDIA_EMBALAGENS.PRECO_MEDIO <= 10;

--CRIANDO UMA VIEW (tabela l�gica criada a partir de uma query (n�o � uma tabela real)):
CREATE VIEW MEDIA_EMBALAGENS AS
SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO 
FROM TABELA_DE_PRODUTOS 
GROUP BY EMBALAGEM; 

SELECT * FROM MEDIA_EMBALAGENS;

--MELHORANDO A CONSULTA:
SELECT MEDIA_EMBALAGENS.EMBALAGEM, MEDIA_EMBALAGENS.PRECO_MEDIO 
FROM MEDIA_EMBALAGENS
WHERE MEDIA_EMBALAGENS.PRECO_MEDIO <= 10;