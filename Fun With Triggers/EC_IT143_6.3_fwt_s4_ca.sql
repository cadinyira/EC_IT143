CREATE OR ALTER TRIGGER trg_UpdateLastModified
ON dbo.t_w3_schools_customers
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the row and set LastModified fields in one atomic operation
    UPDATE c
    SET 
        ContactName = i.ContactName,
        customer_name = i.customer_name,
        LastModifiedDate = GETDATE(),
        LastModifiedBy = SUSER_NAME()
    FROM dbo.t_w3_schools_customers c
    INNER JOIN inserted i ON c.customer_id = i.customer_id;
END;
GO
