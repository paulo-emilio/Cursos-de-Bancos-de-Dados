--DECLARANDO VARI�VEIS

DECLARE 
@MATRICULA VARCHAR(5),
@NOME VARCHAR(100),
@PERCENTUAL FLOAT,
@DATA DATE,
@FERIAS BIT,
@BAIRRO VARCHAR(50);

--DESFAIO: 
DECLARE 
@CLIENTE VARCHAR(10),
@IDADE INT,
@DATANASCIMENTO DATE,
@CUSTO FLOAT;


--ATRIBUIR VALORES �S VARI�VEIS

SET @MATRICULA = '00042';
SET @NOME = 'Sauron';
SET @PERCENTUAL = 0.1;
SET @DATA = '0002-03-12';
SET @FERIAS = 1;
SET @BAIRRO = 'Middle-earth';

--DESAFIO
SET @CLIENTE = 'Loki';
SET @IDADE = 10000000;
SET @DATANASCIMENTO = '2007-01-10';
SET @CUSTO = 6.66;


--VISUALIZANDO OS VALORES

PRINT @MATRICULA;
PRINT @NOME;
PRINT @PERCENTUAL;
PRINT @DATA;
PRINT @FERIAS;
PRINT @BAIRRO;


--USANDO VARI�VEIS

SELECT * FROM [TABELA DE VENDEDORES];

INSERT INTO [TABELA DE VENDEDORES]
VALUES (@MATRICULA, @NOME, @PERCENTUAL, @DATA, @FERIAS, @BAIRRO);

PRINT 'UM VENDEDOR INCLU�DO';