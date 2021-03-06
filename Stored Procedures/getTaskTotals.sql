USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getTaskTotals]    Script Date: 01/08/2014 21:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th August 2011
-- Description:	Retrieve the break-down of resources and total for a specific Task.
-- =============================================
CREATE PROCEDURE [dbo].[getTaskTotals]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectId INT,
	@taskID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @labourCost MONEY, @materialCost MONEY, @plantCost MONEY, @adhocCost MONEY, @total MONEY

	-- labour cost
	SELECT @labourCost = SUM(unitCost) FROM (
		SELECT
			isNull(
			(TaskResource.uses*TaskResource.qty*Task.qty) *
			(
				SELECT SUM(TaskResourceStack.price)/SUM(TaskResourceStack.useage)
				FROM TaskResourceStack
				WHERE projectId = @projectId AND resourceId = [Resource].id
				GROUP BY resourceId)
			, 0) * (1+(waste/100))
			AS unitCost
		FROM TaskResource
		LEFT JOIN [Resource] ON TaskResource.resourceId = [Resource].id
		LEFT JOIN Task ON Task.id= TaskResource.taskId
		WHERE Task.id = @taskId AND resourceTypeId = 1
	) AS labourCost

	-- material cost
	SELECT @materialCost = SUM(unitCost) FROM (
		SELECT
			(TaskResource.uses*TaskResource.qty*Task.qty) *
			(
				SELECT SUM(TaskResourceStack.price)/SUM(TaskResourceStack.useage)
				FROM TaskResourceStack
				WHERE projectId = @projectId AND resourceId = [Resource].id
				GROUP BY resourceId
			) * (1+(waste/100))
			AS unitCost
		FROM TaskResource
		LEFT JOIN [Resource] ON TaskResource.resourceId = [Resource].id
		LEFT JOIN Task ON Task.id= TaskResource.taskId
		WHERE Task.id = @taskId AND resourceTypeId = 2
	) AS materialCost

	-- plant cost
	SELECT @plantCost = SUM(unitCost) FROM (
		SELECT
			(TaskResource.uses*TaskResource.qty*Task.qty) *
			(
				SELECT SUM(TaskResourceStack.price)/SUM(TaskResourceStack.useage)
				FROM TaskResourceStack
				WHERE projectId = @projectId AND resourceId = [Resource].id
				GROUP BY resourceId
			) * (1+(waste/100))
			AS unitCost
		FROM TaskResource
		LEFT JOIN [Resource] ON TaskResource.resourceId = [Resource].id
		LEFT JOIN Task ON Task.id= TaskResource.taskId
		WHERE Task.id = @taskId AND resourceTypeId = 3
	) AS plantCost

	--adhoc cost
	SELECT
		@adhocCost = SUM(
        CASE adhoctypeId
            WHEN 1 THEN price
            WHEN 2 THEN (price/100) * percentage
            WHEN 3 THEN price + (price/100) * percentage
        END)
    FROM TaskAddition
	LEFT JOIN TaskAdditionType ON TaskAddition.adhocTypeId = TaskAdditionType.id
	LEFT JOIN Task ON TaskAddition.taskID = Task.id
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	LEFT JOIN Project ON BuildElement.projectId = Project.id
    WHERE taskId = @taskId AND userId = @userId
    
    SELECT
		labourCost = ROUND(isNull(@labourCost, 0), 2)
		, materialCost = ROUND(isNull(@materialCost, 0), 2)
		, plantCost = ROUND(isNull(@plantCost, 0), 2)
		, adhocCost = ROUND(isNull(@adhocCost, 0), 2)
		, total = isNull(@labourCost, 0) + isNull(@materialCost, 0) + isNull(@plantCost, 0) + isNull(@adhocCost, 0)
END
GO
