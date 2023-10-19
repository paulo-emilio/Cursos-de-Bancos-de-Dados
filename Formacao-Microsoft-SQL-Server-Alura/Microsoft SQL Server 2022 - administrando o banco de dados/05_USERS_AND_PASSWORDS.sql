CREATE LOGIN loki WITH PASSWORD = 'loki@123';

--USUARIO WINDOWS

CREATE LOGIN [DESKTOP-XXXXX\poliveira] FROM WINDOWS;


--logins e senhas
SELECT * FROM MASTER.SYS.sql_logins;

SELECT name, LOGINPROPERTY(name, 'PasswordLastSetTime') FROM MASTER.SYS.sql_logins;

SELECT name, password_hash  FROM MASTER.SYS.sql_logins;

CREATE LOGIN pedro WITH PASSWORD = 'pedro';

SELECT name FROM MASTER.SYS.sql_logins
WHERE PWDCOMPARE(name, password_hash) = 1;

CREATE LOGIN joao WITH PASSWORD = 'joao123';

SELECT name FROM MASTER.SYS.sql_logins
WHERE PWDCOMPARE(name + '123', password_hash) = 1;


--Dar permiss�es a usu�rios

ALTER SERVER ROLE [dbcreator] ADD MEMBER [loki];

--Remover autoriza��o

ALTER SERVER ROLE [dbcreator] DROP MEMBER [marcos];

--Lista de regras do SQL Server

SELECT * FROM sys.server_principals WHERE is_fixed_role = 1;

--Regra sysadmin: usu�rios com controle total sobre o servidor e de todos os objetos do banco de dados. Por exemplo, o usu�rio sa � sysadmin;
--Regra securityadmin: usu�rios com poder de gerenciar as fun��es de servidor de logins e de permiss�es. Desse modo, pode criar usu�rio e dar permiss�es a esses usu�rios;
--Regra serveradmin: usu�rios com poder de gerenciar as configura��es a n�vel de servidor e tamb�m gerenciar o servidor como um todo.
--Regra setupadmin: usu�rios com poder de gerenciar as instala��es de SQL Servers;
--Regra processadmin: usu�rios com poder de gerenciar de processos que s�o executados dentro do servidor do SQL Server;
--Regra diskadmin: usu�rios com poder de gerenciar os discos associados as bases de dados do SQL Server;
--Regra dbcreator: usu�rios com poder de criar, alterar, excluir e restaurar banco de dados;
--Regra bulkadmin: usu�rios com poder de executar opera��es de importa��o e exporta��o de dados em massa, usando uma fun��o interna do SQL Server chamada BULK INSERT.
