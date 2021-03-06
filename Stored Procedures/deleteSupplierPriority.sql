USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[deleteSupplierPriority]    Script Date: 01/08/2014 21:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description: Delete supplier from users's supplier priority list
-- =============================================
CREATE PROCEDURE [dbo].[deleteSupplierPriority] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM SupplierPriority WHERE id=@id AND userID = @userId
	
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
GO
