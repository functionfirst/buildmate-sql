USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Project_Select]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 14th October 2013
-- Description:	Get project details
-- =============================================
CREATE PROCEDURE [dbo].[Project_Select]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		Project.id
		, name
		, profit
		, overhead
		, projectName
		, Project.customerId
		, Project.[description]
		, tenderType
		, tenderTypeId
		, returnDate
		, [status]
		, startDate
		, isEditable
		, completionDate
		, retentionPeriod
		, retentionPercentage
		, projectStatusId
		, ProjectRetentionType.retentionType
		, retentionTypeId
		, projectTypeId
		, projectType
		, ProjectStatus.isLocked
		, vatRate
		, Project.archived
		, isNull(incVAT, 0) AS incVAT
		, isNull(incDiscount, 0) AS incDiscount
	FROM Project
    INNER JOIN UserContact ON customerId = UserContact.id
    INNER JOIN ProjectStatus ON ProjectStatus.id = ProjectStatusId
    INNER JOIN ProjectRetentionType ON Project.retentionTypeId = ProjectRetentionType.id
    INNER JOIN ProjectType ON ProjectType.id = projectTypeId
    INNER JOIN ProjectTenderType ON tenderTypeId = ProjectTenderType.id
    WHERE (Project.userId = @userId) AND (Project.id = @projectId)
END
GO
