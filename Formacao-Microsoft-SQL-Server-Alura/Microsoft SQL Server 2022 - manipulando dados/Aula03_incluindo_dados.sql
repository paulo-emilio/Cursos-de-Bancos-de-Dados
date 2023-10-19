INSERT INTO PRODUTOS (
    CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA
) VALUES (
    '1040107', 'Light - 350 ml - Melancia', 'Melancia', '350 ml', 'Lata', 4.56
);

INSERT INTO PRODUTOS (
    CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA
) VALUES (
    '1040108', 'Light - 350 ml - Graviola' , 'Graviola', '350 ml', 'Lata', 4.00
);

INSERT INTO PRODUTOS (
    CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA
) VALUES (
    '1040109', 'Light - 350 ml - A�ai' , 'A�ai', '350 ml', 'Lata', 5.60
);

INSERT INTO PRODUTOS (
    CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA
) VALUES (
    '1040110', 'Light - 350 ml - Jaca' , 'Jaca', '350 ml', 'Lata', 3.50
);

INSERT INTO PRODUTOS (
    CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA
) VALUES 
    ('1040111', 'Light - 350 ml - Manga' , 'Manga', '350 ml', 'Lata', 3.20), 
    ('1040112', 'Light - 350 ml - Ma�a' , 'Ma�a', '350 ml', 'Lata', 4.20);



--DESAFIO

INSERT INTO [dbo].[CLIENTES] ([CPF], [NOME], [ENDERECO], 
    [BAIRRO], [CIDADE], [ESTADO], [CEP], [DATA_NASCIMENTO], 
    [IDADE], [GENERO], [LIMITE_CREDITO], [VOLUME_COMPRA], 
    [PRIMEIRA_COMPRA])
VALUES ('1471156710', '�rica Carvalho', 'R. Iriquitia', 'Jardins', 'S�o Paulo', 
        'SP', '80012212', '19900901', 27, 'F', 170000, 24500,0), 
    ('19290992743', 'Fernando Cavalcante', 'R. Dois de Fevereiro', '�gua Santa', 
        'Rio de Janeiro', 'RJ', '22000000', '20000212', 18, 'M', 100000, 20000, 1), 
    ('2600586709', 'C�sar Teixeira', 'Rua Conde de Bonfim', 'Tijuca', 
        'Rio de Janeiro', 'RJ', '22020001', '20000312', 18, 'M', 120000, 22000, 0);


--COPIANDO DADOS DE UM BANCO PARA OUTRO

--selecionando de outro database
SELECT CODIGO_DO_PRODUTO, NOME_DO_PRODUTO, SABOR, TAMANHO, EMBALAGEM, PRECO_DE_LISTA FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS;

--NOMES DAS COLUNAS IGUAIS:
SELECT CODIGO_DO_PRODUTO AS CODIGO, 
NOME_DO_PRODUTO AS DESCRITOR, 
SABOR, TAMANHO, EMBALAGEM, 
PRECO_DE_LISTA AS PRECO_LISTA 
FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS;

--INSERINDO DADOS:
INSERT INTO PRODUTOS
SELECT CODIGO_DO_PRODUTO AS CODIGO, 
NOME_DO_PRODUTO AS DESCRITOR, 
SABOR, TAMANHO, EMBALAGEM, 
PRECO_DE_LISTA AS PRECO_LISTA 
FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS;
-- EXISTEM CHAVES PRIM�RIAS IGUAIS �S JA EXISTENTES

--SEM O CODIGO QUE JA EXISTE:
INSERT INTO PRODUTOS
SELECT CODIGO_DO_PRODUTO AS CODIGO, 
NOME_DO_PRODUTO AS DESCRITOR, 
SABOR, TAMANHO, EMBALAGEM, 
PRECO_DE_LISTA AS PRECO_LISTA 
FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS
WHERE CODIGO_DO_PRODUTO <> '1040107';
--OK

--DESAFIO
INSERT INTO CLIENTES
SELECT CPF, NOME, ENDERECO_1 AS ENDERECO, BAIRRO, CIDADE, ESTADO, CEP, 
DATA_DE_NASCIMENTO AS DATA_NASCIMENTO, IDADE, 
GENERO, LIMITE_DE_CREDITO AS LIMITE_CREDITO, VOLUME_DE_COMPRA AS VOLUME_COMPRA, PRIMEIRA_COMPRA
FROM SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES
WHERE CPF NOT IN (SELECT CPF FROM CLIENTES)

INSERT INTO VENDEDORES(
MATRICULA,NOME,COMISSAO,DATA_ADMISSAO,FERIAS,BAIRRO)
VALUES
('235','M�rcio Almeida Silva',0.08,'2014-08-15',0,'Tijuca'),
('236','Cl�udia Morais',0.08,'2013-09-17',1,'Jardins'),
('237','Roberta Martins',0.11,'2017-03-18',1,'Copacabana'),
('238','P�ricles Alves',0.11,'2016-08-21',0,'Santo Amaro');

SELECT * FROM TABELA_DE_VENDAS