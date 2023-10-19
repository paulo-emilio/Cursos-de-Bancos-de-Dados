SELECT NF.CPF, 
CONVERT(VARCHAR(7), NF.DATA_VENDA) AS ANO_MES, 
SUM(INF.QUANTIDADE) AS QTD_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON INF.NUMERO = NF.NUMERO
GROUP BY NF.CPF, CONVERT(VARCHAR(7), NF.DATA_VENDA)
ORDER BY NF.CPF;


-- volume de compras permitido ultrapassado:
SELECT 
C.CPF, C.NOME, T.ANO_MES, C.VOLUME_DE_COMPRA, T.QTD_TOTAL,

CASE
	WHEN T.QTD_TOTAL >= C.VOLUME_DE_COMPRA
		THEN 'INVALIDA'
	WHEN T.QTD_TOTAL < C.VOLUME_DE_COMPRA
		THEN 'VALIDA'
END AS VENDA

FROM
(SELECT CPF, NOME, VOLUME_DE_COMPRA FROM TABELA_DE_CLIENTES) C

INNER JOIN
(SELECT NF.CPF, 
CONVERT(VARCHAR(7), NF.DATA_VENDA) AS ANO_MES, 
SUM(INF.QUANTIDADE) AS QTD_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON INF.NUMERO = NF.NUMERO
GROUP BY NF.CPF, CONVERT(VARCHAR(7), NF.DATA_VENDA)) T
ON C.CPF = T.CPF

WHERE T.ANO_MES = '2015-01';


--DESAFIO: listando somente os que tiveram vendas inv�lidas e calculando a diferen�a entre o limite de venda m�ximo e o realizado, em percentuais.

--Minha solu��o
SELECT 
    C.CPF, 
    C.NOME, 
    T.ANO_MES, 
    C.VOLUME_DE_COMPRA, 
    T.QTD_TOTAL,
    'INVALIDA' AS VENDA,
    ROUND(((T.QTD_TOTAL - C.VOLUME_DE_COMPRA) / C.VOLUME_DE_COMPRA) * 100, 2) AS DIFERENCA_PERCENTUAL

FROM
    (SELECT CPF, NOME, VOLUME_DE_COMPRA FROM TABELA_DE_CLIENTES) C

INNER JOIN
    (SELECT NF.CPF, 
            CONVERT(VARCHAR(7), NF.DATA_VENDA) AS ANO_MES, 
            SUM(INF.QUANTIDADE) AS QTD_TOTAL
    FROM NOTAS_FISCAIS NF
    INNER JOIN ITENS_NOTAS_FISCAIS INF
    ON INF.NUMERO = NF.NUMERO
    GROUP BY NF.CPF, CONVERT(VARCHAR(7), NF.DATA_VENDA)) T
ON C.CPF = T.CPF

WHERE 
    T.ANO_MES = '2015-01'
    AND T.QTD_TOTAL >= C.VOLUME_DE_COMPRA;

--ALURA:
SELECT 
C.CPF, C.NOME, T.ANO_MES, C.VOLUME_DE_COMPRA, T.QTD_TOTAL,

CASE
	WHEN T.QTD_TOTAL >= C.VOLUME_DE_COMPRA
		THEN 'INVALIDA'
	WHEN T.QTD_TOTAL < C.VOLUME_DE_COMPRA
		THEN 'VALIDA'
END AS VENDA,

ROUND((1-(C.VOLUME_DE_COMPRA/T.QTD_TOTAL))*100, 2) AS 'DIFERENCA (%)'

FROM
(SELECT CPF, NOME, VOLUME_DE_COMPRA FROM TABELA_DE_CLIENTES) C
INNER JOIN
(SELECT NF.CPF, 
CONVERT(VARCHAR(7), NF.DATA_VENDA) AS ANO_MES, 
SUM(INF.QUANTIDADE) AS QTD_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON INF.NUMERO = NF.NUMERO
GROUP BY NF.CPF, CONVERT(VARCHAR(7), NF.DATA_VENDA)) T
ON C.CPF = T.CPF

WHERE T.QTD_TOTAL >= C.VOLUME_DE_COMPRA
AND T.ANO_MES = '2015-01';

