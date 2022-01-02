SELECT * FROM %SQL_Diag.Result 
ORDER BY createTime DESC
GO
SELECT * FROM %SQL_Diag.Message WHERE diagResult=19
ORDER BY messageTime DESC
GO