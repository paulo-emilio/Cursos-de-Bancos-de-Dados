SELECT COUNT(*) FROM tb_nota;

-- 3012 notas

BACKUP DATABASE dbVendas TO DISK = 'C:\SQLServer22\BACKUP\DBVENDAS.BAK';

EXEC IncluiNotasDia '2022-03-01'
