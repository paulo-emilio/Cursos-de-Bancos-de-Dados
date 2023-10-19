-- TABELAS TEMPOR�RIAS

-- Nome da tabela come�a com:
-- #  -> valem para a conex�o vigente
-- ## -> valem para v�rias conex�es
-- @  -> procedimento sendo executado

-- #
CREATE TABLE #TABELA01 (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO #TABELA01 VALUES ('1', 'LOKI');
SELECT * FROM #TABELA01; 
--Se abrirmos outra Query e executarmos "SELECT * FROM #TABELA01" ela n�o existir� l�

-- ##
CREATE TABLE ##TABELA02 (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO ##TABELA02 VALUES ('1', 'LOKI');
SELECT * FROM ##TABELA02; 
-- Se abrirmos outra Query e executarmos "SELECT * FROM ##TABELA02" ser� executado com �xito
-- e nesse caso a tabela s� deixa de existir quando o servidor � derrubado

--@
DECLARE @NUMERO_INICIAL_SEQUENCIA INT, @NUMERO_FINAL_SEQUENCIA INT;
DECLARE @TESTE_NOTA_FISCAL INT;
DECLARE @TABELA_DE_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR(20));
CREATE TABLE #TABELA_DE_NUMEROS ([NUMERO] INT, [STATUS] VARCHAR(20));

SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;

WHILE @NUMERO_INICIAL_SEQUENCIA <= @NUMERO_FINAL_SEQUENCIA
BEGIN
        SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM NOTAS_FISCAIS WHERE 
        NUMERO = @NUMERO_INICIAL_SEQUENCIA;
        IF @TESTE_NOTA_FISCAL = 1
                    BEGIN
             INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, '� NOTA FISCAL');
                         INSERT INTO #TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, '� NOTA FISCAL');
                    END;
        ELSE
                BEGIN
             INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'N�O � NOTA FISCAL');
                         INSERT INTO #TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'N�O � NOTA FISCAL');
                END;
        SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1;
END;

SELECT * FROM @TABELA_DE_NUMEROS;
--funciona somente se todo o script for executado

SELECT * FROM #TABELA_DE_NUMEROS;