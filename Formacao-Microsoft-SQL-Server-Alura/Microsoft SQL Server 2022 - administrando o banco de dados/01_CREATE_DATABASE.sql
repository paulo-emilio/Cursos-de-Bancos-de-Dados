CREATE DATABASE [dbVendas]
 ON  PRIMARY ( 
 NAME = N'dbVendas', 
 FILENAME = N'C:\SQLServer22\ARQUIVOS_DADOS\dbVendas.MDF', 
 SIZE = 100MB, 
 MAXSIZE = 200MB, 
 FILEGROWTH = 50MB )
 LOG ON ( 
 NAME = N'dbVendasLOG', 
 FILENAME = N'C:\SQLServer22\LOG_TRANSACOES\dbVendasLOG.LDF', 
 SIZE = 100MB, 
 MAXSIZE = 200MB, 
 FILEGROWTH = 50MB );