--  LOAD DATA errors are logged and can be checked with this table/view
-- one row = one LOAD DATA execution 
SELECT * FROM %SQL_Diag.Result 
ORDER BY createTime DESC
GO
-- LOAD DATA errors are logged and can be checked with this table/view
-- they are
SELECT * FROM %SQL_Diag.Message WHERE diagResult=19
ORDER BY messageTime DESC
GO