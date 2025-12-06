-- Step 5: Test Results for Fun With Triggers
-- Purpose: Verify that the AFTER UPDATE trigger correctly updates LastModifiedDate and LastModifiedBy

-- Update a record to trigger the update
UPDATE dbo.t_w3_schools_customers
SET ContactName = 'Maria Anders Step 5 Test'
WHERE customer_id = 1;

-- Verify that LastModifiedDate and LastModifiedBy were updated automatically
SELECT 
    customer_id,
    ContactName,
    LastModifiedDate,
    LastModifiedBy
FROM dbo.t_w3_schools_customers
WHERE customer_id = 1;
