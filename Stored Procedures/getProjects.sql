USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjects]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th November 2011
-- Description:	Get a list of projects for this user.
-- =============================================
CREATE PROCEDURE [dbo].[getProjects]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Project.id, projectName, [status], archived, [description], startDate, completionDate, returnDate, projectStatusId, projectType, projectTypeId, incVAT
    FROM Project
    LEFT JOIN ProjectType ON ProjectType.id = Project.projectTypeId
    LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
    WHERE projectTypeId = ProjectType.id AND userId =  @userId
    ORDER BY projectName
END
GO
