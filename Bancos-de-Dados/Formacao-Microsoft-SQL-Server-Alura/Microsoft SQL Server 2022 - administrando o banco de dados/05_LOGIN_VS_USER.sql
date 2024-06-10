--LOGIN
CREATE LOGIN jorge WITH PASSWORD = 'jorge@123';

--USER
CREATE USER jorge FOR LOGIN jorge;

--LOGIN VS USU�RIO
--No SQL Server, "LOGIN" refere-se � entidade de autentica��o no n�vel do servidor, que permite a entrada ao banco de dados. 
--Pode ser uma conta do Windows ou espec�fica do SQL Server. "USU�RIO" est� relacionado a um banco de dados espec�fico e 
--define permiss�es dentro desse banco. Um LOGIN pode ser associado a v�rios USU�RIOS em diferentes bancos de dados. 
--A autentica��o do Windows vincula o LOGIN a uma conta de usu�rio do Windows, enquanto a autentica��o do SQL Server 
--cria credenciais independentes. LOGIN controla o acesso ao servidor, enquanto USU�RIO controla o acesso e permiss�es 
--dentro de um banco de dados. Em resumo, LOGIN � para autentica��o de servidor, enquanto USU�RIO � para autoriza��o e 
--controle de acesso em um banco de dados.