USE [dbVendas]
GO
/****** Object:  UserDefinedFunction [dbo].[BuscarClienteAleatorio]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[BuscarClienteAleatorio]()
RETURNS VARCHAR(11)
AS
BEGIN
    DECLARE @TotalClientes INT
    DECLARE @NumeroAleatorio INT
    
    SELECT @TotalClientes = 1000
    
    SELECT @NumeroAleatorio = [dbo].[NumeroAleatorio] (1,@TotalClientes)
    
    RETURN (
        SELECT TOP 1 CPF 
        FROM (
            SELECT CPF 
            FROM tb_cliente 
            ORDER BY CPF OFFSET @NumeroAleatorio ROWS FETCH NEXT 1 ROWS ONLY
        ) AS Subconsulta
    )
END
GO
/****** Object:  UserDefinedFunction [dbo].[BuscarLojaAleatorio]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[BuscarLojaAleatorio](@CPF as VARCHAR(15))
RETURNS VARCHAR(11)
AS
BEGIN
    DECLARE @TotalClientes INT
    DECLARE @NumeroAleatorio INT
    
    SELECT @TotalClientes = 51
    
    SELECT @NumeroAleatorio = [dbo].[NumeroAleatorio] (1,@TotalClientes)
    
    RETURN (
        SELECT TOP 1 codigo_loja
        FROM (
            SELECT codigo_loja 
            FROM tb_loja
            ORDER BY codigo_loja OFFSET @NumeroAleatorio ROWS FETCH NEXT 1 ROWS ONLY
        ) AS Subconsulta
    )
END
GO
/****** Object:  UserDefinedFunction [dbo].[BuscarProdutoAleatorio]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[BuscarProdutoAleatorio]()
RETURNS VARCHAR(11)
AS
BEGIN
    DECLARE @TotalProduto INT
    DECLARE @NumeroAleatorio INT
    
    SELECT @TotalProduto = COUNT(*) FROM tb_produto
    
    SELECT @NumeroAleatorio = [dbo].[NumeroAleatorio] (1,@TotalProduto)
    
    RETURN (
        SELECT TOP 1 codigo_produto 
        FROM (
            SELECT codigo_produto  
            FROM tb_produto 
            ORDER BY codigo_produto  OFFSET @NumeroAleatorio ROWS FETCH NEXT 1 ROWS ONLY
        ) AS Subconsulta
    )
END
GO
/****** Object:  UserDefinedFunction [dbo].[NumeroAleatorio]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[NumeroAleatorio](@VAL_MIN INT, @VAL_MAX INT)
RETURNS INT
AS
BEGIN
   DECLARE @ALEATORIO INT
   DECLARE @VALOR_ALEATORIO FLOAT
   SELECT @VALOR_ALEATORIO = VALOR_ALEATORIO FROM VW_ALEATORIO
   SET @ALEATORIO = ROUND(((@VAL_MAX - @VAL_MIN - 1) * @VALOR_ALEATORIO + @VAL_MIN), 0)
   RETURN @ALEATORIO
END
GO
/****** Object:  View [dbo].[VW_ALEATORIO]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ALEATORIO]
AS
SELECT        RAND() AS VALOR_ALEATORIO
GO
/****** Object:  Table [dbo].[tb_cidade]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_cidade](
	[cidade] [varchar](50) NOT NULL,
	[sigla_estado] [varchar](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_classificacao]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_classificacao](
	[codigo_classificacao] [varchar](3) NOT NULL,
	[classificacao] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_cliente]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_cliente](
	[cpf] [varchar](12) NOT NULL,
	[nome] [varchar](100) NULL,
	[sobrenome] [varchar](100) NULL,
	[email] [varchar](100) NULL,
	[telefone] [varchar](100) NULL,
	[cidade] [varchar](50) NOT NULL,
	[numero] [varchar](10) NULL,
	[rua] [varchar](100) NULL,
	[complemento] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_estado]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_estado](
	[sigla_estado] [varchar](2) NOT NULL,
	[nome_estado] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_item]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_item](
	[numero] [varchar](12) NOT NULL,
	[codigo_produto] [varchar](12) NOT NULL,
	[quantidade] [int] NULL,
	[preco] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_loja]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_loja](
	[codigo_loja] [varchar](10) NOT NULL,
	[nome_loja] [varchar](100) NULL,
	[cidade] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_nota]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_nota](
	[cpf] [varchar](12) NOT NULL,
	[codigo_loja] [varchar](10) NOT NULL,
	[data] [date] NULL,
	[numero] [varchar](12) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_produto]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_produto](
	[codigo_produto] [varchar](12) NOT NULL,
	[produto] [varchar](100) NULL,
	[codigo_classificacao] [varchar](3) NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Andradina', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Aparecida de Goiânia', N'GO')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Aracaju', N'SE')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Araguaína', N'TO')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Arapiraca', N'AL')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Arapongas', N'PR')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Araranguá', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Assis', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Bacabal', N'MA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Barbacena', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Barra Bonita', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Barra Mansa', N'RJ')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Barretos', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Bauru', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Belém', N'PA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Belo Horizonte', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Blumenau', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Boa Vista', N'RR')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Botucatu', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Bragança Paulista', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Brasília', N'DF')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Cachoeira do Sul', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Camaquã', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Campo Grande', N'MS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Campo Maior', N'PI')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Caraguatatuba', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Caratinga', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Caruaru', N'PE')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Cascavel', N'PR')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Chapecó', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Codó', N'MA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Cotia', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Crateús', N'CE')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Criciúma', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Cubatão', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Cuiabá', N'MT')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Curitiba', N'PR')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Divinópolis', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Eunápolis', N'BA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Feira de Santana', N'BA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Florianópolis', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Formiga', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Fortaleza', N'CE')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Franca', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Frederico Westphalen', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Gaspar', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Goiânia', N'GO')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Guanambi', N'BA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Guarapari', N'ES')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Guaratinguetá', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Ijuí', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Imperatriz', N'MA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Ipatinga', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Irecê', N'BA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Itajubá', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Itanhaém', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Itapecerica da Serra', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Itapetininga', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Itatiba', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Jacareí', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'João Pessoa', N'PB')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Juazeiro do Norte', N'CE')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Lages', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Lavras', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Leme', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Lençóis Paulista', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Lorena', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Macapá', N'AP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Maceió', N'AL')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Manaus', N'AM')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Marília', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Maringá', N'PR')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Muriaé', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Natal', N'RN')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Nilópolis', N'RJ')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Ourinhos', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Palmas', N'TO')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Palmeira das Missões', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Parnaíba', N'PI')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Passo Fundo', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Passos', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Penápolis', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Picos', N'PI')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Pindamonhangaba', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Porto Alegre', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Porto Velho', N'AC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Pouso Alegre', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Recife', N'PE')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Registro', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Ribeirão Pires', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Rio Branco', N'AC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Rio de Janeiro', N'RJ')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Rio Largo', N'AL')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Salto', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Salvador', N'BA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Santa Cruz do Sul', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Santa Luzia', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Santa Maria', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Santarém', N'PA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São Carlos', N'SP')
GO
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São João da Boa Vista', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São José dos Campos', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São Lourenço', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São Luís', N'MA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São Mateus', N'ES')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São Paulo', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'São Roque', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Sete Lagoas', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Sobral', N'CE')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Tatuí', N'SP')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Teixeira de Freitas', N'BA')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Teófilo Otoni', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Teresina', N'PI')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Teresópolis', N'RJ')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Tijucas', N'SC')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Três Corações', N'MG')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Três Rios', N'RJ')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Valença', N'RJ')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Viamão', N'RS')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Vitória', N'ES')
INSERT [dbo].[tb_cidade] ([cidade], [sigla_estado]) VALUES (N'Vitória da Conquista', N'BA')
GO
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'1', N'Açúcares')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'10', N'Biscoitos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'11', N'Bolacha')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'12', N'Bolos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'13', N'Bulbo')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'14', N'Cacau')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'15', N'Cafés')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'16', N'Carnes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'17', N'Carnes e Embutidos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'18', N'Castanha')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'19', N'Castanhas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'2', N'Adoçantes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'20', N'Castanhas e Nozes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'21', N'Cereais')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'22', N'Cereais e Grãos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'23', N'Cereal')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'24', N'Chás')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'25', N'Chocolate')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'26', N'Cogumelo')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'27', N'Condimentos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'28', N'Conservas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'29', N'Cremes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'3', N'Água')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'30', N'Doces')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'31', N'Doces e Sobremesas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'32', N'Embutidos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'33', N'Farinhas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'34', N'Fermentos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'35', N'Folha')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'36', N'Frios')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'37', N'Frutas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'38', N'Frutas Secas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'39', N'Frutos do mar')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'4', N'Águas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'40', N'Grão')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'41', N'Grãos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'42', N'Higiene')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'43', N'Higiene pessoal')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'44', N'Hortaliças')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'45', N'Iogurtes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'46', N'Laticínios')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'47', N'Legume')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'48', N'Legumes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'49', N'Leguminosa')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'5', N'Alimentos e Bebidas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'50', N'Leguminosas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'51', N'Leites')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'52', N'Leites vegetais')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'53', N'Limpeza')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'54', N'Margarina')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'55', N'Margarinas e manteigas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'56', N'Massas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'57', N'Molho')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'58', N'Molhos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'59', N'Molhos e Condimentos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'6', N'Bebidas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'60', N'Óleo')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'61', N'Óleos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'62', N'Ovos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'63', N'Pães')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'64', N'Pães e Bolos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'65', N'Palmito')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'66', N'Pão')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'67', N'Papéis')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'68', N'Peixe')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'69', N'Peixes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'7', N'Bebidas alcoólicas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'70', N'Queijo')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'71', N'Queijos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'72', N'Raiz')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'73', N'Salgadinhos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'74', N'Sementes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'75', N'Sobremesas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'76', N'Sopas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'77', N'Sucos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'78', N'Temperos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'79', N'Temperos e Condimentos')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'8', N'Bebidas não alcoólicas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'80', N'Tortas')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'81', N'Tubérculo')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'82', N'Verduras')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'83', N'Verduras e Legumes')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'84', N'Vinagres')
INSERT [dbo].[tb_classificacao] ([codigo_classificacao], [classificacao]) VALUES (N'9', N'Bebidas quentes')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100060512', N'Fabiana', N'Lima', N'hotmail.com', N'34685526', N'Franca', N'8687', N'Rua 172', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10010217829', N'Óscar', N'Santos', N'outlook.com', N'38256642', N'Palmeira das Missões', N'8148', N'Rua 874', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100104654', N'Zélia', N'Souza', N'uol.com.br', N'59488583', N'Lages', N'5638', N'Rua 896', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10010483165', N'Ismaelita', N'Castro', N'uol.com.br', N'42469199', N'Três Rios', N'4277', N'Rua 90', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10010490839', N'Geovana', N'Oliveira', N'gmail.com', N'44760699', N'Belo Horizonte', N'3484', N'Rua 769', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10010492682', N'Thiago', N'Almeida', N'uol.com.br', N'73337404', N'Blumenau', N'313', N'Rua 301', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10010692977', N'Wilson', N'Souza', N'gmail.com', N'88557200', N'Caraguatatuba', N'804', N'Rua 278', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10010767872', N'Lays', N'Almeida', N'gmail.com', N'62178271', N'Penápolis', N'8158', N'Rua 84', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10010849831', N'Raimunda', N'Gomes', N'outlook.com', N'75872634', N'Feira de Santana', N'4781', N'Rua 466', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001094284', N'Anderson', N'Santos', N'gmail.com', N'27764630', N'Três Corações', N'5411', N'Rua 125', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011018015', N'Luiza', N'Carvalho', N'uol.com.br', N'11126018', N'Bauru', N'7671', N'Rua 120', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011135513', N'Luan', N'Ribeiro', N'outlook.com', N'69812450', N'Arapiraca', N'5563', N'Rua 179', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001117386', N'Vanessa', N'Rodrigues', N'yahoo.com', N'57272709', N'Eunápolis', N'9042', N'Rua 147', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011212184', N'Pamela', N'Gomes', N'hotmail.com', N'13654645', N'Sobral', N'5720', N'Rua 299', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011327261', N'Lilian', N'Rodrigues', N'gmail.com', N'92054642', N'Palmas', N'5468', N'Rua 936', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001133220', N'Rafael', N'Nascimento', N'hotmail.com', N'32900922', N'Barra Bonita', N'7771', N'Rua 57', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011420490', N'Júlia', N'Almeida', N'hotmail.com', N'16455391', N'Formiga', N'2625', N'Rua 405', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001148489', N'Fabiana', N'Castro', N'hotmail.com', N'10873271', N'Bauru', N'6328', N'Rua 358', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011538458', N'Thiago', N'Oliveira', N'yahoo.com', N'99302802', N'Lages', N'8258', N'Rua 765', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011589946', N'Sílvia', N'Almeida', N'hotmail.com', N'926407', N'Formiga', N'4946', N'Rua 563', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011611151', N'Isabela', N'Oliveira', N'outlook.com', N'37833097', N'Brasília', N'3376', N'Rua 277', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011781972', N'Karina', N'Fernandes', N'uol.com.br', N'24719078', N'Juazeiro do Norte', N'8939', N'Rua 186', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001179646', N'Karina', N'Oliveira', N'uol.com.br', N'38520829', N'Três Corações', N'5268', N'Rua 189', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011841462', N'Natália', N'Silva', N'gmail.com', N'7622012', N'Cuiabá', N'6740', N'Rua 89', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011882790', N'Célia', N'Almeida', N'yahoo.com', N'30569835', N'Codó', N'160', N'Rua 927', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10011938973', N'Giovana', N'Rodrigues', N'yahoo.com', N'25467185', N'Ribeirão Pires', N'2416', N'Rua 521', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001207114', N'William', N'Pereira', N'hotmail.com', N'44189996', N'Lavras', N'9872', N'Rua 646', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001228748', N'Luma', N'Nascimento', N'outlook.com', N'79573402', N'Teresópolis', N'3036', N'Rua 637', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10012324474', N'Isadora', N'Silva', N'uol.com.br', N'5465471', N'Boa Vista', N'7559', N'Rua 198', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001232586', N'David', N'Almeida', N'gmail.com', N'50873821', N'Caraguatatuba', N'4533', N'Rua 308', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001237186', N'Lídia', N'Almeida', N'gmail.com', N'50149319', N'Leme', N'5509', N'Rua 772', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100124868', N'Eliane', N'Rodrigues', N'hotmail.com', N'39596309', N'Cubatão', N'8692', N'Rua 305', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001255378', N'Bruno', N'Silva', N'uol.com.br', N'74913620', N'Gaspar', N'7385', N'Rua 334', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10012553857', N'Raquel', N'Pereira', N'yahoo.com', N'28000155', N'Tatuí', N'7844', N'Rua 903', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10012575237', N'Gabriel', N'Ribeiro', N'yahoo.com', N'19834618', N'Goiânia', N'4264', N'Rua 814', N'Apto. 76')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10012576131', N'Thaís', N'Almeida', N'hotmail.com', N'65975472', N'Penápolis', N'2277', N'Rua 476', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001266017', N'Miriam', N'Nascimento', N'uol.com.br', N'61592919', N'São Roque', N'5931', N'Rua 492', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001273035', N'Pietra', N'Carvalho', N'gmail.com', N'74940910', N'Ipatinga', N'6581', N'Rua 874', N'Apto. 32')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10012848033', N'Gabriela', N'Fernandes', N'gmail.com', N'59244920', N'Sete Lagoas', N'648', N'Rua 974', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10012930323', N'Priscila', N'Oliveira', N'yahoo.com', N'84035398', N'Lavras', N'7266', N'Rua 756', N'Apto. 71')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10013429976', N'Gustavo', N'Nascimento', N'gmail.com', N'91226631', N'Boa Vista', N'2268', N'Rua 121', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10013517060', N'Vanessa', N'Santos', N'outlook.com', N'10994714', N'São Carlos', N'2272', N'Rua 613', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10013769493', N'Tainá', N'Carvalho', N'yahoo.com', N'61629737', N'Boa Vista', N'3253', N'Rua 590', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001382299', N'Eliseu', N'Ribeiro', N'yahoo.com', N'73728560', N'Maringá', N'5486', N'Rua 125', N'Apto. 25')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10013977258', N'Daniel', N'Carvalho', N'yahoo.com', N'58045458', N'Macapá', N'1118', N'Rua 193', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001401430', N'Leticia', N'Pereira', N'yahoo.com', N'29275560', N'Barra Bonita', N'1248', N'Rua 934', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001415644', N'Zara', N'Silva', N'uol.com.br', N'77810754', N'Vitória', N'9976', N'Rua 106', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014254063', N'Heloísa', N'Castro', N'outlook.com', N'29551027', N'Muriaé', N'3503', N'Rua 7', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014299739', N'Lourdes', N'Nascimento', N'uol.com.br', N'39352786', N'Lages', N'4262', N'Rua 850', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014363623', N'Raquel', N'Almeida', N'outlook.com', N'93007832', N'Sobral', N'9564', N'Rua 578', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014494982', N'Luciana', N'Pereira', N'outlook.com', N'81291010', N'Salvador', N'5873', N'Rua 366', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014559022', N'Gustavo', N'Rodrigues', N'outlook.com', N'25238622', N'Itajubá', N'7845', N'Rua 279', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014568545', N'Otávio', N'Ribeiro', N'outlook.com', N'85067471', N'Natal', N'7004', N'Rua 954', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001457427', N'Cristina', N'Carvalho', N'yahoo.com', N'63541653', N'Curitiba', N'3596', N'Rua 355', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014681399', N'Marcela', N'Silva', N'hotmail.com', N'25681906', N'Guaratinguetá', N'1600', N'Rua 208', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001471249', N'Paula', N'Almeida', N'yahoo.com', N'85663194', N'Teresópolis', N'730', N'Rua 824', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014731035', N'Higor', N'Souza', N'outlook.com', N'21674036', N'Picos', N'4508', N'Rua 327', N'Apto. 25')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001475574', N'Felipe', N'Gomes', N'uol.com.br', N'4286312', N'Porto Alegre', N'9271', N'Rua 850', N'Apto. 52')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014874039', N'Giovanna', N'Pereira', N'gmail.com', N'88625009', N'São José dos Campos', N'2136', N'Rua 503', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10014888249', N'Karina', N'Souza', N'gmail.com', N'23688234', N'Sobral', N'4123', N'Rua 749', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001498137', N'Geraldo', N'Carvalho', N'gmail.com', N'59065489', N'Palmas', N'2672', N'Rua 440', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10015038365', N'Fernão', N'Lima', N'outlook.com', N'73668594', N'Muriaé', N'5536', N'Rua 436', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10015046739', N'Elisa', N'Almeida', N'hotmail.com', N'84681894', N'Lages', N'4155', N'Rua 528', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10015062293', N'Paola', N'Pereira', N'outlook.com', N'50556609', N'Penápolis', N'5240', N'Rua 92', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001543948', N'Livia', N'Rodrigues', N'outlook.com', N'34886864', N'Macapá', N'4319', N'Rua 484', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10015440710', N'Allan', N'Pereira', N'hotmail.com', N'37819224', N'Tatuí', N'7865', N'Rua 149', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10015460027', N'Júlio', N'Lima', N'yahoo.com', N'15709009', N'Caraguatatuba', N'6050', N'Rua 71', N'Apto. 52')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10015664547', N'Sofia', N'Nascimento', N'uol.com.br', N'86378312', N'Eunápolis', N'2205', N'Rua 389', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100156816', N'Gustavo', N'Souza', N'gmail.com', N'40017670', N'Palmas', N'4728', N'Rua 669', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10015687651', N'Marcos', N'Santos', N'uol.com.br', N'28343', N'Nilópolis', N'1435', N'Rua 36', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001613020', N'Gustavo', N'Castro', N'uol.com.br', N'99058008', N'Jacareí', N'8739', N'Rua 291', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10016170970', N'Camila', N'Almeida', N'hotmail.com', N'78496295', N'São Luís', N'3101', N'Rua 746', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10016237746', N'Valéria', N'Santos', N'uol.com.br', N'64413837', N'Marília', N'3553', N'Rua 242', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001631946', N'Tábata', N'Nascimento', N'yahoo.com', N'57804759', N'Marília', N'7986', N'Rua 201', N'Apto. 2')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10016388525', N'Juliana', N'Costa', N'hotmail.com', N'20063947', N'Itapetininga', N'1900', N'Rua 351', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001653244', N'Priscila', N'Gomes', N'hotmail.com', N'9525460', N'Sete Lagoas', N'3196', N'Rua 779', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10016656648', N'Rafael', N'Gomes', N'outlook.com', N'37290420', N'João Pessoa', N'1911', N'Rua 186', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001676071', N'Vanessa', N'Castro', N'yahoo.com', N'44977345', N'Passos', N'372', N'Rua 669', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001688573', N'Taynara', N'Carvalho', N'gmail.com', N'30342830', N'São Mateus', N'1822', N'Rua 836', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001688891', N'Edna', N'Fernandes', N'outlook.com', N'32881325', N'Rio Largo', N'9358', N'Rua 997', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001692483', N'Noemi', N'Silva', N'yahoo.com', N'90374982', N'Lages', N'4480', N'Rua 199', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10017095569', N'Gabriel', N'Nascimento', N'yahoo.com', N'82210047', N'Arapiraca', N'3307', N'Rua 745', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10017174583', N'Danilo', N'Oliveira', N'uol.com.br', N'86888129', N'Vitória da Conquista', N'2186', N'Rua 896', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10017280135', N'Lídia', N'Nascimento', N'hotmail.com', N'2881092', N'Rio Largo', N'6422', N'Rua 330', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001729979', N'Ariane', N'Nascimento', N'yahoo.com', N'30998923', N'Barra Bonita', N'7113', N'Rua 98', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10017358427', N'Gabriela', N'Ribeiro', N'gmail.com', N'9918460', N'Irecê', N'5749', N'Rua 33', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10017439491', N'Flávio', N'Pereira', N'gmail.com', N'26994112', N'Belo Horizonte', N'2263', N'Rua 313', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001763828', N'Sandra', N'Oliveira', N'outlook.com', N'68051175', N'Chapecó', N'7995', N'Rua 102', N'Apto. 52')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100176638', N'Maria', N'Oliveira', N'uol.com.br', N'72002602', N'Formiga', N'9235', N'Rua 329', N'Apto. 61')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001769090', N'Gustavo', N'Oliveira', N'yahoo.com', N'31882390', N'Andradina', N'2219', N'Rua 933', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10017767552', N'Carolina', N'Lima', N'uol.com.br', N'98058683', N'Ijuí', N'39', N'Rua 505', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10017823323', N'Tábata', N'Lima', N'uol.com.br', N'30008382', N'Cuiabá', N'3564', N'Rua 926', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001794050', N'Óscar', N'Nascimento', N'uol.com.br', N'95499693', N'Tijucas', N'496', N'Rua 779', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10018126438', N'Raimunda', N'Pereira', N'hotmail.com', N'39720772', N'Crateús', N'6719', N'Rua 423', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10018127822', N'Jorge', N'Ribeiro', N'hotmail.com', N'38678094', N'Sete Lagoas', N'4547', N'Rua 391', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10018218657', N'André', N'Silva', N'outlook.com', N'52588912', N'Caratinga', N'7296', N'Rua 234', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10018381339', N'Andrea', N'Silva', N'hotmail.com', N'5438444', N'Aracaju', N'9413', N'Rua 982', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001840879', N'Vítor', N'Costa', N'uol.com.br', N'10347316', N'Teresópolis', N'1771', N'Rua 269', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10018427940', N'William', N'Lima', N'hotmail.com', N'41642918', N'Pindamonhangaba', N'7997', N'Rua 89', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10018790573', N'Pamela', N'Ribeiro', N'gmail.com', N'91612174', N'Campo Maior', N'4979', N'Rua 800', N'Apto. 90')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10018990521', N'Ariane', N'Nascimento', N'hotmail.com', N'92961636', N'Barretos', N'4716', N'Rua 198', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001915433', N'Rebeca', N'Ribeiro', N'gmail.com', N'12647580', N'Muriaé', N'6048', N'Rua 743', N'Apto. 76')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001920487', N'Érica', N'Ribeiro', N'outlook.com', N'32618082', N'São Mateus', N'6018', N'Rua 513', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10019523495', N'Claudia', N'Gomes', N'yahoo.com', N'5696050', N'São João da Boa Vista', N'196', N'Rua 77', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001955438', N'Pedro', N'Pereira', N'uol.com.br', N'83110979', N'Passo Fundo', N'8297', N'Rua 474', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001965435', N'Danilo', N'Costa', N'gmail.com', N'31058839', N'Passo Fundo', N'6861', N'Rua 69', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10019670634', N'Raimunda', N'Santos', N'yahoo.com', N'1274461', N'Sobral', N'7651', N'Rua 341', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10019716345', N'Maurício', N'Silva', N'yahoo.com', N'60604223', N'Passos', N'9762', N'Rua 242', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10019823342', N'César', N'Rodrigues', N'hotmail.com', N'61890310', N'Santa Maria', N'5912', N'Rua 208', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001983881', N'Marina', N'Almeida', N'gmail.com', N'66046194', N'Feira de Santana', N'5264', N'Rua 950', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1001984497', N'André', N'Rodrigues', N'yahoo.com', N'12718902', N'Criciúma', N'1437', N'Rua 248', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10019912438', N'Diogo', N'Ribeiro', N'yahoo.com', N'71327670', N'Salvador', N'8565', N'Rua 28', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10019988326', N'Bruno', N'Fernandes', N'hotmail.com', N'74664976', N'Santa Luzia', N'2461', N'Rua 802', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10020046599', N'Camila', N'Rodrigues', N'yahoo.com', N'24407694', N'Manaus', N'2969', N'Rua 439', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002015216', N'Ôscar', N'Fernandes', N'uol.com.br', N'47763877', N'Codó', N'403', N'Rua 2', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10020373067', N'Milena', N'Lima', N'gmail.com', N'14758707', N'São Luís', N'3511', N'Rua 29', N'Apto. 31')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002051047', N'Taynara', N'Ribeiro', N'gmail.com', N'52514846', N'Cascavel', N'929', N'Rua 172', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10020572528', N'Olga', N'Nascimento', N'gmail.com', N'59986150', N'São Carlos', N'6606', N'Rua 894', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10020677972', N'Natália', N'Souza', N'uol.com.br', N'32035897', N'Cascavel', N'6463', N'Rua 35', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10020687273', N'Geraldo', N'Pereira', N'outlook.com', N'28804092', N'Ijuí', N'4718', N'Rua 115', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10020730759', N'Pedro', N'Pereira', N'outlook.com', N'73358553', N'Teófilo Otoni', N'4940', N'Rua 445', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021074265', N'Raquel', N'Ribeiro', N'uol.com.br', N'11130948', N'Itajubá', N'7397', N'Rua 917', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021282355', N'Vivian', N'Souza', N'uol.com.br', N'10116630', N'Tijucas', N'8705', N'Rua 557', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100213180', N'André', N'Pereira', N'outlook.com', N'30069666', N'Barbacena', N'8782', N'Rua 390', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021333962', N'Everaldo', N'Almeida', N'yahoo.com', N'30518021', N'Santarém', N'2832', N'Rua 845', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021414939', N'Nelson', N'Almeida', N'outlook.com', N'72900408', N'João Pessoa', N'1719', N'Rua 984', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021648066', N'Valéria', N'Lima', N'uol.com.br', N'18543976', N'Santa Maria', N'9887', N'Rua 749', N'Apto. 76')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021682823', N'Silvio', N'Oliveira', N'uol.com.br', N'69207997', N'Arapiraca', N'6904', N'Rua 5', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021849442', N'Flávia', N'Oliveira', N'hotmail.com', N'44467430', N'Salvador', N'9998', N'Rua 497', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10021923767', N'Thaís', N'Ribeiro', N'yahoo.com', N'32207118', N'Santa Luzia', N'1584', N'Rua 224', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10022114138', N'Fernanda', N'Pereira', N'outlook.com', N'50197063', N'Porto Alegre', N'6552', N'Rua 186', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002227651', N'Elizabete', N'Pereira', N'yahoo.com', N'68701687', N'São Roque', N'956', N'Rua 107', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10022279963', N'Rafaela', N'Silva', N'gmail.com', N'6230772', N'Guaratinguetá', N'9833', N'Rua 951', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10022316626', N'Edilene', N'Ribeiro', N'uol.com.br', N'65624666', N'Frederico Westphalen', N'8562', N'Rua 901', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10022322311', N'Catarina', N'Oliveira', N'hotmail.com', N'80638221', N'Campo Maior', N'3803', N'Rua 442', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10022497394', N'Danilo', N'Castro', N'gmail.com', N'46619999', N'São José dos Campos', N'3287', N'Rua 657', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100225443', N'Paula', N'Gomes', N'yahoo.com', N'90002415', N'Palmeira das Missões', N'3688', N'Rua 327', N'Apto. 61')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10022554236', N'Eduardo', N'Ribeiro', N'gmail.com', N'56438946', N'Aracaju', N'2823', N'Rua 396', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002273356', N'Eduardo', N'Almeida', N'gmail.com', N'40266779', N'Lorena', N'1514', N'Rua 762', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10022849093', N'Pedro', N'Costa', N'uol.com.br', N'51738318', N'Bauru', N'3729', N'Rua 421', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002297387', N'João', N'Almeida', N'uol.com.br', N'7065571', N'Valença', N'198', N'Rua 614', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023328175', N'Bruna', N'Pereira', N'uol.com.br', N'48226163', N'Passo Fundo', N'193', N'Rua 885', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023346786', N'Gisele', N'Almeida', N'outlook.com', N'47520979', N'Barbacena', N'8468', N'Rua 351', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023472349', N'Cecília', N'Almeida', N'hotmail.com', N'90968886', N'Divinópolis', N'925', N'Rua 796', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023534245', N'Dandara', N'Rodrigues', N'uol.com.br', N'89692995', N'Divinópolis', N'5577', N'Rua 404', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023559599', N'Daniel', N'Rodrigues', N'outlook.com', N'72571588', N'Valença', N'5975', N'Rua 981', N'Apto. 73')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023596637', N'Juliana', N'Nascimento', N'gmail.com', N'97617270', N'Botucatu', N'3771', N'Rua 478', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023764814', N'Melissa', N'Almeida', N'hotmail.com', N'2225535', N'Lençóis Paulista', N'3275', N'Rua 691', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10023773745', N'Aline', N'Carvalho', N'gmail.com', N'89218176', N'São Lourenço', N'5635', N'Rua 757', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002377598', N'Marco', N'Oliveira', N'gmail.com', N'33050837', N'Imperatriz', N'7642', N'Rua 885', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002397012', N'Laisa', N'Souza', N'uol.com.br', N'6434051', N'Parnaíba', N'3234', N'Rua 245', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024117727', N'Glauber', N'Santos', N'outlook.com', N'7637128', N'Franca', N'7224', N'Rua 994', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002417739', N'Natália', N'Castro', N'yahoo.com', N'85079059', N'Ribeirão Pires', N'3374', N'Rua 415', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024185387', N'Sandra', N'Souza', N'gmail.com', N'22887539', N'Sobral', N'222', N'Rua 16', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024214085', N'Josiane', N'Almeida', N'outlook.com', N'9836070', N'Juazeiro do Norte', N'6070', N'Rua 702', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024250675', N'Rafael', N'Gomes', N'hotmail.com', N'90993975', N'Salto', N'1317', N'Rua 203', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002434416', N'Geovana', N'Souza', N'uol.com.br', N'28619048', N'Curitiba', N'4280', N'Rua 183', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024347081', N'Bruna', N'Castro', N'hotmail.com', N'40598839', N'Pouso Alegre', N'217', N'Rua 834', N'Apto. 32')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024382353', N'Sofia', N'Ribeiro', N'yahoo.com', N'28755969', N'Cuiabá', N'2156', N'Rua 752', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002445594', N'Luiz', N'Costa', N'uol.com.br', N'99196668', N'Muriaé', N'3574', N'Rua 991', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024457352', N'Heitor', N'Pereira', N'gmail.com', N'1414075', N'Pindamonhangaba', N'6301', N'Rua 549', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024538128', N'Luan', N'Souza', N'uol.com.br', N'50324280', N'Salto', N'5597', N'Rua 398', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002462183', N'Pamela', N'Fernandes', N'gmail.com', N'21443617', N'Lages', N'2513', N'Rua 462', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024630644', N'Felipe', N'Almeida', N'gmail.com', N'7752799', N'Salto', N'70', N'Rua 442', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024758830', N'Pamela', N'Oliveira', N'uol.com.br', N'6992401', N'Três Rios', N'7415', N'Rua 760', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024782138', N'Tainá', N'Rodrigues', N'uol.com.br', N'12815470', N'Santarém', N'7844', N'Rua 817', N'Apto. 34')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024941162', N'Nelson', N'Rodrigues', N'hotmail.com', N'29652400', N'Pouso Alegre', N'9135', N'Rua 236', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10024979528', N'Amanda', N'Ribeiro', N'yahoo.com', N'36963993', N'Vitória', N'5746', N'Rua 454', N'Apto. 88')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025151136', N'Xavier', N'Costa', N'hotmail.com', N'82300581', N'Salto', N'5571', N'Rua 313', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025322189', N'Eliseu', N'Oliveira', N'hotmail.com', N'21174754', N'Santa Luzia', N'6683', N'Rua 250', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025376636', N'Nilson', N'Pereira', N'gmail.com', N'97107965', N'Criciúma', N'5837', N'Rua 164', N'Apto. 76')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025392020', N'Silvio', N'Nascimento', N'uol.com.br', N'55893252', N'Porto Alegre', N'9284', N'Rua 11', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100254759', N'Alessandra', N'Fernandes', N'hotmail.com', N'53192082', N'Porto Alegre', N'822', N'Rua 178', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002553265', N'Eduardo', N'Silva', N'outlook.com', N'14376201', N'Santa Luzia', N'2952', N'Rua 59', N'Apto. 88')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025547946', N'Maria', N'Fernandes', N'yahoo.com', N'88542007', N'Sete Lagoas', N'11', N'Rua 474', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025579477', N'Everaldo', N'Castro', N'uol.com.br', N'84063811', N'Divinópolis', N'957', N'Rua 170', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025613185', N'Rafaela', N'Lima', N'gmail.com', N'89194130', N'Vitória', N'9418', N'Rua 792', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025646436', N'Júlia', N'Rodrigues', N'outlook.com', N'85229125', N'Curitiba', N'3846', N'Rua 991', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025790383', N'Paulo', N'Rodrigues', N'outlook.com', N'72784885', N'Lavras', N'9466', N'Rua 225', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10025955685', N'Valéria', N'Silva', N'uol.com.br', N'69031696', N'Penápolis', N'1451', N'Rua 648', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002641134', N'Ôscar', N'Ribeiro', N'uol.com.br', N'5708963', N'Caruaru', N'1865', N'Rua 334', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10026427883', N'Felipe', N'Lima', N'yahoo.com', N'34316585', N'Lages', N'2408', N'Rua 522', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10026590232', N'Miriam', N'Gomes', N'hotmail.com', N'94504732', N'Cachoeira do Sul', N'9261', N'Rua 417', N'Apto. 15')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10026685146', N'Fabiano', N'Carvalho', N'gmail.com', N'55197143', N'Goiânia', N'3874', N'Rua 236', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10026832342', N'Tábata', N'Gomes', N'gmail.com', N'54131433', N'Caruaru', N'9538', N'Rua 343', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10026847283', N'Pietra', N'Almeida', N'outlook.com', N'28968314', N'Lavras', N'1835', N'Rua 892', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10027048454', N'Elaine', N'Lima', N'uol.com.br', N'73647798', N'Registro', N'2323', N'Rua 225', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10027085425', N'Luiza', N'Almeida', N'outlook.com', N'75692940', N'Palmas', N'5756', N'Rua 64', N'Apto. 10')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10027142074', N'Diego', N'Oliveira', N'gmail.com', N'99044079', N'Itatiba', N'3004', N'Rua 739', N'Apto. 71')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10027297893', N'José', N'Almeida', N'gmail.com', N'48393163', N'Guaratinguetá', N'8427', N'Rua 184', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002730264', N'Luciana', N'Carvalho', N'uol.com.br', N'48593261', N'Formiga', N'9096', N'Rua 762', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10027597515', N'Claudia', N'Gomes', N'uol.com.br', N'99447818', N'Rio Largo', N'8526', N'Rua 896', N'Apto. 30')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002774818', N'Ágatha', N'Castro', N'gmail.com', N'32882862', N'Chapecó', N'5505', N'Rua 164', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002783069', N'Rodrigo', N'Silva', N'yahoo.com', N'78787316', N'Crateús', N'7590', N'Rua 955', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002784998', N'Anderson', N'Castro', N'yahoo.com', N'36826222', N'Santarém', N'4467', N'Rua 634', N'Apto. 83')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10027859611', N'Amanda', N'Gomes', N'yahoo.com', N'25654463', N'Araranguá', N'1791', N'Rua 694', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002787970', N'Mariana', N'Ribeiro', N'hotmail.com', N'66123929', N'Ijuí', N'6313', N'Rua 966', N'Apto. 85')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10027982613', N'Olga', N'Ribeiro', N'gmail.com', N'35171288', N'Arapiraca', N'2416', N'Rua 36', N'Apto. 11')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028062915', N'Vivian', N'Fernandes', N'yahoo.com', N'84485990', N'Irecê', N'266', N'Rua 150', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002816136', N'Gisele', N'Rodrigues', N'gmail.com', N'7396415', N'Ipatinga', N'4035', N'Rua 618', N'Apto. 82')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028181289', N'Ivan', N'Lima', N'outlook.com', N'92564185', N'Lages', N'4357', N'Rua 600', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028294346', N'Érica', N'Rodrigues', N'gmail.com', N'64857363', N'Itapecerica da Serra', N'8275', N'Rua 457', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028299971', N'Natália', N'Rodrigues', N'gmail.com', N'58643853', N'Nilópolis', N'5539', N'Rua 611', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028331598', N'Fernão', N'Almeida', N'hotmail.com', N'51962776', N'Juazeiro do Norte', N'1876', N'Rua 283', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028446276', N'Edna', N'Nascimento', N'gmail.com', N'36129819', N'Viamão', N'7880', N'Rua 760', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028480831', N'Rafaela', N'Oliveira', N'outlook.com', N'68363780', N'Salto', N'8855', N'Rua 352', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002859845', N'Sandra', N'Souza', N'hotmail.com', N'27945990', N'Boa Vista', N'1107', N'Rua 536', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028798491', N'Eunice', N'Costa', N'gmail.com', N'69148', N'Marília', N'4708', N'Rua 722', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028854823', N'Fabiana', N'Nascimento', N'uol.com.br', N'31980857', N'Santa Cruz do Sul', N'6225', N'Rua 970', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002895140', N'Samuel', N'Fernandes', N'yahoo.com', N'9598362', N'Leme', N'4906', N'Rua 567', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10028958375', N'Franciele', N'Souza', N'hotmail.com', N'36988846', N'Tatuí', N'5193', N'Rua 771', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029037652', N'Flávia', N'Fernandes', N'outlook.com', N'69249217', N'Irecê', N'1842', N'Rua 955', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029046291', N'Leticia', N'Lima', N'hotmail.com', N'17021240', N'Imperatriz', N'6811', N'Rua 859', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029085515', N'Laís', N'Costa', N'hotmail.com', N'3924922', N'Porto Alegre', N'3204', N'Rua 496', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029093526', N'Zélia', N'Fernandes', N'hotmail.com', N'2308145', N'Feira de Santana', N'3833', N'Rua 904', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029235', N'Maria', N'Rodrigues', N'gmail.com', N'54346291', N'Barra Bonita', N'9272', N'Rua 455', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029280738', N'Mariana', N'Santos', N'gmail.com', N'30952811', N'Guanambi', N'2600', N'Rua 16', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002935581', N'Miriam', N'Souza', N'hotmail.com', N'11006651', N'Salvador', N'36', N'Rua 519', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002937930', N'Ismael', N'Lima', N'yahoo.com', N'94641537', N'Lages', N'6673', N'Rua 730', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029635053', N'Cesar', N'Castro', N'outlook.com', N'71411093', N'São Paulo', N'2373', N'Rua 134', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002989011', N'Laís', N'Pereira', N'uol.com.br', N'92439723', N'Irecê', N'6332', N'Rua 701', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10029894936', N'Thiago', N'Oliveira', N'outlook.com', N'38641868', N'Lorena', N'9592', N'Rua 392', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100299381', N'Thaís', N'Souza', N'gmail.com', N'47381187', N'Assis', N'9104', N'Rua 336', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1002998026', N'Maurício', N'Almeida', N'yahoo.com', N'34905840', N'Botucatu', N'252', N'Rua 150', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030061489', N'Samuel', N'Almeida', N'yahoo.com', N'65962872', N'Santarém', N'1860', N'Rua 261', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003007231', N'Nelson', N'Almeida', N'yahoo.com', N'81064121', N'Itanhaém', N'7997', N'Rua 295', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030117131', N'Felipe', N'Souza', N'yahoo.com', N'82276212', N'Araguaína', N'8062', N'Rua 752', N'Apto. 17')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030469569', N'Marina', N'Ribeiro', N'outlook.com', N'22509333', N'Pouso Alegre', N'6868', N'Rua 150', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030530458', N'Geraldo', N'Rodrigues', N'hotmail.com', N'74091598', N'Recife', N'8147', N'Rua 308', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003071494', N'Daniel', N'Santos', N'uol.com.br', N'29331127', N'Barbacena', N'3595', N'Rua 215', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030736238', N'Geraldo', N'Gomes', N'yahoo.com', N'30824455', N'Barbacena', N'8997', N'Rua 433', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030745316', N'Ingrid', N'Carvalho', N'uol.com.br', N'23905673', N'Frederico Westphalen', N'4180', N'Rua 469', N'Apto. 30')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003081668', N'Elisa', N'Gomes', N'outlook.com', N'17104412', N'Rio Largo', N'9615', N'Rua 290', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030923554', N'Xavier', N'Nascimento', N'outlook.com', N'38480960', N'Santa Cruz do Sul', N'5738', N'Rua 963', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030977841', N'Samuel', N'Silva', N'hotmail.com', N'91229090', N'Araguaína', N'2106', N'Rua 239', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10030981531', N'Diogo', N'Oliveira', N'hotmail.com', N'62193030', N'Juazeiro do Norte', N'7215', N'Rua 594', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031039175', N'Isadora', N'Almeida', N'yahoo.com', N'74140283', N'Frederico Westphalen', N'2953', N'Rua 942', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003113533', N'Marisa', N'Rodrigues', N'yahoo.com', N'24554297', N'Blumenau', N'9588', N'Rua 400', N'Apto. 15')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031157336', N'Luiza', N'Almeida', N'hotmail.com', N'4892650', N'Marília', N'5473', N'Rua 92', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003115834', N'Maria', N'Ribeiro', N'uol.com.br', N'68036402', N'Salto', N'8884', N'Rua 645', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031249445', N'Thiago', N'Almeida', N'uol.com.br', N'92450521', N'Bragança Paulista', N'9539', N'Rua 200', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031639965', N'Ingrid', N'Silva', N'outlook.com', N'52442714', N'Teresópolis', N'2300', N'Rua 527', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003165538', N'Claudia', N'Costa', N'gmail.com', N'59982171', N'João Pessoa', N'685', N'Rua 580', N'Apto. 43')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100316591', N'Lourdes', N'Ribeiro', N'outlook.com', N'13544617', N'Barbacena', N'5450', N'Rua 509', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031674255', N'Fernão', N'Lima', N'uol.com.br', N'54687817', N'Itapetininga', N'5853', N'Rua 974', N'Apto. 10')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031691132', N'Diogo', N'Fernandes', N'hotmail.com', N'72816394', N'Eunápolis', N'5542', N'Rua 578', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031778792', N'Lourdes', N'Lima', N'uol.com.br', N'64388983', N'Santa Cruz do Sul', N'4101', N'Rua 776', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031861287', N'Helena', N'Fernandes', N'hotmail.com', N'1536258', N'São João da Boa Vista', N'5206', N'Rua 812', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10031975783', N'Rebeca', N'Almeida', N'yahoo.com', N'96208310', N'Botucatu', N'5957', N'Rua 705', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003211162', N'Sílvia', N'Lima', N'uol.com.br', N'14116213', N'Tijucas', N'2638', N'Rua 53', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003216132', N'Andrea', N'Silva', N'hotmail.com', N'91652278', N'Crateús', N'5451', N'Rua 204', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003221483', N'Silvio', N'Pereira', N'outlook.com', N'21403827', N'Cotia', N'3296', N'Rua 300', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032363459', N'Rafaela', N'Oliveira', N'hotmail.com', N'16991343', N'Macapá', N'7183', N'Rua 530', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032522761', N'Marcelo', N'Ribeiro', N'hotmail.com', N'26237008', N'Salto', N'2788', N'Rua 959', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032529768', N'Henrique', N'Lima', N'outlook.com', N'81632042', N'Teófilo Otoni', N'476', N'Rua 30', N'Apto. 85')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003257596', N'Wálter', N'Souza', N'outlook.com', N'29526410', N'Cotia', N'4999', N'Rua 559', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003258284', N'Cláudio', N'Gomes', N'yahoo.com', N'67760415', N'São José dos Campos', N'4551', N'Rua 359', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032652827', N'Ismael', N'Souza', N'yahoo.com', N'26835007', N'Guanambi', N'5618', N'Rua 617', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032667094', N'Eduardo', N'Gomes', N'outlook.com', N'34513895', N'Sobral', N'1924', N'Rua 171', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032737458', N'Bruna', N'Gomes', N'uol.com.br', N'87370689', N'Ijuí', N'3100', N'Rua 295', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032751720', N'Antônio', N'Fernandes', N'hotmail.com', N'91227215', N'Três Rios', N'4602', N'Rua 489', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032751931', N'Solange', N'Nascimento', N'gmail.com', N'69991742', N'Porto Alegre', N'2979', N'Rua 501', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032766372', N'Kelly', N'Silva', N'yahoo.com', N'8935788', N'Recife', N'3683', N'Rua 230', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003282156', N'Heitor', N'Castro', N'outlook.com', N'49867186', N'Porto Alegre', N'6581', N'Rua 689', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032868868', N'Fabrício', N'Rodrigues', N'hotmail.com', N'95544593', N'Crateús', N'161', N'Rua 350', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003295163', N'Renata', N'Ribeiro', N'outlook.com', N'90991482', N'Sobral', N'1343', N'Rua 84', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10032991476', N'João', N'Pereira', N'yahoo.com', N'39757494', N'Itapecerica da Serra', N'3661', N'Rua 266', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033069173', N'Marina', N'Gomes', N'hotmail.com', N'56646975', N'Bragança Paulista', N'5231', N'Rua 295', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003313452', N'Danilo', N'Pereira', N'hotmail.com', N'38753153', N'Rio de Janeiro', N'4888', N'Rua 414', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033145744', N'Christian', N'Almeida', N'outlook.com', N'19966095', N'Guarapari', N'353', N'Rua 729', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033175991', N'Isadora', N'Castro', N'outlook.com', N'99289214', N'Rio de Janeiro', N'3888', N'Rua 330', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100333023', N'Jorge', N'Ribeiro', N'yahoo.com', N'49394367', N'Camaquã', N'4645', N'Rua 638', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033464795', N'Noemi', N'Santos', N'hotmail.com', N'55780855', N'Vitória da Conquista', N'9536', N'Rua 817', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033473040', N'Ariane', N'Nascimento', N'uol.com.br', N'5792530', N'Picos', N'6253', N'Rua 447', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033513836', N'Tainá', N'Gomes', N'gmail.com', N'63393871', N'Cachoeira do Sul', N'2260', N'Rua 61', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033742199', N'César', N'Carvalho', N'hotmail.com', N'13900419', N'Tatuí', N'9158', N'Rua 60', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100338652', N'Stella', N'Lima', N'hotmail.com', N'47170513', N'Camaquã', N'6115', N'Rua 710', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033959839', N'Carolina', N'Fernandes', N'yahoo.com', N'28062287', N'Itatiba', N'6459', N'Rua 285', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10033972285', N'Laura', N'Silva', N'hotmail.com', N'66816030', N'Brasília', N'5688', N'Rua 150', N'Apto. 17')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034040772', N'Henrique', N'Castro', N'outlook.com', N'4975021', N'Guarapari', N'5072', N'Rua 43', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034060350', N'Karina', N'Santos', N'uol.com.br', N'6655679', N'Valença', N'57', N'Rua 737', N'Apto. 88')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034214460', N'Giovanna', N'Castro', N'hotmail.com', N'38603424', N'Lavras', N'5764', N'Rua 379', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100342241', N'Samuel', N'Castro', N'outlook.com', N'61402498', N'Criciúma', N'3979', N'Rua 688', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034229754', N'Luan', N'Costa', N'uol.com.br', N'87324116', N'Caratinga', N'6744', N'Rua 448', N'Apto. 20')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034251749', N'Ismael', N'Santos', N'uol.com.br', N'59614728', N'Barbacena', N'398', N'Rua 283', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034256341', N'Júlia', N'Santos', N'uol.com.br', N'20773989', N'Pindamonhangaba', N'3060', N'Rua 323', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034289425', N'David', N'Gomes', N'gmail.com', N'50042888', N'Araguaína', N'9636', N'Rua 945', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034435410', N'Elisa', N'Oliveira', N'gmail.com', N'1706342', N'São Luís', N'5780', N'Rua 128', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034437351', N'Stefany', N'Pereira', N'outlook.com', N'79205919', N'Barbacena', N'2589', N'Rua 395', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003445301', N'Diego', N'Lima', N'outlook.com', N'56947998', N'Maringá', N'9745', N'Rua 993', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034512230', N'Vanessa', N'Souza', N'yahoo.com', N'2380646', N'São José dos Campos', N'3938', N'Rua 32', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034766964', N'Augusto', N'Almeida', N'uol.com.br', N'38835032', N'Teófilo Otoni', N'2518', N'Rua 587', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10034948924', N'Matheus', N'Fernandes', N'uol.com.br', N'62937649', N'Bauru', N'6731', N'Rua 859', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003515883', N'Natalia', N'Silva', N'gmail.com', N'61132017', N'Caratinga', N'1678', N'Rua 730', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035455721', N'Vanessa', N'Rodrigues', N'outlook.com', N'24761936', N'Santa Luzia', N'432', N'Rua 394', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035579419', N'Bruno', N'Souza', N'yahoo.com', N'10409070', N'Vitória da Conquista', N'8875', N'Rua 1000', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035632779', N'Wellington', N'Fernandes', N'outlook.com', N'79818136', N'Araranguá', N'2315', N'Rua 76', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003566004', N'Carolina', N'Oliveira', N'hotmail.com', N'59587612', N'Lages', N'1893', N'Rua 826', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003570695', N'Francisco', N'Nascimento', N'yahoo.com', N'68709974', N'Bacabal', N'4113', N'Rua 528', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035724071', N'Ester', N'Ribeiro', N'gmail.com', N'73361610', N'Ourinhos', N'7173', N'Rua 990', N'Apto. 7')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035730785', N'Gustavo', N'Castro', N'outlook.com', N'37131275', N'Sobral', N'5106', N'Rua 291', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003576294', N'Isadora', N'Costa', N'yahoo.com', N'49689291', N'Brasília', N'4752', N'Rua 339', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035823311', N'Isabela', N'Pereira', N'uol.com.br', N'86102145', N'Goiânia', N'7150', N'Rua 472', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035873874', N'Patrícia', N'Nascimento', N'yahoo.com', N'40045838', N'Rio Largo', N'7439', N'Rua 825', N'Apto. 25')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035948045', N'Vivian', N'Souza', N'yahoo.com', N'23156541', N'Fortaleza', N'6604', N'Rua 380', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10035984274', N'Clara', N'Almeida', N'hotmail.com', N'79104325', N'Pouso Alegre', N'6072', N'Rua 153', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036355939', N'Luan', N'Almeida', N'outlook.com', N'85212848', N'Bragança Paulista', N'8716', N'Rua 801', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036511254', N'Verônica', N'Almeida', N'outlook.com', N'34388773', N'Assis', N'1259', N'Rua 881', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036548514', N'Juliana', N'Castro', N'hotmail.com', N'88680254', N'Manaus', N'3193', N'Rua 899', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036551577', N'Samuel', N'Oliveira', N'uol.com.br', N'54219807', N'Teófilo Otoni', N'3160', N'Rua 414', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036679012', N'Leticia', N'Oliveira', N'uol.com.br', N'19557868', N'Bauru', N'6876', N'Rua 19', N'Apto. 71')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036821548', N'Juliana', N'Ribeiro', N'yahoo.com', N'1424088', N'Manaus', N'6366', N'Rua 337', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036888141', N'Lorena', N'Lima', N'yahoo.com', N'33998714', N'São Roque', N'478', N'Rua 117', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036889828', N'Fabiana', N'Oliveira', N'uol.com.br', N'27920750', N'Araranguá', N'112', N'Rua 433', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036935121', N'Allan', N'Carvalho', N'uol.com.br', N'41499345', N'Porto Alegre', N'3504', N'Rua 728', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10036952520', N'Henrique', N'Pereira', N'hotmail.com', N'33927228', N'Leme', N'4433', N'Rua 680', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100369930', N'Caio', N'Ribeiro', N'uol.com.br', N'96307113', N'Santa Cruz do Sul', N'1309', N'Rua 573', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003718529', N'Natália', N'Ribeiro', N'gmail.com', N'76165031', N'Vitória', N'4781', N'Rua 449', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10037243240', N'Ricardo', N'Rodrigues', N'uol.com.br', N'47906903', N'Pouso Alegre', N'2704', N'Rua 618', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10037263067', N'Luiz', N'Fernandes', N'outlook.com', N'96464725', N'Santa Luzia', N'1977', N'Rua 291', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10037426564', N'Ismael', N'Santos', N'hotmail.com', N'51689029', N'Barretos', N'6504', N'Rua 671', N'Apto. 25')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10037436644', N'Gisele', N'Castro', N'uol.com.br', N'95214423', N'Teófilo Otoni', N'9018', N'Rua 938', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10037448411', N'Xavier', N'Rodrigues', N'gmail.com', N'5043391', N'Itapecerica da Serra', N'8645', N'Rua 864', N'Apto. 34')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100375084', N'Heitor', N'Silva', N'uol.com.br', N'12805725', N'Registro', N'8849', N'Rua 638', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10037636930', N'Zélia', N'Pereira', N'yahoo.com', N'86550161', N'Cascavel', N'9838', N'Rua 230', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10037789550', N'Sandra', N'Rodrigues', N'gmail.com', N'8325651', N'São José dos Campos', N'2283', N'Rua 288', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003782411', N'Janaína', N'Carvalho', N'gmail.com', N'88452529', N'Itapecerica da Serra', N'1973', N'Rua 163', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038071075', N'Beatriz', N'Gomes', N'hotmail.com', N'37917915', N'Muriaé', N'2768', N'Rua 153', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038083054', N'Marta', N'Souza', N'hotmail.com', N'57817182', N'São Roque', N'7697', N'Rua 160', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038114372', N'Lorena', N'Gomes', N'outlook.com', N'75396903', N'Bacabal', N'1191', N'Rua 859', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038223241', N'Júlio', N'Santos', N'yahoo.com', N'21276400', N'Criciúma', N'3408', N'Rua 559', N'Apto. 76')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038228224', N'Rafael', N'Gomes', N'hotmail.com', N'79458623', N'Barretos', N'3760', N'Rua 242', N'Apto. 25')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038259697', N'Zélia', N'Silva', N'yahoo.com', N'74134212', N'Divinópolis', N'8661', N'Rua 968', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038298463', N'Ismael', N'Souza', N'gmail.com', N'61402383', N'Sobral', N'3521', N'Rua 544', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038358236', N'Livia', N'Costa', N'outlook.com', N'39076500', N'Três Rios', N'8731', N'Rua 231', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038439450', N'Regina', N'Santos', N'uol.com.br', N'47711784', N'Belo Horizonte', N'1955', N'Rua 223', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038466542', N'Pamela', N'Santos', N'uol.com.br', N'28812309', N'Assis', N'7594', N'Rua 947', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038574639', N'Maurício', N'Pereira', N'yahoo.com', N'74766796', N'Cascavel', N'9882', N'Rua 89', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038595676', N'Wilson', N'Gomes', N'uol.com.br', N'13472896', N'Santa Luzia', N'8468', N'Rua 61', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038650592', N'Wellington', N'Pereira', N'outlook.com', N'778207', N'Salvador', N'1937', N'Rua 963', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10038955882', N'Raimunda', N'Rodrigues', N'hotmail.com', N'92730514', N'Botucatu', N'9906', N'Rua 622', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039018289', N'Gisele', N'Rodrigues', N'gmail.com', N'79175375', N'Lages', N'372', N'Rua 490', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039068714', N'Clara', N'Ribeiro', N'uol.com.br', N'1962078', N'Ourinhos', N'9079', N'Rua 13', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039124267', N'Thaís', N'Gomes', N'hotmail.com', N'8605918', N'São Lourenço', N'3740', N'Rua 334', N'Apto. 15')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039229246', N'Lorena', N'Gomes', N'hotmail.com', N'99903540', N'Passos', N'2051', N'Rua 861', N'Apto. 2')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039239022', N'Eunice', N'Santos', N'outlook.com', N'17035893', N'Sobral', N'5444', N'Rua 158', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039293617', N'Ágatha', N'Castro', N'gmail.com', N'65199145', N'Palmeira das Missões', N'5881', N'Rua 392', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039421128', N'Joaquim', N'Carvalho', N'outlook.com', N'98639141', N'Aracaju', N'2684', N'Rua 396', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039533370', N'Tábata', N'Fernandes', N'yahoo.com', N'93652840', N'Santa Cruz do Sul', N'502', N'Rua 279', N'Apto. 31')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1003960126', N'Elizabete', N'Gomes', N'outlook.com', N'34229529', N'Santa Cruz do Sul', N'4059', N'Rua 103', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10039620930', N'Marco', N'Rodrigues', N'hotmail.com', N'99358484', N'Irecê', N'1062', N'Rua 462', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040031454', N'Érica', N'Silva', N'yahoo.com', N'85581485', N'São José dos Campos', N'3781', N'Rua 254', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004009797', N'Ôscar', N'Almeida', N'uol.com.br', N'75482059', N'Itapetininga', N'1934', N'Rua 205', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040195185', N'Manuela', N'Fernandes', N'yahoo.com', N'80688574', N'São José dos Campos', N'5284', N'Rua 232', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040319317', N'Janaína', N'Souza', N'gmail.com', N'24619117', N'Palmas', N'8956', N'Rua 934', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040327336', N'Marta', N'Carvalho', N'gmail.com', N'63837543', N'Lages', N'7569', N'Rua 853', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040414261', N'Raimunda', N'Souza', N'gmail.com', N'56929681', N'Picos', N'6451', N'Rua 736', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040530239', N'Francisco', N'Oliveira', N'outlook.com', N'94811250', N'Belo Horizonte', N'5761', N'Rua 48', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040553235', N'Christian', N'Silva', N'outlook.com', N'36021341', N'Gaspar', N'3818', N'Rua 468', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040587136', N'Gilberto', N'Pereira', N'gmail.com', N'49466128', N'Santa Maria', N'1789', N'Rua 759', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004059038', N'Xavier', N'Castro', N'hotmail.com', N'1672005', N'Bauru', N'8381', N'Rua 624', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040615634', N'Flávio', N'Pereira', N'hotmail.com', N'72817237', N'Tatuí', N'8916', N'Rua 299', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040729243', N'Sara', N'Souza', N'outlook.com', N'75702746', N'Curitiba', N'4992', N'Rua 513', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040759117', N'David', N'Castro', N'gmail.com', N'25550738', N'Sete Lagoas', N'6745', N'Rua 31', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040772954', N'Natalia', N'Castro', N'gmail.com', N'96919399', N'Recife', N'1307', N'Rua 529', N'Apto. 73')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040860614', N'Paulo', N'Gomes', N'uol.com.br', N'79184890', N'Caruaru', N'8444', N'Rua 558', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040968876', N'Camila', N'Rodrigues', N'uol.com.br', N'38757106', N'Parnaíba', N'706', N'Rua 168', N'Apto. 32')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10040973422', N'Érica', N'Rodrigues', N'yahoo.com', N'70711288', N'Cascavel', N'2173', N'Rua 206', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10041296373', N'Gerson', N'Rodrigues', N'yahoo.com', N'51120912', N'São Luís', N'3241', N'Rua 46', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10041467785', N'Felipe', N'Rodrigues', N'hotmail.com', N'70562729', N'São Roque', N'7730', N'Rua 624', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10041631137', N'Wilson', N'Pereira', N'uol.com.br', N'29390466', N'Marília', N'1032', N'Rua 524', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10041665654', N'Gustavo', N'Ribeiro', N'gmail.com', N'38670514', N'Blumenau', N'4217', N'Rua 906', N'Apto. 32')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004175256', N'Caio', N'Costa', N'yahoo.com', N'35562188', N'Palmas', N'6561', N'Rua 768', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004183855', N'Marco', N'Nascimento', N'gmail.com', N'86783518', N'Marília', N'3593', N'Rua 869', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004186866', N'Xavier', N'Pereira', N'gmail.com', N'8101124', N'Codó', N'3860', N'Rua 239', N'Apto. 88')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042058734', N'Nathalia', N'Santos', N'gmail.com', N'31668024', N'Salvador', N'4452', N'Rua 125', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004206474', N'Márcia', N'Lima', N'yahoo.com', N'29962874', N'Palmas', N'1466', N'Rua 303', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042149357', N'Débora', N'Ribeiro', N'outlook.com', N'41182544', N'Santa Luzia', N'5855', N'Rua 508', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042219821', N'Valéria', N'Costa', N'gmail.com', N'97457067', N'Guarapari', N'2735', N'Rua 450', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042296668', N'Wilson', N'Ribeiro', N'uol.com.br', N'10970991', N'Boa Vista', N'7344', N'Rua 568', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042296735', N'Renata', N'Santos', N'outlook.com', N'98789291', N'Teófilo Otoni', N'3495', N'Rua 436', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042419574', N'Fernão', N'Silva', N'yahoo.com', N'23300318', N'Boa Vista', N'1914', N'Rua 108', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100426471', N'Danilo', N'Costa', N'uol.com.br', N'53764775', N'Salvador', N'2395', N'Rua 449', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042711376', N'Luiz', N'Lima', N'yahoo.com', N'58480133', N'Santa Maria', N'429', N'Rua 711', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042726524', N'Uirá', N'Ribeiro', N'yahoo.com', N'45365399', N'Juazeiro do Norte', N'3132', N'Rua 717', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100427427', N'Bruna', N'Santos', N'outlook.com', N'83312608', N'Juazeiro do Norte', N'5097', N'Rua 116', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042771660', N'Wálter', N'Lima', N'hotmail.com', N'7331104', N'Valença', N'2701', N'Rua 727', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042852690', N'Rodrigo', N'Carvalho', N'hotmail.com', N'95097490', N'Araranguá', N'1120', N'Rua 61', N'Apto. 43')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042939555', N'Cesar', N'Lima', N'yahoo.com', N'8513863', N'Andradina', N'5395', N'Rua 807', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10042975097', N'Uirá', N'Castro', N'gmail.com', N'7021894', N'Itapecerica da Serra', N'5427', N'Rua 440', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004307017', N'Allan', N'Oliveira', N'outlook.com', N'93503951', N'Formiga', N'4736', N'Rua 810', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10043125283', N'Pedro', N'Silva', N'uol.com.br', N'19694480', N'Assis', N'3514', N'Rua 685', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004331263', N'Daniel', N'Carvalho', N'yahoo.com', N'73572529', N'Manaus', N'1144', N'Rua 58', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10043334324', N'Maicon', N'Almeida', N'hotmail.com', N'23329135', N'Registro', N'7224', N'Rua 136', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004338532', N'Solange', N'Fernandes', N'hotmail.com', N'60058008', N'Jacareí', N'4136', N'Rua 92', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004367865', N'Alessandra', N'Almeida', N'gmail.com', N'11749585', N'Jacareí', N'2812', N'Rua 183', N'Apto. 10')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10043822718', N'Ester', N'Costa', N'gmail.com', N'2354861', N'Irecê', N'762', N'Rua 647', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10043842683', N'Lídia', N'Costa', N'outlook.com', N'44935887', N'Arapongas', N'4483', N'Rua 534', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10043845714', N'Marco', N'Fernandes', N'hotmail.com', N'96049551', N'Palmas', N'701', N'Rua 69', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004386765', N'Nathalia', N'Silva', N'yahoo.com', N'98495568', N'Criciúma', N'8191', N'Rua 781', N'Apto. 57')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10044148111', N'Allan', N'Costa', N'hotmail.com', N'48425720', N'Botucatu', N'8698', N'Rua 300', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10044283663', N'Sofia', N'Fernandes', N'hotmail.com', N'97073988', N'Divinópolis', N'9882', N'Rua 649', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004434959', N'Valentina', N'Carvalho', N'outlook.com', N'31763300', N'São Lourenço', N'5690', N'Rua 312', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10044364526', N'Stefany', N'Ribeiro', N'uol.com.br', N'77821099', N'Goiânia', N'1372', N'Rua 807', N'Apto. 18')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10044543766', N'Luan', N'Gomes', N'yahoo.com', N'92294104', N'Ijuí', N'3655', N'Rua 479', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10044745879', N'Matheus', N'Castro', N'yahoo.com', N'79589463', N'Lençóis Paulista', N'7302', N'Rua 319', N'Apto. 30')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004499867', N'Claudia', N'Oliveira', N'outlook.com', N'97949938', N'Barra Bonita', N'4906', N'Rua 348', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10045326027', N'Alice', N'Pereira', N'gmail.com', N'86340505', N'Cubatão', N'923', N'Rua 486', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10045347037', N'Regina', N'Rodrigues', N'yahoo.com', N'21647940', N'Lavras', N'88', N'Rua 233', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10045526830', N'Luiz', N'Santos', N'outlook.com', N'68954266', N'Arapongas', N'1623', N'Rua 161', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10045531167', N'Thiago', N'Almeida', N'gmail.com', N'50599140', N'Aracaju', N'5421', N'Rua 656', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004582910', N'Marcela', N'Rodrigues', N'outlook.com', N'77307024', N'Palmas', N'4352', N'Rua 526', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10045853268', N'Priscila', N'Fernandes', N'outlook.com', N'78181927', N'Caraguatatuba', N'5188', N'Rua 830', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046039520', N'Genival', N'Gomes', N'uol.com.br', N'4810003', N'Irecê', N'4769', N'Rua 598', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046048555', N'Fabrício', N'Costa', N'hotmail.com', N'33808185', N'Ourinhos', N'8094', N'Rua 314', N'Apto. 11')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046068667', N'Vivian', N'Almeida', N'hotmail.com', N'73155233', N'Caratinga', N'1373', N'Rua 111', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004608498', N'Luis', N'Nascimento', N'gmail.com', N'42401207', N'Lavras', N'2213', N'Rua 482', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004610810', N'Fabiana', N'Castro', N'outlook.com', N'92899035', N'Nilópolis', N'4224', N'Rua 336', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046131845', N'Lara', N'Almeida', N'gmail.com', N'39753498', N'Pouso Alegre', N'7670', N'Rua 869', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046173634', N'Lorena', N'Castro', N'yahoo.com', N'42038526', N'Barretos', N'981', N'Rua 386', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046233831', N'Patrícia', N'Carvalho', N'outlook.com', N'34900270', N'Palmeira das Missões', N'7963', N'Rua 395', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046379930', N'Sofia', N'Castro', N'hotmail.com', N'38892733', N'Pindamonhangaba', N'3404', N'Rua 59', N'Apto. 32')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046452251', N'Ricardo', N'Castro', N'uol.com.br', N'20237237', N'Cascavel', N'5302', N'Rua 86', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004647767', N'Ricardo', N'Lima', N'gmail.com', N'63397187', N'Barra Bonita', N'5529', N'Rua 775', N'Apto. 10')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046485080', N'Ismaelita', N'Nascimento', N'yahoo.com', N'81418480', N'Passo Fundo', N'5931', N'Rua 804', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046598425', N'Tatiana', N'Costa', N'gmail.com', N'64906811', N'Irecê', N'6138', N'Rua 72', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046612453', N'Nathalia', N'Santos', N'outlook.com', N'58619110', N'Muriaé', N'6531', N'Rua 116', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10046789090', N'David', N'Santos', N'yahoo.com', N'52206456', N'Pouso Alegre', N'6936', N'Rua 561', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047034914', N'Karen', N'Santos', N'outlook.com', N'98968420', N'Salvador', N'260', N'Rua 939', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047072278', N'Augusto', N'Silva', N'hotmail.com', N'60522610', N'Nilópolis', N'3195', N'Rua 838', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047150386', N'Diego', N'Castro', N'outlook.com', N'98701608', N'Aracaju', N'2641', N'Rua 952', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004722891', N'Vanessa', N'Costa', N'outlook.com', N'77975308', N'São Lourenço', N'8423', N'Rua 594', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004723049', N'Maurício', N'Oliveira', N'yahoo.com', N'38398386', N'Maringá', N'5324', N'Rua 828', N'Apto. 15')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004730473', N'Helena', N'Almeida', N'uol.com.br', N'87934406', N'Caraguatatuba', N'8758', N'Rua 75', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004740910', N'Rafael', N'Rodrigues', N'yahoo.com', N'59176726', N'Sete Lagoas', N'7776', N'Rua 295', N'Apto. 85')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047460159', N'Genival', N'Costa', N'yahoo.com', N'13411996', N'Araranguá', N'4783', N'Rua 227', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047827159', N'Larissa', N'Souza', N'uol.com.br', N'91917739', N'Palmeira das Missões', N'7665', N'Rua 669', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047830945', N'Aline', N'Rodrigues', N'hotmail.com', N'15852176', N'Santa Luzia', N'8919', N'Rua 976', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047874110', N'Regina', N'Castro', N'outlook.com', N'33677425', N'Cascavel', N'4873', N'Rua 379', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10047976062', N'Zélia', N'Ribeiro', N'hotmail.com', N'84896263', N'Tijucas', N'1934', N'Rua 36', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048056853', N'Heitor', N'Ribeiro', N'yahoo.com', N'44186309', N'Lorena', N'5121', N'Rua 809', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048139887', N'Luma', N'Gomes', N'gmail.com', N'10852117', N'Bacabal', N'1682', N'Rua 656', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048173812', N'Tatiana', N'Almeida', N'uol.com.br', N'36674760', N'Lavras', N'8406', N'Rua 902', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004827185', N'Ricardo', N'Lima', N'hotmail.com', N'18853821', N'Botucatu', N'9700', N'Rua 305', N'Apto. 15')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048290822', N'Zélia', N'Costa', N'gmail.com', N'44036370', N'Rio de Janeiro', N'5155', N'Rua 754', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048297640', N'Xavier', N'Castro', N'yahoo.com', N'67832856', N'Palmeira das Missões', N'4414', N'Rua 215', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048420011', N'Leonardo', N'Rodrigues', N'yahoo.com', N'74973824', N'Palmeira das Missões', N'8286', N'Rua 207', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048570312', N'Camila', N'Souza', N'hotmail.com', N'39838416', N'Palmeira das Missões', N'7460', N'Rua 66', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048639553', N'Francisco', N'Gomes', N'hotmail.com', N'71999218', N'Rio Largo', N'5696', N'Rua 507', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048665494', N'Danilo', N'Oliveira', N'gmail.com', N'30038417', N'Caratinga', N'3745', N'Rua 373', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048674173', N'Emanuela', N'Lima', N'outlook.com', N'87404658', N'Aracaju', N'9025', N'Rua 755', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004867753', N'Marcos', N'Pereira', N'yahoo.com', N'81647056', N'Nilópolis', N'555', N'Rua 27', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048829275', N'Ariane', N'Gomes', N'outlook.com', N'69138101', N'Picos', N'7223', N'Rua 862', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048929338', N'Fernanda', N'Oliveira', N'outlook.com', N'77727849', N'Palmas', N'8239', N'Rua 101', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10048959978', N'Stefany', N'Oliveira', N'outlook.com', N'92287792', N'Caraguatatuba', N'8397', N'Rua 183', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049169472', N'Otávio', N'Costa', N'gmail.com', N'81986024', N'Arapiraca', N'6901', N'Rua 343', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004923419', N'Taynara', N'Nascimento', N'outlook.com', N'29838494', N'Recife', N'3772', N'Rua 554', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049323020', N'Sara', N'Ribeiro', N'outlook.com', N'20141578', N'Leme', N'2531', N'Rua 32', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049364384', N'Rosana', N'Fernandes', N'outlook.com', N'88374964', N'Formiga', N'1606', N'Rua 223', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049440468', N'Matheus', N'Ribeiro', N'yahoo.com', N'69105676', N'Itapecerica da Serra', N'7478', N'Rua 27', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004945380', N'Gisele', N'Souza', N'yahoo.com', N'60348347', N'Itapecerica da Serra', N'5899', N'Rua 233', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004947671', N'Victor', N'Costa', N'hotmail.com', N'25487186', N'Palmeira das Missões', N'2446', N'Rua 721', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049493874', N'Yasmin', N'Lima', N'yahoo.com', N'19628166', N'São José dos Campos', N'8165', N'Rua 534', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004958474', N'Conceição', N'Almeida', N'gmail.com', N'35361735', N'Cachoeira do Sul', N'4469', N'Rua 690', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049780231', N'Bruna', N'Nascimento', N'gmail.com', N'78407300', N'Parnaíba', N'6997', N'Rua 62', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049882358', N'Laís', N'Almeida', N'gmail.com', N'72023482', N'Franca', N'2787', N'Rua 241', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1004992646', N'Carolina', N'Costa', N'uol.com.br', N'58737513', N'Brasília', N'307', N'Rua 525', N'Apto. 10')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10049946191', N'Geovana', N'Costa', N'hotmail.com', N'59088007', N'Santa Cruz do Sul', N'2776', N'Rua 917', N'Apto. 30')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050022786', N'Verônica', N'Souza', N'uol.com.br', N'68286135', N'Assis', N'8165', N'Rua 50', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050045883', N'Conceição', N'Pereira', N'outlook.com', N'53836833', N'Barretos', N'727', N'Rua 131', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050143370', N'Diego', N'Oliveira', N'yahoo.com', N'17106015', N'Itapetininga', N'6029', N'Rua 872', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050321322', N'Yuri', N'Fernandes', N'uol.com.br', N'18550635', N'Registro', N'6533', N'Rua 377', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050524620', N'Nelson', N'Souza', N'outlook.com', N'80344719', N'Blumenau', N'9382', N'Rua 597', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005054870', N'Melissa', N'Castro', N'hotmail.com', N'61335356', N'Fortaleza', N'5316', N'Rua 638', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050618092', N'Elisa', N'Santos', N'hotmail.com', N'31513378', N'Divinópolis', N'5652', N'Rua 362', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050643984', N'Uirá', N'Lima', N'gmail.com', N'88321892', N'Assis', N'9246', N'Rua 761', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050677566', N'Fabiano', N'Almeida', N'gmail.com', N'94197017', N'Campo Maior', N'7969', N'Rua 967', N'Apto. 31')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050713387', N'Conceição', N'Almeida', N'gmail.com', N'18650040', N'Bacabal', N'4290', N'Rua 679', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050740591', N'Paula', N'Ribeiro', N'gmail.com', N'34132282', N'Bacabal', N'4938', N'Rua 692', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005074284', N'Tábata', N'Rodrigues', N'outlook.com', N'32707247', N'Botucatu', N'2802', N'Rua 308', N'Apto. 34')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050784933', N'Geovana', N'Nascimento', N'yahoo.com', N'7507452', N'Sobral', N'8339', N'Rua 937', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050896411', N'Franciele', N'Silva', N'hotmail.com', N'57464019', N'Campo Maior', N'4551', N'Rua 831', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050924796', N'Gisele', N'Ribeiro', N'outlook.com', N'18074828', N'Teófilo Otoni', N'2639', N'Rua 238', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10050935358', N'Carlos', N'Fernandes', N'uol.com.br', N'77613497', N'Andradina', N'673', N'Rua 892', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005098437', N'Zélia', N'Souza', N'uol.com.br', N'68352742', N'Ourinhos', N'4685', N'Rua 170', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005110272', N'Noemi', N'Souza', N'gmail.com', N'78884970', N'Lençóis Paulista', N'8345', N'Rua 626', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005120582', N'Célia', N'Silva', N'uol.com.br', N'30361379', N'Sobral', N'6043', N'Rua 843', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005120595', N'Paula', N'Pereira', N'outlook.com', N'30865212', N'Teófilo Otoni', N'2081', N'Rua 338', N'Apto. 11')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10051339251', N'Francisco', N'Pereira', N'yahoo.com', N'14764406', N'Ipatinga', N'6314', N'Rua 75', N'Apto. 76')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10051454244', N'Sonia', N'Souza', N'outlook.com', N'29470937', N'Três Corações', N'3029', N'Rua 568', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10051456782', N'Fabiana', N'Carvalho', N'gmail.com', N'89732551', N'Lençóis Paulista', N'3856', N'Rua 63', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10051591', N'André', N'Fernandes', N'outlook.com', N'5843253', N'Leme', N'9214', N'Rua 631', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10051684932', N'Felipe', N'Ribeiro', N'yahoo.com', N'28556200', N'Itapecerica da Serra', N'2800', N'Rua 530', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10051857621', N'Diogo', N'Souza', N'uol.com.br', N'37440280', N'Sobral', N'1561', N'Rua 10', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005192754', N'Laís', N'Silva', N'gmail.com', N'6266756', N'Rio de Janeiro', N'3817', N'Rua 497', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052081851', N'Pietra', N'Carvalho', N'uol.com.br', N'39738992', N'Botucatu', N'9624', N'Rua 638', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052122124', N'Elaine', N'Carvalho', N'outlook.com', N'67188629', N'Passos', N'6604', N'Rua 69', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052127083', N'Beatriz', N'Gomes', N'hotmail.com', N'34286736', N'Viamão', N'2968', N'Rua 974', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052135886', N'Luciana', N'Santos', N'uol.com.br', N'19626156', N'Passo Fundo', N'124', N'Rua 769', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052184529', N'Pamela', N'Santos', N'outlook.com', N'31878306', N'Bacabal', N'5875', N'Rua 390', N'Apto. 44')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005221491', N'Higor', N'Fernandes', N'uol.com.br', N'21827109', N'Valença', N'7015', N'Rua 389', N'Apto. 20')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005240141', N'William', N'Costa', N'outlook.com', N'46798143', N'Manaus', N'6113', N'Rua 859', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052463955', N'Rebeca', N'Pereira', N'outlook.com', N'24611031', N'Ourinhos', N'6600', N'Rua 524', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005253231', N'Flávia', N'Gomes', N'uol.com.br', N'59522912', N'Viamão', N'3002', N'Rua 468', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052697697', N'Cláudio', N'Oliveira', N'hotmail.com', N'1846056', N'Três Rios', N'4830', N'Rua 842', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052784139', N'Camila', N'Souza', N'outlook.com', N'99365408', N'São Carlos', N'8769', N'Rua 166', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052839472', N'Mariana', N'Almeida', N'yahoo.com', N'91217903', N'Barretos', N'7341', N'Rua 439', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10052962591', N'Samuel', N'Carvalho', N'uol.com.br', N'86941752', N'Cascavel', N'6753', N'Rua 496', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10053061363', N'Carolina', N'Rodrigues', N'uol.com.br', N'18132216', N'Franca', N'2273', N'Rua 669', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100533490', N'Raquel', N'Souza', N'outlook.com', N'10271363', N'Três Rios', N'7855', N'Rua 790', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10053386475', N'Rafael', N'Castro', N'gmail.com', N'62116625', N'Chapecó', N'1487', N'Rua 334', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10053667636', N'Camila', N'Oliveira', N'uol.com.br', N'67610617', N'Eunápolis', N'5148', N'Rua 936', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10053682823', N'Beatriz', N'Carvalho', N'uol.com.br', N'17766025', N'Bacabal', N'6993', N'Rua 335', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005411768', N'Milena', N'Oliveira', N'gmail.com', N'68515388', N'Salvador', N'5497', N'Rua 38', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054128977', N'Alisson', N'Rodrigues', N'uol.com.br', N'4547680', N'Boa Vista', N'5108', N'Rua 585', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054197845', N'Patrícia', N'Ribeiro', N'outlook.com', N'6181067', N'Araranguá', N'943', N'Rua 464', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054251566', N'Márcia', N'Fernandes', N'uol.com.br', N'63488959', N'Crateús', N'2745', N'Rua 597', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005425726', N'Gerson', N'Souza', N'yahoo.com', N'16678935', N'Boa Vista', N'7113', N'Rua 555', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054371333', N'Joaquim', N'Pereira', N'uol.com.br', N'30585780', N'Camaquã', N'3964', N'Rua 63', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100544082', N'Mariana', N'Pereira', N'uol.com.br', N'67560849', N'Boa Vista', N'6005', N'Rua 171', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054470755', N'Karen', N'Castro', N'outlook.com', N'65964354', N'João Pessoa', N'7792', N'Rua 282', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054519457', N'Ismaelita', N'Gomes', N'yahoo.com', N'71149559', N'Barra Mansa', N'5869', N'Rua 241', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054625813', N'Paulo', N'Pereira', N'uol.com.br', N'58626166', N'São Paulo', N'4764', N'Rua 847', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054657235', N'Isabela', N'Nascimento', N'uol.com.br', N'28760760', N'Santa Luzia', N'1327', N'Rua 959', N'Apto. 85')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10054898636', N'Elisa', N'Lima', N'hotmail.com', N'78514676', N'Muriaé', N'6650', N'Rua 702', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055010152', N'Pamela', N'Oliveira', N'gmail.com', N'53951258', N'Salto', N'8589', N'Rua 85', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055076190', N'Raimunda', N'Pereira', N'gmail.com', N'82852334', N'Goiânia', N'3354', N'Rua 58', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005515668', N'Diego', N'Almeida', N'uol.com.br', N'96381884', N'Teixeira de Freitas', N'495', N'Rua 511', N'Apto. 71')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005524773', N'Lays', N'Rodrigues', N'outlook.com', N'80193119', N'João Pessoa', N'2771', N'Rua 169', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055254313', N'Cristina', N'Carvalho', N'yahoo.com', N'73982263', N'Lavras', N'650', N'Rua 490', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055512426', N'Cecília', N'Carvalho', N'outlook.com', N'13581263', N'Divinópolis', N'2088', N'Rua 347', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055517862', N'Valéria', N'Nascimento', N'gmail.com', N'87497627', N'Arapongas', N'1030', N'Rua 958', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055574060', N'Cecília', N'Gomes', N'uol.com.br', N'19817580', N'Sete Lagoas', N'6086', N'Rua 194', N'Apto. 85')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055662071', N'Karina', N'Almeida', N'hotmail.com', N'66927494', N'Palmas', N'1697', N'Rua 777', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055683948', N'Cecília', N'Gomes', N'hotmail.com', N'1428591', N'Cubatão', N'4383', N'Rua 660', N'Apto. 43')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055722754', N'Marcelo', N'Oliveira', N'gmail.com', N'52281053', N'Santa Luzia', N'5431', N'Rua 144', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005576241', N'Mariana', N'Lima', N'outlook.com', N'50157438', N'Belo Horizonte', N'7997', N'Rua 561', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055854287', N'Marcela', N'Nascimento', N'yahoo.com', N'79547810', N'Itapetininga', N'631', N'Rua 750', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100558995', N'Claudia', N'Almeida', N'uol.com.br', N'97475869', N'Marília', N'7970', N'Rua 157', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10055960322', N'Cássia', N'Silva', N'outlook.com', N'16525772', N'Lorena', N'4245', N'Rua 51', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056031481', N'Lays', N'Pereira', N'yahoo.com', N'73824867', N'Teixeira de Freitas', N'848', N'Rua 228', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005611785', N'Sabrina', N'Oliveira', N'gmail.com', N'17446891', N'Ipatinga', N'11', N'Rua 299', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056136186', N'Olga', N'Pereira', N'yahoo.com', N'39148982', N'Teófilo Otoni', N'8760', N'Rua 399', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056289928', N'Beatriz', N'Ribeiro', N'uol.com.br', N'96819569', N'Rio de Janeiro', N'1851', N'Rua 284', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056578587', N'Gisele', N'Almeida', N'hotmail.com', N'12425436', N'Itanhaém', N'7161', N'Rua 465', N'Apto. 43')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005670876', N'Zélia', N'Nascimento', N'gmail.com', N'19250727', N'Frederico Westphalen', N'7879', N'Rua 111', N'Apto. 2')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056756169', N'Felipe', N'Rodrigues', N'yahoo.com', N'84418123', N'Formiga', N'8701', N'Rua 950', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056818082', N'Ismael', N'Almeida', N'uol.com.br', N'41243952', N'Recife', N'1572', N'Rua 907', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056861259', N'Regina', N'Santos', N'uol.com.br', N'3179477', N'Manaus', N'379', N'Rua 718', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056943399', N'Júlia', N'Santos', N'uol.com.br', N'21144004', N'Passo Fundo', N'3640', N'Rua 681', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10056999077', N'Ingrid', N'Pereira', N'uol.com.br', N'67177339', N'Bragança Paulista', N'1429', N'Rua 757', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005703176', N'Bruna', N'Castro', N'uol.com.br', N'95451054', N'Três Rios', N'5874', N'Rua 778', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057167662', N'Emerson', N'Silva', N'yahoo.com', N'45547813', N'Caraguatatuba', N'3042', N'Rua 158', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057181719', N'Maria', N'Fernandes', N'outlook.com', N'26312760', N'Cubatão', N'5899', N'Rua 297', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057259171', N'Fernanda', N'Almeida', N'hotmail.com', N'94126993', N'Santa Maria', N'7775', N'Rua 988', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057290780', N'Samuel', N'Oliveira', N'yahoo.com', N'93328655', N'Cascavel', N'3306', N'Rua 264', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057296441', N'Lorena', N'Souza', N'outlook.com', N'1064413', N'Lages', N'7164', N'Rua 105', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057298148', N'Augusto', N'Santos', N'gmail.com', N'2811238', N'São Mateus', N'6911', N'Rua 392', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057365756', N'Uirá', N'Pereira', N'outlook.com', N'5086590', N'Marília', N'1504', N'Rua 154', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057442278', N'Daniel', N'Pereira', N'outlook.com', N'90282274', N'Camaquã', N'3516', N'Rua 787', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005744684', N'Taynara', N'Souza', N'hotmail.com', N'20972094', N'Tatuí', N'5758', N'Rua 728', N'Apto. 85')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057481138', N'Genival', N'Souza', N'hotmail.com', N'76398925', N'Fortaleza', N'684', N'Rua 368', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057575857', N'Wilson', N'Fernandes', N'yahoo.com', N'44265078', N'Lençóis Paulista', N'306', N'Rua 222', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057580278', N'Carla', N'Fernandes', N'yahoo.com', N'33997257', N'Valença', N'4645', N'Rua 744', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057610097', N'Bruna', N'Carvalho', N'hotmail.com', N'54751755', N'Pouso Alegre', N'1697', N'Rua 104', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057645950', N'Ester', N'Souza', N'hotmail.com', N'38119967', N'Rio de Janeiro', N'1259', N'Rua 167', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100576462', N'Fernão', N'Rodrigues', N'gmail.com', N'36346519', N'Ijuí', N'4986', N'Rua 260', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057798042', N'Fernanda', N'Castro', N'yahoo.com', N'19764490', N'Maringá', N'3653', N'Rua 973', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005781298', N'Natália', N'Nascimento', N'gmail.com', N'11336146', N'São Lourenço', N'8477', N'Rua 788', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057861813', N'Roberto', N'Lima', N'uol.com.br', N'63518652', N'Macapá', N'1559', N'Rua 725', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100578635', N'Óscar', N'Silva', N'hotmail.com', N'54632676', N'Guanambi', N'5214', N'Rua 913', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057947497', N'Cássia', N'Nascimento', N'hotmail.com', N'34001311', N'Aracaju', N'869', N'Rua 607', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10057992339', N'Isabela', N'Oliveira', N'hotmail.com', N'90650902', N'Picos', N'8545', N'Rua 88', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058114254', N'Guilherme', N'Carvalho', N'outlook.com', N'62862911', N'Macapá', N'7676', N'Rua 573', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005812363', N'Natalia', N'Carvalho', N'uol.com.br', N'85526070', N'Registro', N'2042', N'Rua 799', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058347152', N'Elisa', N'Ribeiro', N'uol.com.br', N'78591149', N'Araranguá', N'2648', N'Rua 561', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058372872', N'Kellen', N'Oliveira', N'uol.com.br', N'56544581', N'Cuiabá', N'5509', N'Rua 827', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058373724', N'Zélia', N'Nascimento', N'yahoo.com', N'90468130', N'Codó', N'7202', N'Rua 902', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005840562', N'Augusto', N'Fernandes', N'hotmail.com', N'11260973', N'Aracaju', N'7679', N'Rua 332', N'Apto. 2')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005847868', N'Gustavo', N'Carvalho', N'gmail.com', N'91511637', N'Teixeira de Freitas', N'2690', N'Rua 762', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058483391', N'Rebeca', N'Fernandes', N'uol.com.br', N'4927948', N'Araranguá', N'6713', N'Rua 958', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058520', N'Tainá', N'Lima', N'hotmail.com', N'46809921', N'Picos', N'3243', N'Rua 811', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058564813', N'Paula', N'Souza', N'yahoo.com', N'46440011', N'Arapongas', N'3084', N'Rua 209', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058691634', N'Augusto', N'Fernandes', N'yahoo.com', N'55259006', N'Vitória', N'1410', N'Rua 458', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005882168', N'Ágatha', N'Gomes', N'gmail.com', N'15117626', N'Santarém', N'9689', N'Rua 994', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058876956', N'Glauber', N'Nascimento', N'gmail.com', N'96688500', N'Palmas', N'7389', N'Rua 43', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005889368', N'Dandara', N'Lima', N'outlook.com', N'34016199', N'São Lourenço', N'441', N'Rua 882', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10058987871', N'Cláudio', N'Almeida', N'gmail.com', N'36630585', N'Teresópolis', N'1644', N'Rua 700', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059247692', N'José', N'Almeida', N'yahoo.com', N'24515180', N'Codó', N'3065', N'Rua 339', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059335580', N'Débora', N'Ribeiro', N'yahoo.com', N'32844489', N'Muriaé', N'1960', N'Rua 703', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059349525', N'Nathalia', N'Fernandes', N'gmail.com', N'88782116', N'São Roque', N'785', N'Rua 391', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059419190', N'Paola', N'Silva', N'hotmail.com', N'72778782', N'Palmas', N'5044', N'Rua 565', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059567516', N'Giovana', N'Oliveira', N'hotmail.com', N'77233540', N'Três Rios', N'311', N'Rua 9', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059647140', N'Jéssica', N'Castro', N'yahoo.com', N'93639914', N'Rio Largo', N'8777', N'Rua 585', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005969675', N'Rafael', N'Ribeiro', N'uol.com.br', N'97881395', N'Jacareí', N'642', N'Rua 698', N'Apto. 73')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1005976665', N'Valéria', N'Castro', N'hotmail.com', N'31674503', N'Itanhaém', N'380', N'Rua 798', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059837790', N'Stella', N'Rodrigues', N'outlook.com', N'37027780', N'Pindamonhangaba', N'983', N'Rua 248', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10059977598', N'Henrique', N'Rodrigues', N'uol.com.br', N'42213668', N'Bragança Paulista', N'1795', N'Rua 554', N'Apto. 32')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006003363', N'Lídia', N'Costa', N'outlook.com', N'92810723', N'São Roque', N'855', N'Rua 289', N'Apto. 52')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060076271', N'Ágatha', N'Ribeiro', N'gmail.com', N'71137495', N'Franca', N'7596', N'Rua 666', N'Apto. 32')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060141621', N'Carlos', N'Almeida', N'hotmail.com', N'75900106', N'Barbacena', N'4711', N'Rua 862', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060190394', N'Marcelo', N'Almeida', N'yahoo.com', N'22343377', N'Feira de Santana', N'2810', N'Rua 765', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060193918', N'Luiz', N'Nascimento', N'outlook.com', N'27555529', N'Crateús', N'8714', N'Rua 999', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006043080', N'Lívia', N'Almeida', N'gmail.com', N'44388162', N'Chapecó', N'2814', N'Rua 14', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060551698', N'Clara', N'Fernandes', N'yahoo.com', N'36473087', N'Leme', N'1434', N'Rua 345', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060631541', N'Heitor', N'Almeida', N'outlook.com', N'41432549', N'São Mateus', N'6225', N'Rua 844', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060692884', N'Yasmim', N'Castro', N'outlook.com', N'67940544', N'Guanambi', N'5318', N'Rua 440', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060697679', N'Sara', N'Almeida', N'yahoo.com', N'15351336', N'Sete Lagoas', N'4856', N'Rua 127', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060754981', N'Stefany', N'Fernandes', N'yahoo.com', N'93103332', N'Chapecó', N'1699', N'Rua 222', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060762730', N'Camila', N'Oliveira', N'uol.com.br', N'18606310', N'Campo Maior', N'9311', N'Rua 947', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060773417', N'Marisa', N'Silva', N'hotmail.com', N'39200597', N'São João da Boa Vista', N'5292', N'Rua 128', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060848673', N'Mariana', N'Santos', N'gmail.com', N'90036392', N'Leme', N'9644', N'Rua 553', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060861191', N'Fernanda', N'Carvalho', N'gmail.com', N'60399512', N'Palmeira das Missões', N'633', N'Rua 591', N'Apto. 73')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006089937', N'Higor', N'Ribeiro', N'hotmail.com', N'3404642', N'Teresópolis', N'1355', N'Rua 972', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060921922', N'Priscila', N'Rodrigues', N'gmail.com', N'39265996', N'Caraguatatuba', N'6979', N'Rua 656', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060947712', N'Wellington', N'Gomes', N'gmail.com', N'16474100', N'Lavras', N'7487', N'Rua 697', N'Apto. 11')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10060980933', N'Cláudio', N'Almeida', N'yahoo.com', N'94720690', N'Codó', N'3394', N'Rua 430', N'Apto. 76')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006111599', N'Everaldo', N'Souza', N'hotmail.com', N'73549589', N'Viamão', N'9351', N'Rua 918', N'Apto. 61')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061228914', N'Júlio', N'Pereira', N'yahoo.com', N'68514415', N'Tijucas', N'1604', N'Rua 387', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061381818', N'Regina', N'Santos', N'outlook.com', N'27944944', N'Itapetininga', N'6923', N'Rua 543', N'Apto. 88')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061446355', N'Ismael', N'Almeida', N'hotmail.com', N'51776649', N'Tijucas', N'7109', N'Rua 569', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006151529', N'Conceição', N'Oliveira', N'yahoo.com', N'74755547', N'Santa Luzia', N'4871', N'Rua 378', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061661', N'Miriam', N'Carvalho', N'uol.com.br', N'78190572', N'Três Corações', N'9782', N'Rua 670', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061824145', N'Pedro', N'Silva', N'outlook.com', N'88153031', N'Registro', N'3563', N'Rua 421', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061872618', N'Xavier', N'Carvalho', N'gmail.com', N'46661401', N'Palmas', N'8952', N'Rua 859', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061918027', N'Yuri', N'Almeida', N'gmail.com', N'67048036', N'Bauru', N'4037', N'Rua 521', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10061975313', N'Elisa', N'Almeida', N'uol.com.br', N'73745102', N'Cotia', N'1675', N'Rua 681', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10062116361', N'Leandro', N'Lima', N'yahoo.com', N'18136909', N'Imperatriz', N'1049', N'Rua 755', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10062136437', N'Wilson', N'Almeida', N'gmail.com', N'52415588', N'São João da Boa Vista', N'3759', N'Rua 682', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10062214983', N'Laís', N'Rodrigues', N'uol.com.br', N'35931508', N'Itajubá', N'4360', N'Rua 94', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006226062', N'Wálter', N'Rodrigues', N'hotmail.com', N'35376227', N'Aracaju', N'2459', N'Rua 265', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10062433082', N'Helena', N'Silva', N'gmail.com', N'95733104', N'Itapecerica da Serra', N'4469', N'Rua 492', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10062458665', N'Rosana', N'Silva', N'gmail.com', N'53952748', N'Camaquã', N'4551', N'Rua 145', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10062650521', N'Zélia', N'Rodrigues', N'yahoo.com', N'17755370', N'Guaratinguetá', N'4358', N'Rua 257', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10062652345', N'Isadora', N'Fernandes', N'hotmail.com', N'57413442', N'Três Corações', N'2169', N'Rua 400', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006286390', N'Augusto', N'Fernandes', N'yahoo.com', N'32223093', N'Ribeirão Pires', N'5508', N'Rua 259', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10063158630', N'Nelson', N'Ribeiro', N'yahoo.com', N'6636378', N'Belo Horizonte', N'2825', N'Rua 144', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10063320884', N'Eduardo', N'Nascimento', N'hotmail.com', N'95517505', N'São Paulo', N'1772', N'Rua 899', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10063437753', N'Débora', N'Pereira', N'hotmail.com', N'76195359', N'Picos', N'6133', N'Rua 628', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10063455849', N'Daniel', N'Castro', N'hotmail.com', N'25488653', N'Aracaju', N'8318', N'Rua 175', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10063714668', N'Priscila', N'Ribeiro', N'yahoo.com', N'1253182', N'Barra Bonita', N'2504', N'Rua 758', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10063778670', N'Roberto', N'Souza', N'yahoo.com', N'15570032', N'Lorena', N'9949', N'Rua 139', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10064263117', N'Lucas', N'Pereira', N'uol.com.br', N'74019532', N'Jacareí', N'9779', N'Rua 984', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006433026', N'Claudia', N'Almeida', N'hotmail.com', N'49407293', N'Barbacena', N'6367', N'Rua 894', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10064340361', N'Rodrigo', N'Almeida', N'yahoo.com', N'11652636', N'João Pessoa', N'4881', N'Rua 281', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006441924', N'Júlia', N'Gomes', N'hotmail.com', N'51524742', N'Tatuí', N'9125', N'Rua 355', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10064439777', N'Kelly', N'Souza', N'hotmail.com', N'79929180', N'Ijuí', N'6646', N'Rua 250', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006473050', N'Leandro', N'Lima', N'yahoo.com', N'97102882', N'Curitiba', N'5499', N'Rua 392', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10064833272', N'Stella', N'Oliveira', N'outlook.com', N'93804437', N'Teófilo Otoni', N'7101', N'Rua 245', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006494445', N'Sílvia', N'Pereira', N'yahoo.com', N'6359282', N'São Roque', N'4051', N'Rua 728', N'Apto. 18')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065138340', N'Sabrina', N'Fernandes', N'yahoo.com', N'97740623', N'São José dos Campos', N'7357', N'Rua 449', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065144067', N'Rodrigo', N'Pereira', N'uol.com.br', N'9107136', N'Bacabal', N'9314', N'Rua 326', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006515212', N'Fabrício', N'Nascimento', N'yahoo.com', N'63741677', N'Sete Lagoas', N'3971', N'Rua 899', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065199454', N'Elisa', N'Fernandes', N'yahoo.com', N'57499274', N'Araranguá', N'5618', N'Rua 818', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006521184', N'Érica', N'Nascimento', N'yahoo.com', N'84856210', N'Gaspar', N'1663', N'Rua 621', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065296532', N'Edilene', N'Souza', N'outlook.com', N'55490164', N'Teófilo Otoni', N'6364', N'Rua 875', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065393251', N'Olga', N'Castro', N'gmail.com', N'48954985', N'Itajubá', N'6500', N'Rua 414', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065417315', N'Carolina', N'Souza', N'outlook.com', N'92701489', N'Bauru', N'3763', N'Rua 616', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065555146', N'João', N'Santos', N'uol.com.br', N'62334781', N'Caraguatatuba', N'4416', N'Rua 201', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065753461', N'Otávio', N'Gomes', N'outlook.com', N'92108084', N'Barra Bonita', N'9313', N'Rua 923', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10065944246', N'Natália', N'Costa', N'uol.com.br', N'91765748', N'Teófilo Otoni', N'9492', N'Rua 791', N'Apto. 20')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066133078', N'Ágatha', N'Carvalho', N'hotmail.com', N'36374291', N'Ipatinga', N'6110', N'Rua 77', N'Apto. 10')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066149750', N'Tatiana', N'Rodrigues', N'uol.com.br', N'20468035', N'Recife', N'8818', N'Rua 136', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006617261', N'Maicon', N'Costa', N'gmail.com', N'42838286', N'João Pessoa', N'1140', N'Rua 370', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066216795', N'Óscar', N'Costa', N'outlook.com', N'45276560', N'Frederico Westphalen', N'7649', N'Rua 50', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006621948', N'Vanessa', N'Santos', N'yahoo.com', N'94033446', N'Cachoeira do Sul', N'3456', N'Rua 904', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066228961', N'Ester', N'Nascimento', N'outlook.com', N'33779833', N'Arapiraca', N'4646', N'Rua 373', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066276663', N'Danilo', N'Silva', N'gmail.com', N'57734267', N'Santa Luzia', N'5919', N'Rua 163', N'Apto. 67')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066335720', N'Diogo', N'Ribeiro', N'gmail.com', N'65187430', N'São José dos Campos', N'9007', N'Rua 393', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066578643', N'Paulo', N'Castro', N'outlook.com', N'67760027', N'Itapetininga', N'2996', N'Rua 5', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066655977', N'Cristina', N'Gomes', N'outlook.com', N'48590331', N'Ourinhos', N'7373', N'Rua 377', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066666965', N'Noemi', N'Gomes', N'uol.com.br', N'71686652', N'Maringá', N'4995', N'Rua 508', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006670675', N'Elisa', N'Almeida', N'outlook.com', N'24925482', N'Caruaru', N'4846', N'Rua 537', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066787158', N'Fabiana', N'Silva', N'gmail.com', N'64177681', N'Itapetininga', N'8597', N'Rua 569', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066915480', N'Ingrid', N'Pereira', N'hotmail.com', N'9957811', N'Assis', N'3206', N'Rua 448', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10066922410', N'Pedro', N'Almeida', N'hotmail.com', N'87886815', N'Andradina', N'8327', N'Rua 381', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067050597', N'Fabiana', N'Castro', N'hotmail.com', N'5364605', N'Lavras', N'3951', N'Rua 946', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067062154', N'David', N'Castro', N'hotmail.com', N'80353793', N'Três Corações', N'5693', N'Rua 954', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006719323', N'Heitor', N'Pereira', N'hotmail.com', N'35391534', N'Picos', N'3706', N'Rua 47', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067296099', N'Gabriela', N'Almeida', N'uol.com.br', N'79706428', N'Santarém', N'5327', N'Rua 664', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067337073', N'Fernão', N'Nascimento', N'hotmail.com', N'36087213', N'Criciúma', N'7395', N'Rua 902', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067373735', N'Jorge', N'Almeida', N'uol.com.br', N'77951886', N'Itanhaém', N'4700', N'Rua 959', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067383515', N'Eunice', N'Costa', N'uol.com.br', N'70042708', N'Itatiba', N'6916', N'Rua 777', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006740284', N'Karina', N'Nascimento', N'hotmail.com', N'54900315', N'Itatiba', N'6143', N'Rua 395', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006742815', N'Juliana', N'Almeida', N'uol.com.br', N'22773499', N'Cachoeira do Sul', N'3900', N'Rua 805', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006752601', N'Vanessa', N'Costa', N'yahoo.com', N'86400930', N'Barbacena', N'2707', N'Rua 170', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067590732', N'Manuela', N'Pereira', N'hotmail.com', N'51872141', N'Divinópolis', N'9207', N'Rua 589', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067649222', N'Matheus', N'Almeida', N'uol.com.br', N'55674402', N'Rio de Janeiro', N'3575', N'Rua 349', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10067726068', N'Mariana', N'Souza', N'uol.com.br', N'10793454', N'Palmeira das Missões', N'6947', N'Rua 998', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006784250', N'Taynara', N'Oliveira', N'gmail.com', N'10499373', N'Caruaru', N'213', N'Rua 764', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006787768', N'Paulo', N'Costa', N'yahoo.com', N'51554482', N'Barbacena', N'8127', N'Rua 773', N'Apto. 47')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100684211', N'Marisa', N'Pereira', N'outlook.com', N'6152726', N'Fortaleza', N'7540', N'Rua 190', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10068441915', N'Elaine', N'Rodrigues', N'yahoo.com', N'46937421', N'Passo Fundo', N'3420', N'Rua 692', N'Apto. 11')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10068444597', N'Sara', N'Castro', N'outlook.com', N'7754791', N'Jacareí', N'8044', N'Rua 35', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006848336', N'Conceição', N'Almeida', N'hotmail.com', N'32588009', N'Registro', N'5683', N'Rua 454', N'Apto. 52')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10068491082', N'Wellington', N'Pereira', N'yahoo.com', N'22156185', N'Botucatu', N'3782', N'Rua 880', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10068499955', N'Laís', N'Gomes', N'hotmail.com', N'77948374', N'Frederico Westphalen', N'648', N'Rua 555', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100686027', N'Elaine', N'Gomes', N'hotmail.com', N'90456067', N'Camaquã', N'8933', N'Rua 238', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10068643657', N'Luma', N'Castro', N'outlook.com', N'76217205', N'Sete Lagoas', N'3550', N'Rua 82', N'Apto. 10')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006873022', N'Marco', N'Costa', N'gmail.com', N'61981094', N'Araranguá', N'9174', N'Rua 65', N'Apto. 46')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10068741718', N'Rosana', N'Lima', N'outlook.com', N'58182423', N'Rio Largo', N'9170', N'Rua 809', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100687499', N'Jéssica', N'Nascimento', N'yahoo.com', N'96349914', N'Arapongas', N'2572', N'Rua 209', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006887148', N'Luan', N'Oliveira', N'yahoo.com', N'76413816', N'São Roque', N'270', N'Rua 324', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10068945357', N'Maurício', N'Pereira', N'outlook.com', N'43825829', N'Barra Mansa', N'2694', N'Rua 101', N'Apto. 20')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069059291', N'Camila', N'Pereira', N'uol.com.br', N'1896957', N'Ijuí', N'8503', N'Rua 378', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006909401', N'Márcio', N'Souza', N'hotmail.com', N'70536921', N'Tijucas', N'4460', N'Rua 993', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006911286', N'Sara', N'Carvalho', N'hotmail.com', N'54095196', N'Arapiraca', N'4541', N'Rua 826', N'Apto. 34')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006925989', N'Edna', N'Almeida', N'hotmail.com', N'27551874', N'Divinópolis', N'4093', N'Rua 867', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006931402', N'Marcela', N'Gomes', N'outlook.com', N'37250635', N'Recife', N'2714', N'Rua 56', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069336324', N'Leonardo', N'Pereira', N'hotmail.com', N'99276011', N'Penápolis', N'1056', N'Rua 419', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069337023', N'Eunice', N'Silva', N'outlook.com', N'58059202', N'Imperatriz', N'6117', N'Rua 959', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006939538', N'Claudia', N'Santos', N'yahoo.com', N'89332594', N'Palmeira das Missões', N'3466', N'Rua 181', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069470657', N'Érica', N'Souza', N'uol.com.br', N'9350648', N'Manaus', N'3704', N'Rua 990', N'Apto. 30')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006951593', N'Marcela', N'Nascimento', N'uol.com.br', N'74471837', N'Aracaju', N'9633', N'Rua 273', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069573399', N'Karina', N'Santos', N'gmail.com', N'65937305', N'Ijuí', N'9555', N'Rua 224', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069615640', N'Sofia', N'Costa', N'outlook.com', N'2863006', N'Divinópolis', N'4055', N'Rua 569', N'Apto. 81')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069780079', N'Rosana', N'Gomes', N'hotmail.com', N'89211341', N'Irecê', N'8285', N'Rua 329', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1006979913', N'Marisa', N'Nascimento', N'gmail.com', N'54634933', N'Itajubá', N'4246', N'Rua 399', N'Apto. 18')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069823331', N'Sofia', N'Gomes', N'uol.com.br', N'13278766', N'Macapá', N'1674', N'Rua 105', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069865119', N'Sonia', N'Silva', N'outlook.com', N'73708645', N'Formiga', N'5797', N'Rua 81', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10069997553', N'Aline', N'Silva', N'outlook.com', N'36096858', N'Juazeiro do Norte', N'5992', N'Rua 522', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070270445', N'Ôscar', N'Castro', N'gmail.com', N'67623303', N'Passo Fundo', N'5911', N'Rua 930', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070338629', N'Aníbal', N'Oliveira', N'yahoo.com', N'48070484', N'Rio de Janeiro', N'7258', N'Rua 963', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007039034', N'Leticia', N'Lima', N'hotmail.com', N'47624777', N'Andradina', N'3806', N'Rua 574', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070489268', N'Bruna', N'Santos', N'gmail.com', N'61369684', N'Ourinhos', N'2680', N'Rua 736', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007055269', N'Karen', N'Oliveira', N'uol.com.br', N'4853574', N'Registro', N'9112', N'Rua 922', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007059270', N'Julia', N'Ribeiro', N'hotmail.com', N'85011891', N'Itajubá', N'4607', N'Rua 585', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070710614', N'Lays', N'Carvalho', N'uol.com.br', N'45966517', N'Salvador', N'8445', N'Rua 997', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070745148', N'Giovana', N'Rodrigues', N'outlook.com', N'39854842', N'Salvador', N'3186', N'Rua 857', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070774977', N'Yasmim', N'Fernandes', N'uol.com.br', N'76766738', N'Pouso Alegre', N'2449', N'Rua 112', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070820058', N'Sofia', N'Souza', N'hotmail.com', N'7047703', N'São Carlos', N'8702', N'Rua 456', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070831990', N'Franciele', N'Rodrigues', N'yahoo.com', N'87793034', N'São José dos Campos', N'3071', N'Rua 285', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007083647', N'Eunice', N'Silva', N'outlook.com', N'73405004', N'Jacareí', N'808', N'Rua 110', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007084739', N'Juliana', N'Santos', N'yahoo.com', N'37760483', N'Itapecerica da Serra', N'2818', N'Rua 136', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070917730', N'Cássia', N'Fernandes', N'hotmail.com', N'15741778', N'Codó', N'7173', N'Rua 959', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10070956516', N'Solange', N'Silva', N'hotmail.com', N'33280394', N'São Paulo', N'6192', N'Rua 236', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10071048288', N'Alessandra', N'Silva', N'yahoo.com', N'92022755', N'Irecê', N'7877', N'Rua 275', N'Apto. 18')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007108941', N'Guilherme', N'Fernandes', N'uol.com.br', N'87441786', N'Nilópolis', N'7589', N'Rua 378', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007112726', N'Isabela', N'Rodrigues', N'gmail.com', N'43372926', N'Teixeira de Freitas', N'451', N'Rua 751', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10071241594', N'Pietra', N'Lima', N'outlook.com', N'62393390', N'Blumenau', N'8935', N'Rua 732', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10071352012', N'Larissa', N'Santos', N'uol.com.br', N'90550676', N'Lençóis Paulista', N'7500', N'Rua 776', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007140864', N'Henrique', N'Oliveira', N'gmail.com', N'47412210', N'Teófilo Otoni', N'3240', N'Rua 457', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007141156', N'Patrícia', N'Castro', N'yahoo.com', N'35224104', N'Lavras', N'3752', N'Rua 538', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10071426465', N'Lilian', N'Ribeiro', N'outlook.com', N'65487831', N'Lavras', N'1033', N'Rua 856', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10071911536', N'Fernanda', N'Nascimento', N'outlook.com', N'91025290', N'Ijuí', N'6621', N'Rua 145', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100719975', N'Paola', N'Silva', N'uol.com.br', N'20074129', N'Cotia', N'2641', N'Rua 339', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072041326', N'Raimunda', N'Lima', N'gmail.com', N'31931114', N'Vitória da Conquista', N'7181', N'Rua 617', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072145986', N'Aníbal', N'Gomes', N'gmail.com', N'65245149', N'Araranguá', N'9962', N'Rua 966', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072291795', N'Diego', N'Lima', N'gmail.com', N'89359402', N'Cachoeira do Sul', N'738', N'Rua 137', N'Apto. 83')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072345157', N'Wálter', N'Souza', N'uol.com.br', N'60156406', N'Belo Horizonte', N'7867', N'Rua 163', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072454027', N'Alessandra', N'Pereira', N'gmail.com', N'74009092', N'Araguaína', N'8004', N'Rua 247', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007247574', N'Ester', N'Oliveira', N'outlook.com', N'76212426', N'Guaratinguetá', N'4427', N'Rua 235', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072559184', N'Marisa', N'Carvalho', N'yahoo.com', N'47371698', N'Bragança Paulista', N'1136', N'Rua 792', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072624081', N'Tainá', N'Santos', N'uol.com.br', N'84983001', N'Bacabal', N'9004', N'Rua 269', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072777471', N'Ana', N'Ribeiro', N'uol.com.br', N'57662042', N'Divinópolis', N'6920', N'Rua 51', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007279750', N'Conceição', N'Silva', N'uol.com.br', N'63059673', N'Lorena', N'5000', N'Rua 713', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10072883181', N'Ingrid', N'Oliveira', N'gmail.com', N'23426787', N'Guaratinguetá', N'7969', N'Rua 37', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073032148', N'Sara', N'Silva', N'hotmail.com', N'83264009', N'Porto Alegre', N'630', N'Rua 674', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073034437', N'Rosana', N'Costa', N'gmail.com', N'6013724', N'Feira de Santana', N'1337', N'Rua 189', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007307296', N'Daniel', N'Gomes', N'gmail.com', N'28213324', N'Pouso Alegre', N'815', N'Rua 708', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073214792', N'Diego', N'Almeida', N'hotmail.com', N'50862528', N'Divinópolis', N'9343', N'Rua 95', N'Apto. 11')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007322045', N'Sofia', N'Oliveira', N'outlook.com', N'78232758', N'Rio de Janeiro', N'8584', N'Rua 689', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073221452', N'Henrique', N'Oliveira', N'yahoo.com', N'50793420', N'Imperatriz', N'2813', N'Rua 686', N'Apto. 2')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073376290', N'Elaine', N'Silva', N'outlook.com', N'16025522', N'Pouso Alegre', N'2546', N'Rua 643', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073484395', N'Helena', N'Souza', N'gmail.com', N'24067785', N'Aracaju', N'2856', N'Rua 756', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073521836', N'Joaquim', N'Gomes', N'yahoo.com', N'10240991', N'Tijucas', N'6321', N'Rua 671', N'Apto. 40')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073540639', N'Higor', N'Pereira', N'outlook.com', N'37900472', N'Santa Cruz do Sul', N'2971', N'Rua 700', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073550249', N'Allan', N'Oliveira', N'outlook.com', N'85472299', N'Arapiraca', N'6884', N'Rua 220', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073575870', N'Rafael', N'Rodrigues', N'uol.com.br', N'4213404', N'São Lourenço', N'7537', N'Rua 628', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073624239', N'Lívia', N'Ribeiro', N'gmail.com', N'55667093', N'Assis', N'4328', N'Rua 174', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073788788', N'Natália', N'Carvalho', N'uol.com.br', N'17082980', N'Frederico Westphalen', N'3859', N'Rua 171', N'Apto. 11')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007379481', N'Débora', N'Rodrigues', N'hotmail.com', N'15763635', N'Ipatinga', N'4631', N'Rua 458', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10073965244', N'Karen', N'Almeida', N'hotmail.com', N'75303719', N'Criciúma', N'8326', N'Rua 551', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074132453', N'Otávio', N'Costa', N'gmail.com', N'65966423', N'Passo Fundo', N'6071', N'Rua 389', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007413424', N'Nilson', N'Fernandes', N'gmail.com', N'71749941', N'São Luís', N'8239', N'Rua 582', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074135333', N'Luciana', N'Souza', N'gmail.com', N'91253422', N'Itanhaém', N'9467', N'Rua 301', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074225952', N'Augusto', N'Silva', N'hotmail.com', N'7813266', N'Salvador', N'2023', N'Rua 621', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074296793', N'Bárbara', N'Gomes', N'uol.com.br', N'35255774', N'Blumenau', N'475', N'Rua 52', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100743657', N'José', N'Castro', N'uol.com.br', N'55121027', N'João Pessoa', N'9300', N'Rua 98', N'Apto. 33')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074392646', N'Augusto', N'Souza', N'hotmail.com', N'43033954', N'Imperatriz', N'4089', N'Rua 824', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074441454', N'Felipe', N'Gomes', N'outlook.com', N'28139191', N'Jacareí', N'4182', N'Rua 449', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074485299', N'Sara', N'Pereira', N'outlook.com', N'85881292', N'Blumenau', N'3426', N'Rua 716', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074591124', N'Felipe', N'Lima', N'hotmail.com', N'27694052', N'Maringá', N'3001', N'Rua 221', N'Apto. 57')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007461932', N'Tábata', N'Gomes', N'uol.com.br', N'22156401', N'Irecê', N'4644', N'Rua 440', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074754416', N'Wilson', N'Almeida', N'gmail.com', N'30596451', N'Recife', N'6662', N'Rua 639', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074817555', N'Sofia', N'Nascimento', N'uol.com.br', N'9811295', N'Belo Horizonte', N'6937', N'Rua 686', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10074819772', N'Fabiana', N'Almeida', N'gmail.com', N'10147616', N'Divinópolis', N'2694', N'Rua 688', N'Apto. 59')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007495289', N'Karina', N'Silva', N'yahoo.com', N'73747576', N'Botucatu', N'1575', N'Rua 60', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007495660', N'Ágatha', N'Nascimento', N'uol.com.br', N'30536783', N'Teófilo Otoni', N'7908', N'Rua 81', N'Apto. 63')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10075357442', N'Janaína', N'Rodrigues', N'uol.com.br', N'94845996', N'Palmas', N'4793', N'Rua 50', N'Apto. 69')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10075391086', N'Verônica', N'Silva', N'outlook.com', N'69670498', N'Bragança Paulista', N'7555', N'Rua 738', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10075570394', N'Geraldo', N'Almeida', N'hotmail.com', N'28211660', N'Registro', N'4160', N'Rua 92', N'Apto. 31')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10075658736', N'Milena', N'Carvalho', N'outlook.com', N'47865943', N'Natal', N'8806', N'Rua 2', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10075814653', N'César', N'Souza', N'yahoo.com', N'87339013', N'Boa Vista', N'6353', N'Rua 602', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007585943', N'Fernanda', N'Gomes', N'outlook.com', N'89685019', N'São Luís', N'3661', N'Rua 290', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007623259', N'Ingrid', N'Carvalho', N'yahoo.com', N'89253266', N'Boa Vista', N'6043', N'Rua 374', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10076338194', N'Samuel', N'Silva', N'uol.com.br', N'99206345', N'Juazeiro do Norte', N'2297', N'Rua 877', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10076376783', N'Stefany', N'Gomes', N'uol.com.br', N'98710072', N'Santa Luzia', N'6509', N'Rua 741', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10076397862', N'Ôscar', N'Nascimento', N'outlook.com', N'12494001', N'Sete Lagoas', N'1519', N'Rua 650', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10076512262', N'Leticia', N'Rodrigues', N'gmail.com', N'43861060', N'Três Corações', N'3668', N'Rua 534', N'Apto. 25')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100766255', N'Amélia', N'Almeida', N'hotmail.com', N'55385054', N'Maringá', N'5781', N'Rua 328', N'Apto. 31')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10076734816', N'Débora', N'Nascimento', N'hotmail.com', N'38013592', N'Cascavel', N'5611', N'Rua 509', N'Apto. 65')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007681180', N'Maurício', N'Gomes', N'gmail.com', N'51047557', N'Belo Horizonte', N'9717', N'Rua 785', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007685995', N'Elisa', N'Souza', N'gmail.com', N'16337344', N'Salvador', N'272', N'Rua 480', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007699479', N'Luma', N'Oliveira', N'uol.com.br', N'78178497', N'Recife', N'1464', N'Rua 156', N'Apto. 43')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077081111', N'Lara', N'Gomes', N'yahoo.com', N'19860104', N'Franca', N'6243', N'Rua 832', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077085521', N'Érica', N'Carvalho', N'uol.com.br', N'54303268', N'Sete Lagoas', N'7119', N'Rua 439', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077134697', N'Débora', N'Carvalho', N'outlook.com', N'5128915', N'Aracaju', N'861', N'Rua 509', N'Apto. 37')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100771457', N'Melissa', N'Nascimento', N'hotmail.com', N'82095558', N'Teresópolis', N'5192', N'Rua 803', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077453423', N'Danilo', N'Silva', N'uol.com.br', N'34560723', N'São Roque', N'9299', N'Rua 849', N'Apto. 100')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077568085', N'Uirá', N'Costa', N'hotmail.com', N'24687623', N'Recife', N'3076', N'Rua 268', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077586959', N'Lorena', N'Gomes', N'yahoo.com', N'5647237', N'Três Corações', N'4873', N'Rua 442', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077771877', N'Eduardo', N'Rodrigues', N'outlook.com', N'79626263', N'Porto Alegre', N'4555', N'Rua 61', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077865081', N'Marco', N'Costa', N'uol.com.br', N'26184904', N'Caruaru', N'4297', N'Rua 205', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10077899090', N'Yasmin', N'Ribeiro', N'uol.com.br', N'6159790', N'Macapá', N'5804', N'Rua 687', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007797810', N'Luiz', N'Souza', N'yahoo.com', N'20105962', N'Frederico Westphalen', N'18', N'Rua 92', N'Apto. 3')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078189070', N'Rebeca', N'Gomes', N'outlook.com', N'32762060', N'Porto Alegre', N'2131', N'Rua 707', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078317055', N'Caio', N'Gomes', N'gmail.com', N'84997102', N'Itatiba', N'5429', N'Rua 957', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078341834', N'Xavier', N'Castro', N'outlook.com', N'21781350', N'São Paulo', N'3916', N'Rua 275', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078631773', N'Glauber', N'Castro', N'yahoo.com', N'15067648', N'Irecê', N'9710', N'Rua 67', N'Apto. 79')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078649783', N'Henrique', N'Ribeiro', N'yahoo.com', N'40335923', N'São João da Boa Vista', N'8187', N'Rua 793', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007870729', N'Geovana', N'Rodrigues', N'gmail.com', N'23916612', N'Salto', N'7953', N'Rua 311', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078779619', N'Marcela', N'Gomes', N'yahoo.com', N'4644721', N'Crateús', N'3406', N'Rua 534', N'Apto. 18')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078789943', N'Giovanna', N'Gomes', N'outlook.com', N'53945940', N'Fortaleza', N'7309', N'Rua 898', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078818236', N'Fabiano', N'Fernandes', N'yahoo.com', N'1745872', N'Barra Bonita', N'3951', N'Rua 842', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078930264', N'Christian', N'Gomes', N'hotmail.com', N'44393257', N'Eunápolis', N'3201', N'Rua 128', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078971988', N'Zélia', N'Nascimento', N'hotmail.com', N'32007401', N'Cuiabá', N'2438', N'Rua 288', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10078998616', N'Carolina', N'Oliveira', N'gmail.com', N'74715899', N'Maringá', N'6223', N'Rua 489', N'Apto. 90')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10079066511', N'Isadora', N'Santos', N'hotmail.com', N'48571470', N'Barbacena', N'1904', N'Rua 459', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007917870', N'Carolina', N'Nascimento', N'yahoo.com', N'22818829', N'Feira de Santana', N'5283', N'Rua 876', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007926335', N'Priscila', N'Lima', N'gmail.com', N'55420134', N'Registro', N'6146', N'Rua 953', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007927512', N'Marisa', N'Nascimento', N'gmail.com', N'53289904', N'Salto', N'2246', N'Rua 481', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007936496', N'Thiago', N'Ribeiro', N'gmail.com', N'59176798', N'Natal', N'8062', N'Rua 506', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10079381229', N'Thiago', N'Almeida', N'outlook.com', N'11000925', N'Itajubá', N'7122', N'Rua 853', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10079387366', N'Márcia', N'Oliveira', N'outlook.com', N'25150819', N'Aracaju', N'6510', N'Rua 471', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007958788', N'Leandro', N'Fernandes', N'gmail.com', N'93971542', N'Aracaju', N'5752', N'Rua 152', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10079681189', N'Lorena', N'Almeida', N'hotmail.com', N'78014286', N'Lorena', N'4390', N'Rua 99', N'Apto. 13')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007984852', N'Rafael', N'Silva', N'outlook.com', N'54922250', N'Frederico Westphalen', N'3913', N'Rua 723', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1007988944', N'Sofia', N'Santos', N'yahoo.com', N'98704178', N'Caraguatatuba', N'2922', N'Rua 550', N'Apto. 66')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10079990335', N'Cristina', N'Pereira', N'outlook.com', N'4954277', N'João Pessoa', N'2064', N'Rua 496', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10080025456', N'Catarina', N'Almeida', N'gmail.com', N'89504121', N'Itajubá', N'9816', N'Rua 487', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008004426', N'Lays', N'Castro', N'yahoo.com', N'53300872', N'Aparecida de Goiânia', N'6133', N'Rua 363', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008007964', N'Nilson', N'Santos', N'gmail.com', N'23954643', N'Bragança Paulista', N'129', N'Rua 488', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10080253718', N'Alessandra', N'Gomes', N'outlook.com', N'62507724', N'Guanambi', N'6432', N'Rua 77', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008043089', N'Silvio', N'Carvalho', N'uol.com.br', N'85796161', N'Barbacena', N'2785', N'Rua 202', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10080859796', N'Eunice', N'Pereira', N'outlook.com', N'93704545', N'Divinópolis', N'7391', N'Rua 12', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008102356', N'Thiago', N'Pereira', N'outlook.com', N'95852657', N'Passos', N'2849', N'Rua 938', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081030473', N'César', N'Carvalho', N'yahoo.com', N'21615587', N'Recife', N'633', N'Rua 11', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081116276', N'Franciele', N'Gomes', N'yahoo.com', N'81123390', N'Leme', N'5158', N'Rua 910', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008122871', N'Ismael', N'Oliveira', N'yahoo.com', N'2354717', N'Goiânia', N'186', N'Rua 332', N'Apto. 83')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081246847', N'William', N'Santos', N'outlook.com', N'27392392', N'Goiânia', N'5940', N'Rua 194', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081315127', N'Paula', N'Castro', N'gmail.com', N'45051671', N'Pindamonhangaba', N'7778', N'Rua 355', N'Apto. 74')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081441499', N'Katia', N'Oliveira', N'gmail.com', N'95014845', N'São Carlos', N'425', N'Rua 610', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081446553', N'César', N'Carvalho', N'hotmail.com', N'87001722', N'Natal', N'6718', N'Rua 85', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008146195', N'Wilson', N'Silva', N'gmail.com', N'77962936', N'Botucatu', N'8916', N'Rua 772', N'Apto. 88')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081488724', N'Sabrina', N'Silva', N'yahoo.com', N'68601724', N'Eunápolis', N'962', N'Rua 374', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008158957', N'Everaldo', N'Silva', N'yahoo.com', N'44624600', N'Barra Mansa', N'8900', N'Rua 628', N'Apto. 92')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10081686832', N'Rodrigo', N'Gomes', N'outlook.com', N'64868875', N'Codó', N'4340', N'Rua 658', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008168825', N'Ricardo', N'Rodrigues', N'hotmail.com', N'11516178', N'Porto Alegre', N'8855', N'Rua 590', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008178572', N'Xavier', N'Santos', N'uol.com.br', N'54196310', N'Pouso Alegre', N'9137', N'Rua 159', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008217820', N'Lucas', N'Rodrigues', N'hotmail.com', N'20005720', N'Lages', N'8908', N'Rua 82', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100823292', N'Cristina', N'Lima', N'outlook.com', N'60272497', N'Caratinga', N'2394', N'Rua 248', N'Apto. 82')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082392983', N'Leonardo', N'Carvalho', N'hotmail.com', N'46786156', N'Sete Lagoas', N'8148', N'Rua 472', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008241098', N'José', N'Costa', N'outlook.com', N'76604491', N'Santa Maria', N'3236', N'Rua 64', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082440212', N'Maicon', N'Almeida', N'hotmail.com', N'25365810', N'Irecê', N'6776', N'Rua 723', N'Apto. 71')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082493620', N'Mariana', N'Castro', N'yahoo.com', N'75705791', N'São José dos Campos', N'7179', N'Rua 173', N'Apto. 20')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082577112', N'Ricardo', N'Rodrigues', N'yahoo.com', N'74099037', N'Irecê', N'7910', N'Rua 739', N'Apto. 31')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082588119', N'Eduardo', N'Santos', N'hotmail.com', N'953639', N'Arapiraca', N'3914', N'Rua 40', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082668252', N'David', N'Silva', N'gmail.com', N'61806093', N'São Lourenço', N'8924', N'Rua 275', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082675834', N'Otília', N'Lima', N'uol.com.br', N'56498144', N'Itapecerica da Serra', N'9698', N'Rua 37', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10082817946', N'Everaldo', N'Fernandes', N'hotmail.com', N'56519767', N'Barretos', N'6218', N'Rua 797', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083120396', N'Guilherme', N'Pereira', N'yahoo.com', N'23744397', N'Sete Lagoas', N'8854', N'Rua 722', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083151974', N'Thiago', N'Pereira', N'yahoo.com', N'53085400', N'Cuiabá', N'3942', N'Rua 274', N'Apto. 9')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083176018', N'Carla', N'Castro', N'uol.com.br', N'31567359', N'Rio de Janeiro', N'1652', N'Rua 470', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083239046', N'Valéria', N'Castro', N'hotmail.com', N'54409889', N'Cascavel', N'3755', N'Rua 889', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008332645', N'Natália', N'Ribeiro', N'hotmail.com', N'83451875', N'Rio Largo', N'2359', N'Rua 992', N'Apto. 2')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083331513', N'Diego', N'Gomes', N'outlook.com', N'89774803', N'Três Rios', N'2923', N'Rua 296', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008337194', N'Uirá', N'Santos', N'yahoo.com', N'23963511', N'Porto Alegre', N'5615', N'Rua 927', N'Apto. 73')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083373977', N'Silvio', N'Nascimento', N'hotmail.com', N'44922526', N'Crateús', N'1017', N'Rua 415', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083422992', N'Thaís', N'Lima', N'yahoo.com', N'52917727', N'Santa Luzia', N'3016', N'Rua 312', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008347018', N'Sonia', N'Fernandes', N'gmail.com', N'57068505', N'Sete Lagoas', N'1939', N'Rua 693', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083638435', N'Fabrício', N'Nascimento', N'uol.com.br', N'86893521', N'Pouso Alegre', N'3761', N'Rua 81', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083733898', N'Yasmin', N'Carvalho', N'gmail.com', N'68756698', N'Três Rios', N'1076', N'Rua 711', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083811276', N'Taynara', N'Silva', N'hotmail.com', N'18558218', N'Passo Fundo', N'6874', N'Rua 868', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083866476', N'Fabrício', N'Carvalho', N'hotmail.com', N'7952513', N'Ribeirão Pires', N'9208', N'Rua 82', N'Apto. 56')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008387046', N'Uirá', N'Costa', N'outlook.com', N'4850599', N'Lages', N'7208', N'Rua 816', N'Apto. 15')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10083962227', N'Marina', N'Silva', N'gmail.com', N'48879763', N'Teixeira de Freitas', N'5506', N'Rua 98', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10084087928', N'Verônica', N'Pereira', N'gmail.com', N'97423286', N'Passos', N'7565', N'Rua 334', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10084234266', N'Thaís', N'Santos', N'outlook.com', N'1101658', N'Itanhaém', N'6195', N'Rua 660', N'Apto. 81')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10084374823', N'Marco', N'Almeida', N'gmail.com', N'35121663', N'Curitiba', N'3846', N'Rua 692', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10084499260', N'Joana', N'Gomes', N'hotmail.com', N'66652443', N'Rio Largo', N'1110', N'Rua 388', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008453542', N'Elaine', N'Silva', N'hotmail.com', N'30006702', N'Rio de Janeiro', N'6838', N'Rua 972', N'Apto. 83')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008505329', N'Felipe', N'Pereira', N'yahoo.com', N'56548434', N'Pouso Alegre', N'930', N'Rua 5', N'Apto. 75')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085135568', N'Miriam', N'Oliveira', N'uol.com.br', N'92850876', N'Lavras', N'1523', N'Rua 771', N'Apto. 18')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085269439', N'Katia', N'Costa', N'outlook.com', N'82322961', N'Santa Maria', N'5122', N'Rua 146', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008535758', N'Otília', N'Fernandes', N'outlook.com', N'33567323', N'Teófilo Otoni', N'4309', N'Rua 319', N'Apto. 41')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085485135', N'Maicon', N'Castro', N'hotmail.com', N'84906639', N'Ijuí', N'3450', N'Rua 653', N'Apto. 2')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085569570', N'Cristina', N'Ribeiro', N'uol.com.br', N'26876278', N'Teófilo Otoni', N'761', N'Rua 960', N'Apto. 52')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085570193', N'Márcio', N'Lima', N'uol.com.br', N'91338991', N'São João da Boa Vista', N'1866', N'Rua 614', N'Apto. 93')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085647542', N'Laís', N'Almeida', N'hotmail.com', N'90006249', N'Belo Horizonte', N'9030', N'Rua 615', N'Apto. 93')
GO
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085683995', N'Edilene', N'Oliveira', N'yahoo.com', N'9056980', N'João Pessoa', N'8621', N'Rua 846', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085698666', N'Wilson', N'Costa', N'uol.com.br', N'20054792', N'Santa Luzia', N'5267', N'Rua 378', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085714510', N'Laisa', N'Rodrigues', N'hotmail.com', N'30992761', N'Teófilo Otoni', N'2455', N'Rua 60', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085745121', N'Sofia', N'Nascimento', N'hotmail.com', N'23615801', N'Caraguatatuba', N'4287', N'Rua 984', N'Apto. 38')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10085986391', N'Heloísa', N'Souza', N'yahoo.com', N'5220011', N'Criciúma', N'5374', N'Rua 460', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10086114038', N'Diego', N'Nascimento', N'hotmail.com', N'77866565', N'São Paulo', N'3298', N'Rua 497', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10086195160', N'Vanessa', N'Costa', N'hotmail.com', N'85802304', N'Cuiabá', N'7365', N'Rua 842', N'Apto. 35')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008629094', N'Nelson', N'Nascimento', N'yahoo.com', N'72557970', N'Porto Alegre', N'1486', N'Rua 375', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008632268', N'Giovana', N'Carvalho', N'outlook.com', N'60412266', N'Teresópolis', N'1666', N'Rua 438', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10086378578', N'Edna', N'Almeida', N'gmail.com', N'61406825', N'Gaspar', N'1294', N'Rua 666', N'Apto. 52')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10086915761', N'Raquel', N'Carvalho', N'hotmail.com', N'4745730', N'Maringá', N'7585', N'Rua 241', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087269647', N'Ivan', N'Rodrigues', N'gmail.com', N'79300878', N'Gaspar', N'2560', N'Rua 386', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087280770', N'Antônio', N'Nascimento', N'gmail.com', N'24998714', N'Teresópolis', N'7878', N'Rua 468', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087328562', N'Beatriz', N'Rodrigues', N'uol.com.br', N'11378977', N'Fortaleza', N'9860', N'Rua 341', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087360465', N'Felipe', N'Souza', N'hotmail.com', N'49029817', N'Ipatinga', N'5935', N'Rua 446', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087555199', N'Manuela', N'Fernandes', N'uol.com.br', N'53439785', N'Arapiraca', N'1978', N'Rua 342', N'Apto. 12')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100875974', N'Eduardo', N'Carvalho', N'yahoo.com', N'25795019', N'São José dos Campos', N'4211', N'Rua 708', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100876518', N'Sandra', N'Gomes', N'gmail.com', N'33745692', N'Santa Luzia', N'8035', N'Rua 925', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100877468', N'Beatriz', N'Pereira', N'gmail.com', N'205223', N'Macapá', N'9202', N'Rua 748', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087860789', N'Mariana', N'Souza', N'uol.com.br', N'39782031', N'Frederico Westphalen', N'1842', N'Rua 642', N'Apto. 6')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087874945', N'Pietra', N'Castro', N'outlook.com', N'71416425', N'Tijucas', N'3707', N'Rua 521', N'Apto. 17')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087926394', N'Júlio', N'Rodrigues', N'hotmail.com', N'5766027', N'Blumenau', N'200', N'Rua 74', N'Apto. 58')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008795513', N'Amélia', N'Costa', N'hotmail.com', N'90117278', N'São Paulo', N'3303', N'Rua 440', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10087960195', N'Joana', N'Carvalho', N'yahoo.com', N'28371198', N'Cubatão', N'2535', N'Rua 986', N'Apto. 21')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088095844', N'Luis', N'Rodrigues', N'outlook.com', N'78227974', N'Franca', N'9442', N'Rua 539', N'Apto. 19')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088122972', N'Flávia', N'Pereira', N'yahoo.com', N'9503813', N'Passos', N'6578', N'Rua 608', N'Apto. 49')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088136176', N'Juliana', N'Silva', N'yahoo.com', N'72156515', N'Teixeira de Freitas', N'5103', N'Rua 176', N'Apto. 18')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008816425', N'Beatriz', N'Souza', N'hotmail.com', N'10763142', N'Araranguá', N'5656', N'Rua 116', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008831048', N'Vítor', N'Ribeiro', N'yahoo.com', N'668169', N'Arapiraca', N'1631', N'Rua 785', N'Apto. 95')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088319844', N'Amanda', N'Carvalho', N'uol.com.br', N'63848908', N'Rio de Janeiro', N'3047', N'Rua 986', N'Apto. 62')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088346259', N'Conceição', N'Fernandes', N'gmail.com', N'9321428', N'Campo Maior', N'6783', N'Rua 189', N'Apto. 23')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088420425', N'Gilberto', N'Santos', N'yahoo.com', N'32306828', N'Guaratinguetá', N'563', N'Rua 802', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088430317', N'Edna', N'Carvalho', N'yahoo.com', N'62294368', N'Leme', N'2708', N'Rua 367', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088433027', N'Mariana', N'Souza', N'uol.com.br', N'67214074', N'Teixeira de Freitas', N'8422', N'Rua 397', N'Apto. 72')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088556624', N'Taynara', N'Lima', N'yahoo.com', N'97696908', N'Brasília', N'2432', N'Rua 917', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088585690', N'Rafael', N'Nascimento', N'uol.com.br', N'23673559', N'Crateús', N'5399', N'Rua 335', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088594649', N'Ester', N'Oliveira', N'yahoo.com', N'15580720', N'Itapecerica da Serra', N'2713', N'Rua 904', N'Apto. 85')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088711544', N'Lídia', N'Fernandes', N'outlook.com', N'50712924', N'Cascavel', N'719', N'Rua 178', N'Apto. 99')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088734291', N'Otília', N'Castro', N'gmail.com', N'86326463', N'Palmeira das Missões', N'4735', N'Rua 412', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088859443', N'Rodrigo', N'Castro', N'gmail.com', N'6835910', N'Cascavel', N'1231', N'Rua 656', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088867127', N'Elaine', N'Lima', N'hotmail.com', N'71856387', N'Bacabal', N'4171', N'Rua 740', N'Apto. 68')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10088898346', N'Marcela', N'Silva', N'hotmail.com', N'45710401', N'Barretos', N'3621', N'Rua 797', N'Apto. 70')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008894597', N'Gabriel', N'Lima', N'gmail.com', N'76742929', N'Guarapari', N'7183', N'Rua 95', N'Apto. 29')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089126638', N'Thiago', N'Lima', N'hotmail.com', N'2639377', N'Cachoeira do Sul', N'9224', N'Rua 552', N'Apto. 80')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008916799', N'Vanessa', N'Lima', N'uol.com.br', N'48535449', N'Ijuí', N'7770', N'Rua 739', N'Apto. 94')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089210942', N'Juliana', N'Pereira', N'hotmail.com', N'72883361', N'Aparecida de Goiânia', N'3506', N'Rua 941', N'Apto. 8')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008934230', N'Aníbal', N'Carvalho', N'uol.com.br', N'93974176', N'Nilópolis', N'6294', N'Rua 816', N'Apto. 64')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089368912', N'Leandro', N'Oliveira', N'hotmail.com', N'28910684', N'Pouso Alegre', N'1232', N'Rua 464', N'Apto. 45')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089430090', N'Emerson', N'Santos', N'yahoo.com', N'84420926', N'Lavras', N'9920', N'Rua 542', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089532512', N'Luiza', N'Santos', N'outlook.com', N'66811690', N'Caraguatatuba', N'8321', N'Rua 901', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008962868', N'Isadora', N'Pereira', N'gmail.com', N'66141014', N'Manaus', N'4679', N'Rua 876', N'Apto. 36')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089683231', N'Sofia', N'Almeida', N'uol.com.br', N'45331825', N'Três Corações', N'8786', N'Rua 554', N'Apto. 86')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008981428', N'Mariana', N'Nascimento', N'outlook.com', N'44404821', N'Camaquã', N'9475', N'Rua 124', N'Apto. 53')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089831731', N'Samuel', N'Silva', N'yahoo.com', N'90324396', N'Palmas', N'2065', N'Rua 545', N'Apto. 15')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1008990752', N'Sabrina', N'Nascimento', N'outlook.com', N'63011852', N'Lorena', N'3647', N'Rua 908', N'Apto. 77')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100899461', N'Elisa', N'Nascimento', N'gmail.com', N'46720252', N'Criciúma', N'4440', N'Rua 641', N'Apto. 50')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10089960855', N'Ariane', N'Nascimento', N'hotmail.com', N'30084467', N'Assis', N'8008', N'Rua 142', N'Apto. 16')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090087794', N'Lara', N'Oliveira', N'uol.com.br', N'70630771', N'Três Corações', N'9993', N'Rua 257', N'Apto. 54')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090096267', N'Rafael', N'Nascimento', N'uol.com.br', N'1473180', N'Fortaleza', N'2805', N'Rua 995', N'Apto. 39')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090159989', N'Xavier', N'Gomes', N'yahoo.com', N'83660763', N'Muriaé', N'8202', N'Rua 126', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090188184', N'Milena', N'Ribeiro', N'outlook.com', N'21936798', N'Itatiba', N'5925', N'Rua 175', N'Apto. 20')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009023732', N'Wellington', N'Santos', N'uol.com.br', N'61335415', N'Rio Largo', N'5553', N'Rua 270', N'Apto. 26')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090269054', N'Danilo', N'Ribeiro', N'gmail.com', N'78605158', N'Arapongas', N'8705', N'Rua 474', N'Apto. 14')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090292871', N'Luiza', N'Carvalho', N'outlook.com', N'4263846', N'Muriaé', N'9373', N'Rua 494', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090326536', N'Bernardo', N'Oliveira', N'hotmail.com', N'86487725', N'Itatiba', N'10', N'Rua 378', N'Apto. 28')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090328578', N'Samuel', N'Lima', N'hotmail.com', N'92163591', N'Imperatriz', N'1420', N'Rua 152', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090390780', N'Ingrid', N'Almeida', N'outlook.com', N'78221174', N'Sete Lagoas', N'2230', N'Rua 839', N'Apto. 97')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090425151', N'Genival', N'Almeida', N'outlook.com', N'93273859', N'Barbacena', N'4044', N'Rua 528', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009043587', N'Julia', N'Costa', N'yahoo.com', N'73450141', N'Palmas', N'1420', N'Rua 990', N'Apto. 81')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090468374', N'Giovanna', N'Ribeiro', N'uol.com.br', N'59700862', N'Itatiba', N'5054', N'Rua 549', N'Apto. 42')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090477462', N'Carolina', N'Oliveira', N'gmail.com', N'42501395', N'Rio Largo', N'3103', N'Rua 945', N'Apto. 27')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009049459', N'Alessandra', N'Carvalho', N'uol.com.br', N'71512614', N'Palmas', N'8597', N'Rua 325', N'Apto. 98')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009049692', N'Amanda', N'Almeida', N'yahoo.com', N'40259628', N'Pouso Alegre', N'2900', N'Rua 575', N'Apto. 60')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100907333', N'Elizabete', N'Silva', N'hotmail.com', N'78669676', N'Sobral', N'6867', N'Rua 379', N'Apto. 7')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009077858', N'Bruna', N'Fernandes', N'yahoo.com', N'17569578', N'Jacareí', N'931', N'Rua 752', N'Apto. 61')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090818843', N'Bruna', N'Lima', N'hotmail.com', N'27468363', N'Porto Alegre', N'9931', N'Rua 651', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090827349', N'Felipe', N'Silva', N'hotmail.com', N'18259459', N'Salvador', N'1423', N'Rua 914', N'Apto. 84')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090843165', N'Wálter', N'Castro', N'hotmail.com', N'31594913', N'Cuiabá', N'1909', N'Rua 87', N'Apto. 22')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090911256', N'Heitor', N'Souza', N'gmail.com', N'77231113', N'São Carlos', N'601', N'Rua 358', N'Apto. 96')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090911736', N'Victor', N'Almeida', N'outlook.com', N'74874952', N'Campo Maior', N'2657', N'Rua 171', N'Apto. 1')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090934499', N'Gustavo', N'Costa', N'uol.com.br', N'47407585', N'Natal', N'4733', N'Rua 6', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10090939573', N'Fernanda', N'Oliveira', N'uol.com.br', N'35048492', N'Pindamonhangaba', N'1060', N'Rua 926', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'100909941', N'Genival', N'Santos', N'outlook.com', N'68470716', N'Araranguá', N'6747', N'Rua 500', N'Apto. 34')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091063562', N'Livia', N'Silva', N'gmail.com', N'54684289', N'Chapecó', N'1736', N'Rua 854', N'Apto. 55')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091124998', N'Natalia', N'Santos', N'yahoo.com', N'26700454', N'Codó', N'7217', N'Rua 285', N'Apto. 24')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091271084', N'Natália', N'Ribeiro', N'gmail.com', N'83421297', N'Cotia', N'3', N'Rua 630', N'Apto. 51')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091321277', N'Bruna', N'Silva', N'outlook.com', N'28539253', N'Fortaleza', N'4988', N'Rua 465', N'Apto. 71')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009138513', N'Ivan', N'Castro', N'yahoo.com', N'64764478', N'Cubatão', N'6605', N'Rua 43', N'Apto. 89')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091419253', N'Otília', N'Castro', N'hotmail.com', N'59695981', N'Lavras', N'5524', N'Rua 865', N'Apto. 91')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009144431', N'Ana', N'Pereira', N'outlook.com', N'66473949', N'São Roque', N'6884', N'Rua 883', N'Apto. 83')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091478178', N'Nelson', N'Carvalho', N'gmail.com', N'49600859', N'Vitória da Conquista', N'900', N'Rua 732', N'Apto. 5')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091510269', N'Célia', N'Fernandes', N'uol.com.br', N'24657324', N'Santa Cruz do Sul', N'1838', N'Rua 639', N'Apto. 61')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'1009154194', N'Gabriel', N'Gomes', N'yahoo.com', N'46940743', N'Formiga', N'6712', N'Rua 349', N'Apto. 48')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091554030', N'Priscila', N'Gomes', N'uol.com.br', N'70352295', N'Curitiba', N'5697', N'Rua 314', N'Apto. 31')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10091922747', N'Roberto', N'Silva', N'uol.com.br', N'26810199', N'Lençóis Paulista', N'6353', N'Rua 222', N'Apto. 87')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10092023515', N'Lídia', N'Carvalho', N'uol.com.br', N'49475798', N'Curitiba', N'482', N'Rua 844', N'Apto. 44')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10092031691', N'Lívia', N'Ribeiro', N'hotmail.com', N'16646410', N'Boa Vista', N'6968', N'Rua 724', N'Apto. 4')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10092038449', N'Danilo', N'Costa', N'uol.com.br', N'5907968', N'Jacareí', N'8166', N'Rua 540', N'Apto. 46')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10092218650', N'Ismael', N'Ribeiro', N'uol.com.br', N'99270224', N'Cubatão', N'7902', N'Rua 683', N'Apto. 78')
INSERT [dbo].[tb_cliente] ([cpf], [nome], [sobrenome], [email], [telefone], [cidade], [numero], [rua], [complemento]) VALUES (N'10092223', N'Danilo', N'Souza', N'outlook.com', N'86381049', N'Rio Largo', N'3154', N'Rua 382', N'Apto. 24')
GO
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'AC', N'Acre')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'AL', N'Alagoas')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'AM', N'Amazonas')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'AP', N'Amapá')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'BA', N'Bahia')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'CE', N'Ceará')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'DF', N'Distrito Federal')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'ES', N'Espírito Santo')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'GO', N'Goiás')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'MA', N'Maranhão')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'MG', N'Minas Gerais')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'MS', N'Mato Grosso do Sul')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'MT', N'Mato Grosso')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'PA', N'Pará')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'PB', N'Paraíba')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'PE', N'Pernambuco')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'PI', N'Piauí')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'PR', N'Paraná')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'RJ', N'Rio de Janeiro')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'RN', N'Rio Grande do Norte')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'RR', N'Roraima')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'RS', N'Rio Grande do Sul')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'SC', N'Santa Catarina')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'SE', N'Sergipe')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'SP', N'São Paulo')
INSERT [dbo].[tb_estado] ([sigla_estado], [nome_estado]) VALUES (N'TO', N'Tocantins')
GO
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'1', N'LOJA NUMERO 1', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'10', N'LOJA NUMERO 10', N'Goiânia')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'11', N'LOJA NUMERO 11', N'Belém')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'12', N'LOJA NUMERO 12', N'Manaus')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'13', N'LOJA NUMERO 13', N'São Luís')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'14', N'LOJA NUMERO 14', N'Natal')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'15', N'LOJA NUMERO 15', N'Campo Grande')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'16', N'LOJA NUMERO 16', N'Teresina')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'17', N'LOJA NUMERO 17', N'João Pessoa')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'18', N'LOJA NUMERO 18', N'Florianópolis')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'19', N'LOJA NUMERO 19', N'Maceió')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'2', N'LOJA NUMERO 2', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'20', N'LOJA NUMERO 20', N'Aracaju')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'21', N'LOJA NUMERO 21', N'Vitória')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'22', N'LOJA NUMERO 22', N'Cuiabá')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'23', N'LOJA NUMERO 23', N'Palmas')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'24', N'LOJA NUMERO 24', N'Porto Velho')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'25', N'LOJA NUMERO 25', N'Boa Vista')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'26', N'LOJA NUMERO 26', N'Rio Branco')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'27', N'LOJA NUMERO 27', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'28', N'LOJA NUMERO 28', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'29', N'LOJA NUMERO 29', N'Blumenau')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'3', N'LOJA NUMERO 3', N'Belo Horizonte')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'30', N'LOJA NUMERO 30', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'31', N'LOJA NUMERO 31', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'32', N'LOJA NUMERO 32', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'33', N'LOJA NUMERO 33', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'34', N'LOJA NUMERO 34', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'35', N'LOJA NUMERO 35', N'Caruaru')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'36', N'LOJA NUMERO 36', N'Parnaíba')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'37', N'LOJA NUMERO 37', N'São Paulo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'38', N'LOJA NUMERO 38', N'Teófilo Otoni')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'39', N'LOJA NUMERO 39', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'4', N'LOJA NUMERO 4', N'Porto Alegre')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'40', N'LOJA NUMERO 40', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'41', N'LOJA NUMERO 41', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'42', N'LOJA NUMERO 42', N'Passo Fundo')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'43', N'LOJA NUMERO 43', N'Imperatriz')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'44', N'LOJA NUMERO 44', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'45', N'LOJA NUMERO 45', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'46', N'LOJA NUMERO 46', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'47', N'LOJA NUMERO 47', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'48', N'LOJA NUMERO 48', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'49', N'LOJA NUMERO 49', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'5', N'LOJA NUMERO 5', N'Brasília')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'50', N'LOJA NUMERO 50', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'51', N'LOJA NUMERO 51', N'Rio de Janeiro')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'6', N'LOJA NUMERO 6', N'Salvador')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'7', N'LOJA NUMERO 7', N'Fortaleza')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'8', N'LOJA NUMERO 8', N'Curitiba')
INSERT [dbo].[tb_loja] ([codigo_loja], [nome_loja], [cidade]) VALUES (N'9', N'LOJA NUMERO 9', N'Recife')
GO
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'1', N'Abacate', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'10', N'Açúcar cristal', N'1')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'100', N'Caldo de legumes', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'101', N'Camarão', N'39')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'102', N'Canjica', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'103', N'Castanha de caju', N'19')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'104', N'Castanha de caju', N'20')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'105', N'Castanha do Pará', N'18')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'106', N'Castanha do Pará', N'19')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'107', N'Castanha-do-pará', N'19')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'108', N'Cebola', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'109', N'Cebola branca', N'13')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'11', N'Açúcar refinado', N'1')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'110', N'Cebola roxa', N'13')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'111', N'Cebola roxa', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'112', N'Cebolinha', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'113', N'Cebolinha', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'114', N'Cenoura', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'115', N'Cenoura', N'72')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'116', N'Cenoura', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'117', N'Cenoura baby', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'118', N'Cereal matinal', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'119', N'Cerveja', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'12', N'Adoçante', N'2')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'120', N'Cerveja artesanal', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'121', N'Cevada', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'122', N'Chá', N'6')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'123', N'Chá', N'9')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'124', N'Chá', N'24')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'125', N'Chá de camomila', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'126', N'Chá verde', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'127', N'Champagne', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'128', N'Champignon em conserva', N'26')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'129', N'Chia', N'74')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'13', N'Agrião', N'44')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'130', N'Chiclete', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'131', N'Chocolate', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'132', N'Chocolate', N'75')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'133', N'Chocolate amargo', N'25')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'134', N'Chocolate ao leite', N'25')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'135', N'Chocolate branco', N'25')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'136', N'Chocolate em barra', N'14')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'137', N'Chocolate em pó', N'14')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'138', N'Chocolate em pó', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'139', N'Chocolate meio amargo', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'14', N'Água com gás', N'4')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'140', N'Chuchu', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'141', N'Coco ralado', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'142', N'Coco ralado', N'38')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'143', N'Cogumelo shimeji', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'144', N'Couve', N'44')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'145', N'Couve', N'82')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'146', N'Couve-flor', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'147', N'Couve-flor', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'148', N'Coxa de frango', N'16')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'149', N'Cream cheese', N'71')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'15', N'Água mineral', N'3')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'150', N'Creme de leite', N'29')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'151', N'Creme de leite', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'152', N'Curry', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'153', N'Cuscuz', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'154', N'Damasco', N'38')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'155', N'Desinfetante', N'53')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'156', N'Detergente', N'53')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'157', N'Doce de leite', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'158', N'Endívia', N'82')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'159', N'Ervilha', N'22')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'16', N'Água mineral', N'4')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'160', N'Ervilha', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'161', N'Ervilha', N'41')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'162', N'Ervilha', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'163', N'Ervilha em conserva', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'164', N'Ervilha em conserva', N'49')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'165', N'Ervilha fresca', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'166', N'Escova de dente', N'43')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'167', N'Espinafre', N'44')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'168', N'Espinafre', N'82')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'169', N'Esponja de limpeza', N'53')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'17', N'Água mineral', N'6')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'170', N'Farinha de amêndoas', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'171', N'Farinha de arroz', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'172', N'Farinha de aveia', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'173', N'Farinha de banana verde', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'174', N'Farinha de batata doce', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'175', N'Farinha de mandioca', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'176', N'Farinha de milho', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'177', N'Farinha de trigo', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'178', N'Farofa pronta', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'179', N'Feijão', N'41')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'18', N'Água mineral', N'8')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'180', N'Feijão', N'49')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'181', N'Fermento', N'34')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'182', N'Fermento biológico', N'34')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'183', N'Fermento em pó', N'34')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'184', N'Fermento químico', N'34')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'185', N'Figo', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'186', N'Flocos de milho', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'187', N'Frango', N'16')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'188', N'Frango desfiado', N'17')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'189', N'Fubá', N'21')
GO
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'19', N'Água sanitária', N'53')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'190', N'Fubá', N'33')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'191', N'Gelatina', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'192', N'Gelatina', N'75')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'193', N'Geleia', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'194', N'Geléia', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'195', N'Geleia de morango', N'31')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'196', N'Gengibre', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'197', N'Gengibre', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'198', N'Gin', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'199', N'Goiaba', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'2', N'Abacaxi', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'20', N'Aguardente', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'200', N'Goiabada', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'201', N'Granola', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'202', N'Grão de bico', N'49')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'203', N'Grão de bico', N'50')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'204', N'Grão-de-bico', N'41')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'205', N'Guardanapo', N'67')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'206', N'Iogurte', N'45')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'207', N'Iogurte', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'208', N'Iogurte de frutas', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'209', N'Iogurte natural', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'21', N'Alcatra bovina', N'16')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'210', N'Jabuticaba', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'211', N'Jaca', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'212', N'Ketchup', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'213', N'Ketchup', N'57')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'214', N'Ketchup', N'58')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'215', N'Ketchup', N'59')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'216', N'Kiwi', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'217', N'Laranja', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'218', N'Lasanha', N'56')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'219', N'Leite', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'22', N'Álcool em gel', N'42')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'220', N'Leite condensado', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'221', N'Leite condensado', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'222', N'Leite condensado', N'51')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'223', N'Leite de amêndoas', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'224', N'Leite de amêndoas', N'51')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'225', N'Leite de amêndoas', N'52')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'226', N'Leite de arroz', N'52')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'227', N'Leite de aveia', N'52')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'228', N'Leite de coco', N'51')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'229', N'Leite de coco', N'52')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'23', N'Alecrim', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'230', N'Leite de soja', N'51')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'231', N'Leite de soja', N'52')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'232', N'Leite desnatado', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'233', N'Leite em pó', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'234', N'Leite em pó', N'51')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'235', N'Leite integral', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'236', N'Lentilha', N'22')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'237', N'Lentilha', N'41')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'238', N'Lentilha', N'49')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'239', N'Lentilha', N'50')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'24', N'Alface', N'44')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'240', N'Lichia', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'241', N'Licor', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'242', N'Limão', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'243', N'Linguiça', N'32')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'244', N'Lombo suíno', N'16')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'245', N'Luvas descartáveis', N'42')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'246', N'Maçã', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'247', N'Maçã verde', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'248', N'Macadâmia', N'18')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'249', N'Macarrão', N'56')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'25', N'Alface americana', N'35')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'250', N'Maionese', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'251', N'Maionese', N'57')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'252', N'Maionese', N'58')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'253', N'Mamão', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'254', N'Mandioca', N'81')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'255', N'Manga', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'256', N'Manjericão', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'257', N'Manteiga', N'29')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'258', N'Manteiga', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'259', N'Manteiga', N'54')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'26', N'Alface crespa', N'35')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'260', N'Manteiga', N'55')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'261', N'Maracujá', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'262', N'Margarina', N'55')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'263', N'Máscara facial', N'42')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'264', N'Mel', N'2')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'265', N'Mel', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'266', N'Melancia', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'267', N'Melão', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'268', N'Mexerica', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'269', N'Milho', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'27', N'Alho triturado', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'270', N'Milho', N'41')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'271', N'Milho de pipoca', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'272', N'Milho em conserva', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'273', N'Milho verde', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'274', N'Milho verde', N'40')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'275', N'Milho verde', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'276', N'Mirtilo', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'277', N'Molho de tomate', N'57')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'278', N'Molho de tomate', N'58')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'279', N'Molho de tomate', N'59')
GO
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'28', N'Alho-poró', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'280', N'Molho inglês', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'281', N'Molho inglês', N'58')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'282', N'Molho inglês', N'59')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'283', N'Molho shoyu', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'284', N'Molho shoyu', N'59')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'285', N'Morango', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'286', N'Mostarda', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'287', N'Mostarda', N'57')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'288', N'Mostarda', N'58')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'289', N'Mostarda', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'29', N'Alvejante', N'53')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'290', N'Nectarina', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'291', N'Noz', N'38')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'292', N'Nozes', N'18')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'293', N'Nozes', N'19')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'294', N'Noz-moscada', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'295', N'Óleo', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'296', N'Óleo de coco', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'297', N'Óleo de girassol', N'61')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'298', N'Óleo de milho', N'61')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'299', N'Óleo de soja', N'60')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'3', N'Abobrinha brasileira', N'47')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'30', N'Amaciante', N'53')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'300', N'Óleo de soja', N'61')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'301', N'Orégano', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'302', N'Ovos', N'62')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'303', N'Palmito', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'304', N'Palmito em conserva', N'65')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'305', N'Pão de centeio', N'66')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'306', N'Pão de forma', N'63')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'307', N'Pão de forma', N'66')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'308', N'Pão de queijo', N'63')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'309', N'Pão francês', N'63')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'31', N'Amaranto', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'310', N'Pão francês', N'66')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'311', N'Pão integral', N'63')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'312', N'Pão integral', N'64')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'313', N'Papel higiênico', N'67')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'314', N'Pasta de dente', N'43')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'315', N'Peito de peru', N'32')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'316', N'Peito de peru', N'36')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'317', N'Pepino', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'318', N'Pera', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'319', N'Pêssego', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'32', N'Amêndoa', N'18')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'320', N'Pimenta', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'321', N'Pimenta', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'322', N'Pimenta calabresa', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'323', N'Pimenta do reino', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'324', N'Pimentão', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'325', N'Pimentão amarelo', N'47')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'326', N'Pimentão vermelho', N'47')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'327', N'Pinhão', N'38')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'328', N'Pipoca', N'73')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'329', N'Pistache', N'38')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'33', N'Amendoim', N'19')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'330', N'Pitanga', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'331', N'Presunto', N'16')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'332', N'Presunto', N'32')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'333', N'Presunto', N'36')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'334', N'Pudim', N'75')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'335', N'Queijo', N'46')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'336', N'Queijo cheddar', N'71')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'337', N'Queijo coalho', N'71')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'338', N'Queijo minas', N'70')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'339', N'Queijo mussarela', N'71')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'34', N'Amendoim', N'49')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'340', N'Queijo parmesão', N'71')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'341', N'Queijo prato', N'70')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'342', N'Queijo prato', N'71')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'343', N'Quiabo', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'344', N'Rabanete', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'345', N'Refrigerante', N'6')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'346', N'Refrigerante', N'8')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'347', N'Requeijão', N'71')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'348', N'Romã', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'349', N'Rúcula', N'44')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'35', N'Amendoim salgado', N'73')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'350', N'Rúcula', N'82')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'351', N'Rum', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'352', N'Sabão em pó', N'53')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'353', N'Sabonete', N'43')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'354', N'Sal', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'355', N'Sal', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'356', N'Sal grosso', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'357', N'Salame', N'32')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'358', N'Salame', N'36')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'359', N'Salgadinho', N'73')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'36', N'Amendoim torrado', N'73')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'360', N'Salmão', N'69')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'361', N'Salsa', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'362', N'Salsão', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'363', N'Salsicha', N'16')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'364', N'Salsicha', N'17')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'365', N'Salsicha', N'32')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'366', N'Salsicha', N'36')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'367', N'Sardinha', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'368', N'Sardinha', N'69')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'369', N'Sardinha em lata', N'68')
GO
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'37', N'Amido de milho', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'370', N'Shampoo', N'43')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'371', N'Soja', N'50')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'372', N'Sopa instantânea', N'76')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'373', N'Sorvete', N'75')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'374', N'Suco de abacaxi', N'77')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'375', N'Suco de frutas', N'8')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'376', N'Suco de laranja', N'6')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'377', N'Suco de laranja', N'77')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'378', N'Suco de uva', N'6')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'379', N'Suco de uva', N'77')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'38', N'Amora', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'380', N'Tangerina', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'381', N'Tempero para carnes', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'382', N'Tequila', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'383', N'Tomate', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'384', N'Tomilho', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'385', N'Torrada', N'10')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'386', N'Torrada', N'63')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'387', N'Torta de chocolate', N'80')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'388', N'Torta de limão', N'80')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'389', N'Torta de morango', N'80')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'39', N'Aperitivo', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'390', N'Trigo', N'41')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'391', N'Uva', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'392', N'Vermute', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'393', N'Vinagre', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'394', N'Vinagre', N'78')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'395', N'Vinagre', N'84')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'396', N'Vinagre balsâmico', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'397', N'Vinho', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'398', N'Vinho tinto', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'399', N'Vinho tinto', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'4', N'Abobrinha italiana', N'47')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'40', N'Arroz', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'400', N'Vodka', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'401', N'Whisky', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'41', N'Arroz', N'23')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'42', N'Arroz', N'41')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'43', N'Arroz integral', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'44', N'Arroz integral', N'22')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'45', N'Atum', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'46', N'Atum', N'69')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'47', N'Atum em lata', N'68')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'48', N'Aveia', N'21')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'49', N'Avelã', N'19')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'5', N'Açaí', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'50', N'Avelã', N'38')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'51', N'Azeite', N'27')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'52', N'Azeite', N'61')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'53', N'Azeite de oliva', N'60')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'54', N'Azeite de oliva', N'79')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'55', N'Azeitona', N'28')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'56', N'Bacalhau', N'69')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'57', N'Bacon', N'32')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'58', N'Bala', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'59', N'Banana', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'6', N'Acerola', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'60', N'Barra de cereal', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'61', N'Batata', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'62', N'Batata baroa', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'63', N'Batata doce', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'64', N'Batata doce', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'65', N'Batata frita', N'73')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'66', N'Batata inglesa', N'81')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'67', N'Berinjela', N'48')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'68', N'Beterraba', N'72')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'69', N'Beterraba', N'83')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'7', N'Achocolatado', N'9')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'70', N'Biscoito', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'71', N'Biscoito cream cracker', N'10')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'72', N'Biscoito de chocolate', N'10')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'73', N'Biscoito de maizena', N'10')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'74', N'Biscoito de polvilho', N'10')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'75', N'Biscoito recheado', N'10')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'76', N'Bolacha', N'10')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'77', N'Bolacha cream cracker', N'11')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'78', N'Bolacha de aveia', N'64')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'79', N'Bolacha recheada', N'11')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'8', N'Achocolatado', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'80', N'Bolacha recheada', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'81', N'Bolo de cenoura', N'12')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'82', N'Bolo de chocolate', N'12')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'83', N'Bolo de chocolate', N'75')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'84', N'Bolo de milho', N'12')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'85', N'Bolo pronto', N'12')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'86', N'Brócolis', N'44')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'87', N'Brócolis', N'82')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'88', N'Cachaça', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'89', N'Cachaça', N'7')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'9', N'Açúcar', N'2')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'90', N'Café', N'9')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'91', N'Café', N'15')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'92', N'Café em grãos', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'93', N'Café em grãos', N'15')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'94', N'Café solúvel', N'5')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'95', N'Café solúvel', N'15')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'96', N'Caju', N'37')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'97', N'Cajuzinho', N'30')
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'98', N'Caldo de carne', N'78')
GO
INSERT [dbo].[tb_produto] ([codigo_produto], [produto], [codigo_classificacao]) VALUES (N'99', N'Caldo de frango', N'78')
GO
/****** Object:  StoredProcedure [dbo].[cargaBase]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cargaBase] (@ANO INT, @MES INT, @ANO_PROX INT, @MES_PROX INT)
AS
BEGIN
DECLARE cur_datas CURSOR FOR
SELECT DATEADD(DAY, number, DATEFROMPARTS(@ANO, @MES, 1)) AS Dia
FROM master..spt_values
WHERE type = 'P'
  AND DATEADD(DAY, number, DATEFROMPARTS(@ANO, @MES, 1)) < DATEFROMPARTS(@ANO_PROX, @MES_PROX, 1)

OPEN cur_datas

DECLARE @data DATE

FETCH NEXT FROM cur_datas INTO @data

WHILE @@FETCH_STATUS = 0
BEGIN
    exec [dbo].[IncluiNotasDia] @data
    
    FETCH NEXT FROM cur_datas INTO @data
END

CLOSE cur_datas
DEALLOCATE cur_datas

END
GO
/****** Object:  StoredProcedure [dbo].[cargaBase2]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cargaBase2] (@ANO INT, @MES INT, @DIA INT, @ANO_PROX INT, @MES_PROX INT, @DIA_PROX INT)
AS
BEGIN
DECLARE cur_datas CURSOR FOR
SELECT DATEADD(DAY, number, DATEFROMPARTS(@ANO, @MES, @DIA)) AS Dia
FROM master..spt_values
WHERE type = 'P'
  AND DATEADD(DAY, number, DATEFROMPARTS(@ANO, @MES, @DIA)) < DATEFROMPARTS(@ANO_PROX, @MES_PROX, @DIA_PROX)

OPEN cur_datas

DECLARE @data DATE

FETCH NEXT FROM cur_datas INTO @data

WHILE @@FETCH_STATUS = 0
BEGIN
    exec [dbo].[IncluiNotasDia] @data
    
    FETCH NEXT FROM cur_datas INTO @data
END

CLOSE cur_datas
DEALLOCATE cur_datas

END
GO
/****** Object:  StoredProcedure [dbo].[cargaBase3]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cargaBase3] (@ANO INT, @MES INT, @ANO_PROX INT, @MES_PROX INT, @MAX INT)
AS
BEGIN
DECLARE @CONTADOR INT
SET @CONTADOR = 1
WHILE @CONTADOR <= @MAX
BEGIN
   exec [dbo].[cargaBase2] @ANO, @MES, 6, @ANO_PROX, @MES, 11;
   exec [dbo].[cargaBase2] @ANO, @MES, 11, @ANO_PROX, @MES, 16;
   exec [dbo].[cargaBase2] @ANO, @MES, 16, @ANO_PROX, @MES, 21;
   exec [dbo].[cargaBase2] @ANO, @MES, 21, @ANO_PROX, @MES, 27;
   exec [dbo].[cargaBase2] @ANO, @MES, 27, @ANO_PROX, @MES_PROX, 1;
END
END
GO
/****** Object:  StoredProcedure [dbo].[gerar_cliente_aleatorio]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gerar_cliente_aleatorio] (@numeroCLI int)
AS
BEGIN

    DECLARE @contador INT;
    DECLARE @nomes varchar(max);
    DECLARE @sobrenomes varchar(max);
    DECLARE @emails varchar(max);
    DECLARE @cidades varchar(max);
    DECLARE @estados varchar(max);
    DECLARE @numero varchar(100);
    DECLARE @rua varchar(100);
    DECLARE @complemento varchar(100);
	DECLARE @cpf varchar(100);
	DECLARE @nome varchar(100), @sobrenome varchar(100), @email varchar(100), @telefone varchar(100), @cidade varchar(100)
    SET @nomes = 'Ana, Bruno, Carla, Diego, Eduardo, Fernanda, Gabriel, Heloísa, Isadora, João, Karina, Leonardo, Marcela, Natalia, Otávio, Paula, Rafael, Sara, Thiago, Vanessa, William, Alice, Bernardo, Camila, Danilo, Emanuela, Fabiana, Gustavo, Heitor, Isabela, Julia, Lucas, Mariana, Nathalia, Ôscar, Priscila, Rodrigo, Sofia, Taynara, Victor, Yasmim, Zélia, Ágatha, Bárbara, Caio, Dandara, Érica, Felipe, Giovana, Henrique, Ismael, Juliana, Luan, Manuela, Natália, Óscar, Pietra, Rafaela, Sabrina, Thaís, Valentina, Wálter, Xavier, Yasmin, Zara, Aline, Beatriz, Carlos, David, Eliane, Fabrício, Gisele, Higor, Ingrid, Joaquim, Kátia, Lívia, Márcio, Noemi, Otília, Paola, Rafaela, Samuel, Tábata, Uirá, Vanessa, Wellington, Xavier, Yuri, Zélia, Augusto, Bruna, Cesar, Daniel, Elisa, Fernão, Gabriel, Henrique, Isadora,Alessandra, Allan, Alisson, Amanda, Amélia, Anderson, André, Andrea, Aníbal, Antônio, Ariane, Augusto, Beatriz, Bruna, Bruno, Camila, Carlos, Carolina, Cássia, Catarina, Cecília, Célia, César, Christian, Clara, Claudia, Cláudio, Conceição, Cristina, Daniel, Danilo, Débora, Diego, Diogo, Edilene, Edna, Eduardo, Elaine, Elisa, Eliseu, Elizabete, Emerson, Érica, Ester, Eunice, Everaldo, Fabiana, Fabiano, Fabrício, Felipe, Fernanda, Flávia, Flávio, Franciele, Francisco, Gabriela, Genival, Geovana, Geraldo, Gerson, Gilberto, Giovanna, Gisele, Glauber, Guilherme, Gustavo, Helena, Henrique, Ingrid, Isabela, Ismael, Ismaelita, Ivan, Janaína, Jéssica, Joana, João, Jorge, José, Josiane, Júlia, Juliana, Júlio, Karen, Karina, Katia, Kelly, Kellen, Laís, Laisa, Lara, Larissa, Laura, Lays, Leandro, Leticia, Lídia, Lilian, Livia, Lorena, Lourdes, Luciana, Luis, Luiz, Luiza, Luma, Maicon, Marcela, Marcelo, Márcia, Marco, Marcos, Maria, Mariana, Marina, Marisa, Marta, Matheus, Maurício, Melissa, Milena, Miriam, Natália, Nelson, Nilson, Olga, Pamela, Patrícia, Paula, Paulo, Pedro, Priscila, Rafael, Raimunda, Raquel, Rebeca, Regina, Renata, Ricardo, Roberto, Rodrigo, Rosana, Sabrina, Samuel, Sandra, Sara, Sílvia, Silvio, Solange, Sonia, Stefany, Stella, Tainá, Tatiana, Thaís, Thiago, Valéria, Vanessa, Verônica, Vítor, Vivian, Wilson';
    SET @sobrenomes = 'Silva, Santos, Souza, Costa, Oliveira, Pereira, Carvalho, Rodrigues, Almeida, Lima, Gomes, Castro, Nascimento, Ribeiro, Fernandes';
    SET @emails = 'gmail.com, hotmail.com, yahoo.com, uol.com.br, outlook.com';
    SET @cidades = 'São Paulo, Rio de Janeiro, Belo Horizonte, Salvador, Brasília, Fortaleza, Recife, Curitiba, Manaus, Porto Alegre,Natal, Goiânia, Cuiabá, Vitória, São Luís, João Pessoa, Aracaju, Blumenau, Bauru, Palmas,Palmas, Boa Vista, Macapá, Santarém, Caruaru, Juazeiro do Norte, Sobral, Teresópolis, Teófilo Otoni, Teixeira de Freitas, São Mateus, Sete Lagoas, Lavras, Ipatinga, Pouso Alegre, Guaratinguetá, Lorena, Ribeirão Pires, Cubatão, Itanhaém,Maringá, Cascavel, Passo Fundo, Lages, São José dos Campos, Marília, Franca, São Carlos, Barretos, Caraguatatuba, Assis, Ourinhos, Botucatu, Registro, Itapecerica da Serra, Jacareí, São Roque, Cotia, Itatiba, Bragança Paulista,Feira de Santana, Vitória da Conquista, Imperatriz, Parnaíba, Picos, Araguaína, Pindamonhangaba, Botucatu, Penápolis, Salto, Lençóis Paulista, Guarapari, Teófilo Otoni, Santa Cruz do Sul, Cachoeira do Sul, Santa Maria, Palmeira das Missões, Lages, Arapongas, Tatuí, Leme, Barra Bonita, Andradina, Valença, São João da Boa Vista, Itapetininga, São Lourenço, Itajubá, Camaquã, Viamão,Aparecida de Goiânia, Divinópolis, Formiga, Arapiraca, Rio Largo, Eunápolis, Irecê, Guanambi, Campo Maior, Crateús, Codó, Bacabal, Santa Luzia, Sete Lagoas, Muriaé, Três Corações, Ijuí, Frederico Westphalen, Chapecó, Tijucas, Criciúma, Araranguá, Gaspar, Pouso Alegre, Passos, Barbacena, Caratinga, Barra Mansa, Três Rios, Nilópolis';
    
	
SET @CONTADOR = 1
WHILE @CONTADOR <= @numeroCLI
BEGIN

SELECT TOP 1 @nome = value
FROM (
    SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rownum
    FROM STRING_SPLIT(@nomes, ',')
) AS names
WHERE rownum = CEILING(RAND() * (SELECT COUNT(*) FROM STRING_SPLIT(@nomes, ',')))
	
	SELECT TOP 1 @sobrenome = value
FROM (
    SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rownum
    FROM STRING_SPLIT(@sobrenomes, ',')
) AS sobrenames
WHERE rownum = CEILING(RAND() * (SELECT COUNT(*) FROM STRING_SPLIT(@sobrenomes, ',')))

SELECT TOP 1 @email = value
FROM (
    SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rownum
    FROM STRING_SPLIT(@emails, ',')
) AS emails
WHERE rownum = CEILING(RAND() * (SELECT COUNT(*) FROM STRING_SPLIT(@emails, ',')))

SELECT TOP 1 @cidade = value
FROM (
    SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rownum
    FROM STRING_SPLIT(@cidades, ',')
) AS cidades
WHERE rownum = CEILING(RAND() * (SELECT COUNT(*) FROM STRING_SPLIT(@cidades, ',')))
	
SET @telefone = CAST(RAND(ABS(CHECKSUM(NEWID()))) * 100000000 AS BIGINT);

SET @numero = FLOOR(RAND() * 10000) + 1;
SET @rua = CONCAT('Rua ', FLOOR(RAND() * 1000) + 1);
SET @complemento = CONCAT('Apto. ', FLOOR(RAND() * 100) + 1);
SET @cpf = CONCAT(
    CONVERT(NVARCHAR(3), ABS(CHECKSUM(NEWID())) % 900 + 100),
    CONVERT(NVARCHAR(3), ABS(CHECKSUM(NEWID())) % 1000),
    CONVERT(NVARCHAR(3), ABS(CHECKSUM(NEWID())) % 1000),
    CONVERT(NVARCHAR(2), ABS(CHECKSUM(NEWID())) % 100)
);


    INSERT INTO tb_cliente 
	(cpf, nome, sobrenome, email, telefone, cidade, numero, rua, complemento) VALUES (
	@cpf, @nome, @sobrenome, @email, @telefone, @cidade, @numero, @rua, @complemento);
	SET @CONTADOR = @CONTADOR + 1;
END;
END;
GO
/****** Object:  StoredProcedure [dbo].[IncluiNotaFiscal]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IncluiNotaFiscal] (@DATA DATE)
AS
BEGIN
DECLARE @CLIENTE VARCHAR(20)
DECLARE @LOJA VARCHAR(20)
DECLARE @PRODUTO VARCHAR(20)
DECLARE @NUMERO INT
DECLARE @NUM_ITENS INT
DECLARE @CONTADOR INT
DECLARE @QUANTIDADE INT
DECLARE @PRECO FLOAT
DECLARE @LISTAPRODUTOS TABLE (PRODUTO VARCHAR(20))
DECLARE @CONTADOR_PRODUTO INT
BEGIN TRY
   SET @CLIENTE = [dbo].[BuscarClienteAleatorio]()
END TRY
BEGIN CATCH
   SET @CLIENTE = '6203236194'
END CATCH
BEGIN TRY
 SET @LOJA = [dbo].[BuscarLojaAleatorio](@CLIENTE)
END TRY
BEGIN CATCH
  SET @LOJA = '1'
END CATCH
SELECT @NUMERO = COUNT(*) + 1 FROM tb_nota
SET @NUM_ITENS = [dbo].[NumeroAleatorio](20,50)
SET @CONTADOR = 1
SET NOCOUNT ON
INSERT INTO [dbo].[tb_nota] (cpf, codigo_loja, data, numero)
VALUES (@CLIENTE, @LOJA, @DATA, @NUMERO)
WHILE @CONTADOR <= @NUM_ITENS
BEGIN
    BEGIN TRY
	    SET @PRODUTO = [dbo].[BuscarProdutoAleatorio]()
	END TRY
	BEGIN CATCH
	   SET @PRODUTO = '1'
	END CATCH
	SELECT @CONTADOR_PRODUTO = COUNT(*) FROM @LISTAPRODUTOS WHERE PRODUTO = @PRODUTO
	IF @CONTADOR_PRODUTO = 0
	BEGIN
	   SET @QUANTIDADE = [dbo].[NumeroAleatorio](5,10)
	   SELECT @PRECO = [dbo].[NumeroAleatorio](1,5)
	   INSERT INTO [tb_item] (numero, [codigo_produto], quantidade, [preco])
	   VALUES (@NUMERO, @PRODUTO, @QUANTIDADE, @PRECO)
	   SET @CONTADOR = @CONTADOR + 1
	END
	INSERT INTO @LISTAPRODUTOS (PRODUTO) VALUES (@PRODUTO)
END

END
GO
/****** Object:  StoredProcedure [dbo].[IncluiNotasDia]    Script Date: 07/05/2023 00:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IncluiNotasDia] (@DATA DATE)
AS
BEGIN
DECLARE @NUM_NOTAS INT
DECLARE @CONTADOR INT
SET @NUM_NOTAS = [dbo].[NumeroAleatorio](50,150)
SET @CONTADOR = 1
WHILE @CONTADOR <= @NUM_NOTAS
BEGIN
    EXEC [dbo].[IncluiNotaFiscal] @DATA
    SET @CONTADOR = @CONTADOR + 1
END

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_ALEATORIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_ALEATORIO'
GO
