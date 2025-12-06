-- Step 4: Testing logic found online
-- Resource: https://stackoverflow.com/questions/ splitting-first-last-names-sql

SELECT
    ContactName,
    CHARINDEX(' ', ContactName) AS space_position,
    SUBSTRING(ContactName, 1, CHARINDEX(' ', ContactName + ' ') - 1) AS FirstName
FROM dbo.t_w3_schools_customers;
