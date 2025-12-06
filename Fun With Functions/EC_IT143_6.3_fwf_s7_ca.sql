;WITH cte AS (
    SELECT 
        ContactName,
        dbo.fn_get_first_name(ContactName) AS FirstName
    FROM dbo.t_w3_schools_customers
)
SELECT *
FROM cte
WHERE FirstName <> SUBSTRING(ContactName, 1, CHARINDEX(' ', ContactName + ' ') - 1);
