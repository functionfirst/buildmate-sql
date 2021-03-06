USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectResources]    Script Date: 01/08/2014 21:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 17th October 2011
-- Description:	Retrieves data for a specific resource type within the selected project
-- =============================================
CREATE PROCEDURE [dbo].[getProjectResources]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectId BIGINT,
	@resourceTypeId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- create the useage stack
	DECLARE @stack AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, resourceId INT
		, suffix VARCHAR(50)
		, useage FLOAT
		, price FLOAT
		, catalogueUseageId INT
	)
	INSERT INTO @stack (resourceId, suffix, useage, price, catalogueUseageId)
	SELECT [Resource].id AS resourceId, CatalogueUseage.suffix, CatalogueUseage.useage, CatalogueUseage.price, CatalogueUseage.id
	FROM [Resource]
	LEFT JOIN TaskResource ON [Resource].id = TaskResource.resourceId
	LEFT JOIN Catalogue ON Catalogue.resourceId = [Resource].id
	LEFT JOIN CatalogueUseage ON Catalogueuseage.catalogueId = Catalogue.id
	LEFT JOIN Task ON TaskResource.taskId = Task.id
	LEFT JOIN BuildElement ON Task.buildElementId = dbo.BuildElement.id
	LEFT JOIN Project ON BuildElement.projectId = Project.id
	WHERE projectId = @projectId
	AND discontinued = 0
	AND resourceTypeId = @resourceTypeId
	AND userId = @userId
	AND BuildElement.spacePrice = 0
	AND Catalogue.supplierId IN (
		SELECT TOP 1 SupplierPriority.supplierId
		FROM SupplierPriority
		LEFT JOIN Catalogue ON Catalogue.supplierId = SupplierPriority.supplierId
		WHERE userid = Project.userID AND resourceId = [Resource].id
		ORDER BY position
	)
	GROUP BY Resource.id, CatalogueUseage.suffix, CatalogueUseage.useage, CatalogueUseage.price, CatalogueUseage.id
	ORDER BY Resource.id, CatalogueUseage.useage DESC

	-- create the resource stack
	DECLARE @resources AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, resourceId BIGINT
		, totalUses INT
	)
	INSERT INTO @resources (resourceId, totalUses)
	SELECT TaskResource.resourceId, SUM((TaskResource.uses * TaskResource.qty) * Task.qty) AS totalUses
	FROM Task
	LEFT JOIN TaskResource ON Task.id = TaskResource.taskId 
	LEFT JOIN dbo.BuildElement ON Task.buildElementId = dbo.BuildElement.id
	LEFT JOIN Resource ON TaskResource.resourceId = [Resource].id
	WHERE projectId = @projectId AND BuildElement.spacePrice = 0 AND resourceTypeId = @resourceTypeId
	GROUP BY TaskResource.resourceId, TaskResource.qty
	ORDER BY resourceId
	
	-- create useage table
	DECLARE @useage AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, catalogueUseageId INT
		, qty INT
	)
	
	-- compare table
	-- used this to compare stacks of resources
	DECLARE @compare AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, countId INT
		, resourceId INT
		, price FLOAT
		, total FLOAT
		, qty INT
		, catalogueUseageId INT
	)
	
	-- prepare to loop through the Resources
	DECLARE @id char(11), @qty INT, @remainder FLOAT, @totalUses FLOAT, @currentUses FLOAT, @catalogueUseageId INT, @resourceId INT, @count INT, @i INT, @price FLOAT, @total FLOAT, @rowId Int
	SELECT @id = max(id) FROM @resources

	-- iterate through each Resource row
	WHILE @id is not null
	BEGIN
		-- get the total uses for this resource
		SELECT @totalUses  = totalUses, @resourceId = resourceId FROM @resources WHERE id = @id

		-- get the total times this resource appears in the stack
		-- we need to iterate through the stack this amount of times to calculate the most cost-effective resource combination
		-- We'll call this the EF Loop
		SELECT @count = count(id) FROM @stack WHERE resourceId = @resourceId
		SELECT TOP 1 @rowId = id FROM @stack WHERE resourceId = @resourceId
		
		-- set the EF counter
		SET @i = 1
		
		-- step through the EF stack
		WHILE @i <= @count
		BEGIN
			-- during the first loop though get the maximum stacked comparison
			If @i = 1
			BEGIN
				-- insert the maximum stack comparison
				INSERT @compare(countId, resourceId, price, total, qty, catalogueUseageId) 
				SELECT TOP 1 0, resourceid, price, CEILING(@totalUses/useage)*price AS total,  CEILING(@totalUses/useage) AS qty, catalogueUseageId
				FROM @stack WHERE resourceId = @resourceId
			END
			
			-- temporary variable for storing @totalUses within this run of the stack
			SET @currentUses = @totalUses

			-- prepare to loop through the Stack for this Resource
			DECLARE @stackId char(11)
			SELECT @stackId = min(id) FROM @stack WHERE resourceId = @resourceId AND id >= @rowId

			-- Start looping through the current Stack
			WHILE @stackId is not null
			BEGIN
				-- insert into the compare table so we can compare later
				SELECT
					@qty = FLOOR(@currentUses/useage)
					, @total = FLOOR(@currentUses/useage)*price
					, @price = price
					, @remainder = @currentUses - (FLOOR(@currentUses/useage) * useage)
					, @catalogueUseageId = catalogueUseageId
				FROM @stack AS s
				WHERE s.id = @stackId

				-- add resource uses to temporary compare table
				INSERT @compare(countId, resourceId, price, total, qty, catalogueUseageId) VALUES(@i, @resourceId, @price, @total, @qty, @catalogueUseageId)

				-- reduce the uses
				SET @currentUses = @remainder

				-- Move to the next Stack row
				SELECT @stackId = min(id) FROM @stack WHERE id > @stackId AND resourceId = @resourceId

				-- Check if we're at the last row of this stack
				-- if stackId is null but there's still a remainder (totalUses) then increment the last @useage to absorb the remainder
				IF @stackId IS NULL AND @currentUses > 0
				BEGIN
					SET @currentUses = 0
					DECLARE @rowOne FLOAT, @rowTwo FLOAT
					
					-- We need to compare the previous resource useage to see if it's actually more effective
					-- to buy more of that instead of buy the current one
					
					-- get the current row from @compare table
					SELECT @rowOne = total+@price
					FROM @compare AS a WHERE id IN(SELECT TOP 1 id FROM @compare ORDER BY id DESC)
					
					-- by NOT selecting the current catalogueUseageId
					-- we can retrieve the previous row from the @compare table
					SELECT @rowTwo = isNull(price, 0)
					FROM @compare AS a WHERE id IN(SELECT TOP 1 id FROM @compare WHERE catalogueUseageId <> @catalogueUseageId ORDER BY id DESC)
					--SELECT rowOne = @rowOne, rowTwo = @rowTwo
					
					-- check if row one costs more
					IF @rowOne > @rowTwo AND @rowTwo > 0
					BEGIN
						-- since it does we need to delete it, this means it's cheaper to buy another of row 2 instead of row 1.
						DELETE FROM @compare WHERE id IN(SELECT TOP 1 id FROM @compare ORDER BY id DESC)
					END
						
					--	SELECT *
					--FROM @compare AS a WHERE id IN(SELECT TOP 1 id FROM @compare WHERE catalogueUseageId <> @catalogueUseageId ORDER BY id DESC)
					--SELECT rowOne = @rowOne, rowTwo = @rowTwo	
				
					-- Increment the qty of this row to absorb the remainder
					-- if @rowOne cost more than @rowTwo we'll actually be updating row 2 at this point.
					UPDATE @compare SET qty = a.qty+1, total = a.total + price
					FROM @compare AS a WHERE id IN(SELECT TOP 1 id FROM @compare ORDER BY id DESC)
					
				END
			END
			
			-- increment the rowId for the EF Loop
			SET @rowId = @rowId + 1

			-- increment the stack loop counter
			SET @i = @i+1
		END
		
		-- check here for the most efficient/cheapest useage stack
		-- basically get a sum grouped by countId of @compare table
		-- whichever sum is lowest is the best.
		INSERT INTO @useage(catalogueUseageId, qty)
		SELECT catalogueUseageId, qty FROM @compare WHERE countid IN (	
			SELECT TOP 1 countid FROM @compare GROUP BY countId ORDER BY SUM(total)
		) AND qty > 0

		-- clear @compare for next resource set
		DELETE FROM @compare
		
		-- check if Resource loop is ended
		SELECT @id = max(id) FROM @resources WHERE id < @id
	END	
	
	-- return the resources for this project
	SELECT
		resourceName
		, Unit AS netUnit
		, useage * u.qty AS netQty
		, suffix AS purchaseUnit
		, u.qty AS purchaseQty
		, price AS purchaseCost
		, u.qty * price AS projectCost
		, isNull(round((u.qty * price) * (waste/100), 2), 0) AS projectWaste
		, isNull(round((u.qty * price) * (1+(waste/100)), 2), 0) AS projectTotalCost
	FROM @useage AS u
	LEFT JOIN CatalogueUseage ON CatalogueUseage.id = u.catalogueUseageId
	LEFT JOIN Catalogue ON CatalogueUseage.catalogueId = Catalogue.id
	LEFT JOIN Resource ON Catalogue.resourceId = Resource.id
	LEFT JOIN ResourceUnit ON Resource.unitId = ResourceUnit.id
	WHERE qty > 0
	ORDER BY Resource.resourceName
END
GO
