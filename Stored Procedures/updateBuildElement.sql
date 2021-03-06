USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateBuildElement]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 16th May 2008
-- Description:	Updates the selected Space in tblSpaces
-- =============================================
CREATE PROCEDURE [dbo].[updateBuildElement]
	-- Add the parameters for the stored procedure here
	@spaceName varchar(50),
	@spacePrice MONEY,
	@buildElementTypeId INT,
	@subcontractTypeId INT,
	@subcontractPercent SMALLINT,
	@completion SMALLINT,
	@original_id BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE BuildElement
	SET
		spaceName = @spaceName
		, spacePrice = @spacePrice
		, buildElementTypeId = @buildElementTypeId
		, subcontractTypeId = @subcontractTypeId
		, subcontractPercent = @subcontractPercent
		, completion = @completion
	WHERE id = @original_id
END
GO
