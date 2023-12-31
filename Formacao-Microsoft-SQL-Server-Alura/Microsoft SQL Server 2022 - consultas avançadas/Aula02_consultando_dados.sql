-- SELECT

SELECT CPF AS IDENTIFICADOR, NOME AS [NOME DE CLIENTE], BAIRRO, CIDADE FROM TABELA_DE_CLIENTES;

SELECT TDC.CPF, TDC.NOME, TDC. BAIRRO FROM TABELA_DE_CLIENTES TDC;

SELECT TDC.* FROM TABELA_DE_CLIENTES TDC;


-- WHERE

SELECT * FROM TABELA_DE_PRODUTOS;

SELECT * FROM TABELA_DE_PRODUTOS
WHERE CODIGO_DO_PRODUTO = '290478';

SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'LARANJA'
AND EMBALAGEM = 'PET';

SELECT * FROM TABELA_DE_CLIENTES WHERE IDADE <= 18;

SELECT * FROM TABELA_DE_CLIENTES WHERE IDADE <> 18;

SELECT * FROM TABELA_DE_PRODUTOS WHERE 
SABOR = 'Manga' OR SABOR = 'Laranja' OR SABOR = 'Melancia';

-- IN
SELECT * FROM TABELA_DE_PRODUTOS WHERE 
SABOR in ('Manga', 'Laranja', 'Melancia');

SELECT * FROM TABELA_DE_PRODUTOS WHERE 
SABOR in ('Manga', 'Laranja', 'Melancia') AND TAMANHO = '1 Litro';

--BETWEEN
SELECT * FROM TABELA_DE_CLIENTES WHERE 
CIDADE in ('Rio de Janeiro', 'Sao Paulo') AND (IDADE BETWEEN 18 AND 25);

--LIKE
SELECT  * FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE '%Limao';

SELECT * FROM TABELA_DE_PRODUTOS 
WHERE SABOR LIKE 'Morango%' AND EMBALAGEM = 'PET';

-- SOBRENOME SILVA
SELECT * FROM TABELA_DE_CLIENTES
WHERE NOME LIKE '%SILVA%';