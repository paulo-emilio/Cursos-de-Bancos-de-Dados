/* Colunas:
CPF;
Nome Completo;
Endere�o Completo;
Data de Nascimento;
Idade;
Sexo;
Limite de Cr�dito;
Volume m�nimo de compra de produto;
Se j� realizou alguma compra na empresa */

CREATE TABLE [TABELA DE CLIENTES](

CPF CHAR (11),
NOME VARCHAR (150),
RUA VARCHAR (150),
COMPLEMENTO VARCHAR (150),
BAIRRO VARCHAR (150),
CIDADE VARCHAR (150),
ESTADO CHAR (2),
CEP CHAR (8),
[DATA DE NASCIMENTO] DATE,
IDADE SMALLINT,
SEXO CHAR (1),
[LIMITE DE CREDITO] MONEY,
[VOLUME  MINIMO] FLOAT,
[PRIMEIRA COMPRA] BIT
);

/* Colunas:
c�digo do produto,
nome do produto,
embalagem,
tamanho,
sabor
pre�o de lista */

CREATE TABLE [TABELA DE PRODUTOS](

[CODIGO DO PRODUTO] VARCHAR (20) NOT NULL PRIMARY KEY,
[NOME DO PRODUTO] VARCHAR (50),
EMBALAGEM VARCHAR (50),
TAMANHO VARCHAR (50),
SABOR VARCHAR (50),
[PRECO DE LISTA] SMALLMONEY
);

ALTER TABLE[TABELA DE CLIENTES]
ALTER COLUMN CPF CHAR (11) NOT NULL;

ALTER TABLE [TABELA DE CLIENTES]
ADD CONSTRAINT PK_TABELA_CLIENTE
PRIMARY KEY CLUSTERED (CPF);

/* DESAFIO:
O nome da tabela deve ser TABELA DE VENDEDORES.
Vendedor tem como chave o n�mero interno da matr�cula (Nome do campo MATRICULA) que deve ser um texto de 5 posi��es.
O nome do vendedor (Nome do campo NOME) deve ser um texto de 100 posi��es.
% de comiss�o. Este campo (Nome do campo PERCENTUAL COMISS�O) representa o percentual de comiss�o garantida pelo vendedor sobre cada venda. */

CREATE TABLE [TABELA DE VENDEDORES](
MATRICULA VARCHAR (5) NOT NULL PRIMARY KEY,
NOME VARCHAR (100) NOT NULL,
[PERCENTUAL COMISSAO] DECIMAL (5,2)
);