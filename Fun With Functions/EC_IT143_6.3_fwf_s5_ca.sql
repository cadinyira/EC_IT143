/* 
Author: Charles Adinyira
Script: EC_IT143_6.3_fwf_s5_ca.sql
Purpose: Scalar function to return first name from contact name
*/

CREATE OR ALTER FUNCTION dbo.fn_get_first_name
(
    @ContactName VARCHAR(100)
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @FirstName VARCHAR(50);

    SET @FirstName = SUBSTRING(@ContactName, 1, CHARINDEX(' ', @ContactName + ' ') - 1);

    RETURN @FirstName;
END;
GO
