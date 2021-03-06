USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertSupplierPriority]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd October 2011
-- Description:	Add a supplier to the users supplier priority list
-- =============================================
CREATE PROCEDURE [dbo].[insertSupplierPriority]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
	, @supplierId INT
	, @isLocked BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- check supplier doesn't already exist
	IF NOT EXISTS(SELECT * FROM SupplierPriority WHERE userID = @userId and supplierId = @supplierId)
	BEGIN
		-- get next position	
		DECLARE @position FLOAT
		SELECT TOP 1 @position = position FROM SupplierPriority WHERE userId = @userId ORDER BY position DESC
		SET @position = @position +1

		-- if no supplier exists then priority will be null. Set it to 1
		IF @position IS NULL
		BEGIN
			SET @position = 1
		END

		-- insert new supplier priority
		INSERT INTO SupplierPriority(userId, supplierId, position, isLocked) VALUES(@userId, @supplierId, @position, @isLocked)
		
		-- iterate through a list of projects owned by this user
		DECLARE @projectId INT, @isEditable TINYINT
		SELECT @projectId = max(id) FROM Project WHERE userID = @userId

		-- begin the iteration through the project list
		WHILE @projectId is not null
		BEGIN
			-- get current editable state of the project
			SELECT @isEditable = isEditable
			FROM Project
			LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.ID
			WHERE Project.id = @projectId
			
			-- run the resource stack for this project
			Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
		
			-- check if project loop is ended
			SELECT @projectId = max(id) FROM Project WHERE UserId = @userId AND id < @projectId
		END
	END
END
GO
