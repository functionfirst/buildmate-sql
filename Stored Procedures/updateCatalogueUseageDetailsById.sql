USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateCatalogueUseageDetailsById]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description:	Update catalogue useage details for this id
-- =============================================
CREATE PROCEDURE [dbo].[updateCatalogueUseageDetailsById] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@resourceId INT,
	@productCode VARCHAR(30),
	@suffix VARCHAR(50),
	@price MONEY,
	@leadTime int,
	@discontinued BIT,
	@useage FLOAT,
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE CatalogueUseage
    SET
		productCode=@productCode
		, suffix=@suffix
		, price=@price
		, leadTime=@leadTime
		, discontinued=@discontinued
		, lastUpdated=getdate()
		, useage=@useage
    WHERE id = @id
    
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
