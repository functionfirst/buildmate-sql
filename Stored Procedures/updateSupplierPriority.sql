USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateSupplierPriority]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 19th March 2011
-- Description:	Modify the supplier priority position for the user
-- =============================================
CREATE PROCEDURE [dbo].[updateSupplierPriority]
	-- Add the parameters for the stored procedure here
	@id INT,
	@direction BIT,
	@position INT,
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @newId INT, @newPosition INT
    
    -- if true move position up
    IF @direction = 0
		BEGIN
			SELECT TOP 1 @newId = id, @newPosition = position 
			FROM SupplierPriority
			WHERE userId = @userid AND position > @position
			ORDER BY position;
		END
    ELSE
		-- @direction is false so move position down
		BEGIN
			SELECT TOP 1 @newId = id, @newPosition = position 
			FROM SupplierPriority
			WHERE userId = @userid AND position < @position
			ORDER BY position DESC;
		END
		
    IF(@newId>=1)
    BEGIN
		UPDATE SupplierPriority SET position = @newPosition WHERE id = @id;
		UPDATE SupplierPriority SET position = @position WHERE id = @newId;
		
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
