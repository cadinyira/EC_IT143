SELECT 
    ContactName,
    dbo.fn_get_first_name(ContactName) AS UDFResult,
    SUBSTRING(ContactName, 1, CHARINDEX(' ', ContactName + ' ') - 1) AS AdHocResult
FROM dbo.t_w3_schools_customers;
