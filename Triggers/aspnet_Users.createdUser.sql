/****** Object:  Trigger [dbo].[createdUser]    Script Date: 05/19/2014 00:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 19/6/2011
-- Description:	Create necessary records for this user.
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'createdUser')
	EXEC ('DROP TRIGGER dbo.createdUser')
GO

CREATE TRIGGER [dbo].[createdUser]
   ON  [dbo].[aspnet_Users] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	DECLARE @UserId UNIQUEIDENTIFIER,
			@email VARCHAR(50),
			@titleId AS INT,
			@name AS VARCHAR(20),
			@surname AS VARCHAR(20),
			@company AS VARCHAR(20),
			@address AS VARCHAR(20), 
			@city AS VARCHAR(20),
			@county AS VARCHAR(20),
			@postcode AS VARCHAR(20),
			@tel AS VARCHAR(20),
			@fax AS VARCHAR(20),
			@mobile AS VARCHAR(20),
			@supplierName AS VARCHAR(100),
			@url AS VARCHAR(50),
			@NewId AS INT
			
    SELECT @titleId = 1,
			@supplierName  = 'Your Company',
			@address = ' '
	SELECT @Userid = UserId, @email = LoweredUserName FROM inserted

    -- add account to 'User' role
    INSERT INTO aspnet_UsersInRoles (UserId, RoleId) VALUES(@UserId, '59362571-FD3A-48BD-93BE-986545E86A08')

    -- insert initial supplier priority for Unresourced
    EXEC initialSupplierPriority @UserId

	-- insert blank user profile
    EXEC insertUserProfile @userId, @name, @company, @address, @city, @county, @postcode, @tel, @mobile, @email

    -- add user as their own supplier
    DECLARE @isLocked BIT;
    SET @isLocked = 1;
    EXEC insertSupplier @userId, @supplierName, @address, @postcode, @email, @tel, @fax, @url, @isLocked, @NewId
END
