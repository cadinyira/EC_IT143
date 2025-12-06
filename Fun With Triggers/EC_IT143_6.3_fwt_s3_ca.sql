CREATE OR ALTER TRIGGER trg_UpdateLastModified
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Only update rows that were updated, but ignore if trigger would fire recursively
    UPDATE c
    SET 
        LastModifiedDate = GETDATE(),
        LastModifiedBy = SUSER_NAME()
    FROM dbo.t_w3_schools_customers c
    INNER JOIN inserted i ON c.customer_id = i.customer_id
    WHERE 
        -- Only update if these columns were not part of the UPDATE statement
        NOT (UPDATE(LastModifiedDate) OR UPDATE(LastModifiedBy));
END;
GO
