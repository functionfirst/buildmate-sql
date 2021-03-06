USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectsByUserContact]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 1st November 2011
-- Description: Get a list of projects for this customer
-- =============================================
CREATE PROCEDURE [dbo].[getProjectsByUserContact]
	-- Add the parameters for the stored procedure here
	@UserId UNIQUEIDENTIFIER,
	@customerId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		Project.id
		, projectName
		, [status]
		, projectType
		, startDate
		, completionDate
		, returnDate
		, created_at
	FROM 
		Project
		, ProjectStatus
		, ProjectType
	WHERE
		userId = @userId
		AND customerID = @customerId
		AND projectStatusId = ProjectStatus.id
		AND projectTypeId = ProjectType.id
END
GO
