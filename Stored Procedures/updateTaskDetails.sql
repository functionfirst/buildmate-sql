USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateTaskDetails]    Script Date: 01/08/2014 21:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 28th April 2008
-- Description:	Updates adjustments for the selected Task
-- =============================================
CREATE PROCEDURE [dbo].[updateTaskDetails]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectId INT,
	@id INT,
	@qty FLOAT,
	@buildPhaseId INT,
	@note TEXT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @isEditable TINYINT

	-- update task values
	UPDATE Task
	SET qty = @qty
		, buildPhaseId = @buildPhaseId
		, note = @note
	WHERE id = @id
	
	-- get isEditable from parent Build Element
	SELECT @isEditable = isEditable
	FROM BuildElement
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	LEFT JOIN Task ON Task.buildElementId = BuildElement.id
	WHERE Task.id= @id

	-- update resource stack
	Exec dbo.modifyResourceStack @userId, @projectId, NULL, @isEditable
END
GO
