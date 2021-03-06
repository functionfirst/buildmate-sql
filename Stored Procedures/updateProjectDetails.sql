USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[updateProjectDetails]    Script Date: 01/08/2014 21:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			Alan Jenkins
-- Create date:		12th November 2011
-- Description:		Update the project details
-- =============================================
CREATE PROCEDURE [dbo].[updateProjectDetails]
	-- Add the parameters for the stored procedure here
	@id INT
	, @userId UNIQUEIDENTIFIER
	, @projectName VARCHAR(150)
	, @description TEXT
	, @projectTypeId INT
	, @customerId INT
	, @projectStatusId TINYINT
	, @returnDate DATETIME
	, @startDate DATETIME
	, @completionDate DATETIME
	, @retentionPeriod TINYINT
	, @retentionTypeId TINYINT
	, @retentionPercentage TINYINT
	, @overhead FLOAT
	, @profit FLOAT
	, @tenderTypeId INT
	, @incVat BIT
	, @incDiscount BIT
	, @vatRate FLOAT
	, @modified_by UNIQUEIDENTIFIER
	, @OldStatusId INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE Project SET 
	 projectName = @projectName
	, [description] = @description
	, projectTypeId = @projectTypeId
	, customerId = @customerId
	, projectStatusId = @projectStatusId
	, returnDate = @returnDate
	, startDate = @startDate
	, completionDate = @completionDate
	, retentionPeriod = @retentionPeriod
	, retentionTypeId = @retentionTypeId
	, retentionPercentage = @retentionPercentage
	, overhead = @overhead
	, profit = @profit
	, tenderTypeId = @tenderTypeId
	, incVat = @incVat
	, incDiscount = @incDiscount
	, vatRate = @vatRate
	, modified_by = @modified_by
    WHERE id = @id and userID = @userid
    
    IF @OldStatusId <> @projectStatusId
    BEGIN
		DECLARE @statusName VARCHAR(100)
		
		SELECT @statusName = [status] FROM ProjectStatus WHERE id = @projectStatusId
		
		-- Log the update to status
		INSERT INTO ProjectLog (projectId, userId, statusId, note) VALUES(@id, @modified_by, @projectStatusId, 'Changed status to ' + @statusName)
		
		-- log the lost status
		if @projectStatusId = 7
		BEGIN
			UPDATE Project
			SET wonlost = 2, wonlost_at = GETDATE()
			WHERE Project.id = @id AND userID = @userId
		END
		
		-- log the won status
		if @projectStatusId = 4
		BEGIN
			UPDATE Project
			SET wonlost = 1, wonlost_at = GETDATE()
			WHERE Project.id = @id AND userID = @userId
		END
		
		--SELECT id, userId, projectStatusId, 'Project created' FROM UPDATED
		--INSERT INTO ProjectLog(projectId, userId, statusId, note)
		--VALUES (projectId, @modified_by, @projectStatusId, note)
    END
END
GO
