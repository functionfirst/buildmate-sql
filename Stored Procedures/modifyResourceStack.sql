USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[modifyResourceStack]    Script Date: 01/08/2014 21:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 6th November 2011
-- Description: Modifies the resource stack depending on context, this could be Project, Build Element, Task or Resource
--				Resource stacks are unique depending on the isEditable state of the Project, Build Element or Task
-- =============================================
CREATE PROCEDURE [dbo].[modifyResourceStack] 
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER
	, @projectId BIGINT = NULL
	, @resourceId INT = NULL
	, @isEditable TINYINT
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
		, waste FLOAT
	)
	INSERT INTO @stack (resourceId, suffix, useage, price, catalogueUseageId, waste)
	SELECT resourceId, suffix, useage, price, catalogueUseageId, waste
	FROM ViewOfUseageStack
	WHERE
		userId = @userId
		AND (projectId = @projectId OR @projectId IS NULL)
		AND (resourceId = @resourceId OR @resourceId IS NULL)
		AND isEditable = @isEditable
	GROUP BY resourceId, suffix, useage, price, catalogueUseageId, waste
	ORDER BY resourceId, useage DESC
	
	-- create the resource stack
	DECLARE @resources AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, resourceId BIGINT
		, totalUses FLOAT
	)
	INSERT INTO @resources (resourceId, totalUses)
	SELECT resourceId, SUM((uses * qty)*taskQty) AS totalUses
	FROM ViewOfResourceStack
	WHERE
		userId = @userId
		AND (projectId = @projectId OR @projectId IS NULL)
		AND (resourceId = @resourceId OR @resourceId IS NULL)
		AND isEditable = @isEditable
	GROUP BY resourceId
	ORDER BY resourceId
	
	-- create useage table
	DECLARE @useage AS TABLE(
		id INT PRIMARY KEY IDENTITY(1,1)
		, resourceId INT
		, catalogueUseageId INT
		, qty INT
		, incWaste BIT
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
		, useage FLOAT
		, waste FLOAT
	)

	-- prepare to loop through the Resources
	DECLARE @id INT, @qty INT, @waste FLOAT, @stackUseage FLOAT, @incWaste BIT, @remainder FLOAT, @totalUses FLOAT, @currentUses FLOAT, @catalogueUseageId INT, @rid INT, @count INT, @i INT, @price FLOAT, @total FLOAT, @rowId Int
	SELECT @id = max(id) FROM @resources
	SET @incWaste = 1

	-- iterate through each Resource row
	WHILE @id is not null
	BEGIN
		-- get the total uses for this resource
		SELECT @totalUses  = totalUses, @rid = resourceId FROM @resources WHERE id = @id

		-- get the total times this resource appears in the stack
		-- we need to iterate through the stack this amount of times to calculate the most cost-effective resource combination
		-- We'll call this the EF Loop
		SELECT @count = count(id) FROM @stack WHERE resourceId = @rid
		SELECT TOP 1 @rowId = id FROM @stack WHERE resourceId = @rid
		
		-- set the EF counter
		SET @i = 1
		
		-- step through the EF stack
		WHILE @i <= @count
		BEGIN
			-- during the first loop though get the maximum stacked comparison
			If @i = 1
			BEGIN
				-- insert the maximum stack comparison
				INSERT @compare(countId, resourceId, price, total, qty, catalogueUseageId, useage, waste) 
				SELECT TOP 1 0, resourceid, price, CEILING(@totalUses/useage)*price AS total,  CEILING(@totalUses/useage) AS qty, catalogueUseageId, useage, waste
				FROM @stack WHERE resourceId = @rid AND useage > @totalUses
				ORDER BY useage
			END
			
			-- temporary variable for storing @totalUses within this run of the stack
			SET @currentUses = @totalUses

			-- prepare to loop through the Stack for this Resource
			DECLARE @stackId char(11)
			SELECT @stackId = min(id) FROM @stack WHERE resourceId = @rid AND id >= @rowId

			-- Start looping through the current Stack
			WHILE @stackId is not null
			BEGIN
				-- get details for the current stack item
				SELECT
					@qty = FLOOR(@currentUses/useage)
					, @total = FLOOR(@currentUses/useage)*price
					, @price = price
					, @remainder = @currentUses - (FLOOR(@currentUses/useage) * useage)
					, @catalogueUseageId = catalogueUseageId
					, @stackUseage = useage
					, @waste = waste
				FROM @stack AS s
				WHERE s.id = @stackId
			
				-- add resource uses to temporary compare table
				INSERT @compare(countId, resourceId, price, total, qty, catalogueUseageId, useage, waste)
				VALUES(@i, @rid, @price, @total, @qty, @catalogueUseageId, @stackUseage, @waste)

				-- reduce the uses
				SET @currentUses = @remainder

				-- Move to the next Stack row
				SELECT @stackId = min(id) FROM @stack WHERE id > @stackId AND resourceId = @rid

				-- Check if we're at the last row of this stack
				-- if stackId is null but there's still a remainder (totalUses) then increment the last @useage to absorb the remainder
				IF @stackId IS NULL AND @currentUses > 0
				BEGIN
					DECLARE @rowOne FLOAT, @rowTwo FLOAT --, @usageOne FLOAT, @usageTwo FLOAT, @qtyOne INT, @qtyTwo INT, @lowerWaste FLOAT
					SET @rowOne = 0
					Set @rowTwo = 0
					
					-- We need to compare the previous resource useage to see if it's actually more effective
					-- to buy more of that instead of buy the current one

					-- get the current row from @compare table
					SELECT @rowOne = total+@price --, @usageOne = useage, @qtyOne = qty
					FROM @compare AS a WHERE id IN(SELECT TOP 1 id FROM @compare ORDER BY id DESC)

					-- by NOT selecting the current catalogueUseageId
					-- we can retrieve the previous row from the @compare table
					SELECT @rowTwo = isNull(price, 0) --, @usageTwo = useage, @qtyTwo = qty
					FROM @compare AS a WHERE id IN(SELECT TOP 1 id FROM @compare WHERE catalogueUseageId <> @catalogueUseageId ORDER BY id DESC)

					-- tackle the remainder as its less than the lowest useage
					SET @currentUses = 0
					-- check if row one costs more
					IF @rowOne > @rowTwo AND @rowTwo > 0
					BEGIN
						-- since it does we need to delete it, this means it's cheaper to buy another of row 2 instead use row 1
						DELETE FROM @compare WHERE id IN(SELECT TOP 1 id FROM @compare ORDER BY id DESC)
					END
					
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
		SELECT  @incWaste = 
			CASE
				WHEN (@totalUses*(1+waste/100))-SUM(qty*useage)>=0 THEN 1
				ELSE 0
			END
		FROM @compare WHERE countid IN (	
			SELECT TOP 1 countid FROM @compare GROUP BY countId ORDER BY SUM(total)
		) AND qty > 0
		GROUP BY waste
		
		
		INSERT INTO @useage(resourceId, catalogueUseageId, qty, incWaste)
		SELECT resourceId, catalogueUseageId, qty, @incWaste
		FROM @compare WHERE countid IN (	
			SELECT TOP 1 countid FROM @compare GROUP BY countId ORDER BY SUM(total)
		) AND qty > 0

		-- clear @compare for next resource set
		DELETE FROM @compare
		
		-- check if Resource loop is ended
		SELECT @id = max(id) FROM @resources WHERE id < @id
	END
	
	-- clear out the previous resource stack for this project
	-- check for lock, only allow delete of the stack for those resources that are editable
	DECLARE @isLocked BIT
	SELECT TOP 1 @isLocked =
		CASE WHEN ProjectStatus.isEditable <> BuildElementType.isEditable THEN 1
		ELSE 0
		END
	FROM Project
	LEFT JOIN ProjectStatus ON Project.projectStatusId = ProjectStatus.id
	LEFT JOIN BuildElement ON Project.id = BuildElement.projectId
	LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
	WHERE userID = @userId AND Project.id = @projectId AND buildelementType.isEditable = @isEditable

	IF @isLocked = 0
	BEGIN
		DELETE FROM TaskResourceStack WHERE isEditable = @isEditable AND projectId IN (
			SELECT project.id
			FROM Project
			LEFT JOIN BuildElement ON Project.id = BuildElement.projectId
			LEFT JOIN BuildElementType ON BuildElement.buildElementTypeId = BuildElementType.id
			WHERE userID = @userId AND Project.id = @projectId AND isEditable = @isEditable
		)
	END

	-- store the resources for this project
	INSERT INTO taskResourceStack(projectId, resourceId, catalogueResourceId, qty, price, useage, suffix, lastUpdated, productCode, isEditable, incWaste)
	SELECT
		@projectId
		, u.resourceId
		, catalogueUseageId
		, u.qty
		, price
		, useage
		, suffix
		, lastUpdated
		, productCode
		, @isEditable
		, u.incWaste
	FROM @useage AS u
	LEFT JOIN CatalogueUseage ON CatalogueUseage.id = u.catalogueUseageId
	LEFT JOIN Catalogue ON CatalogueUseage.catalogueId = Catalogue.id
	LEFT JOIN [Resource] ON Catalogue.resourceId = [Resource].id
	LEFT JOIN resourceUnit ON [Resource].unitId = resourceUnit.id
	ORDER BY [Resource].resourceName
END
GO
