USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertBuildElement]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 2nd November 2011
-- Description:	Add a new build element
-- =============================================
CREATE PROCEDURE [dbo].[insertBuildElement]
	-- Add the parameters for the stored procedure here
	@projectId INT
	, @buildElementTypeId INT
	, @spaceName VARCHAR(80)
	, @spacePrice MONEY
	, @subcontractTypeId INT
	, @subcontractPercent INT
	, @completion SMALLINT
	, @NewId INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO BuildElement (projectId, buildElementTypeId, spaceName, spacePrice, completion, subcontractTypeId, subcontractPercent)
	VALUES (@projectId, @buildElementTypeId, @spaceName, @spacePrice, @completion, @subcontractTypeId, @subcontractPercent);
	SELECT @NewId = SCOPE_IDENTITY()
END
GO
