USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[Resource_costs2]    Script Date: 01/08/2014 21:36:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 15th May 2011
-- Description:	Retrieves data for resource costs within the selected project
-- material_costs.aspx
-- labour_costs.aspx	
-- plant_costs.aspx
-- =============================================
CREATE PROCEDURE [dbo].[Resource_costs2]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectId BIGINT,
	@resourceTypeId INT,
	@grandTotalOnly BIT = 0,
	@grandTotalValue MONEY OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- create table for storing all resources
	DECLARE @myResources AS TABLE(
		id INT IDENTITY(1,1)
		, resourceid INT
		, resourceName VARCHAR(255)
		, useage FLOAT
		, price MONEY
		, unit VARCHAR(50)
		, suffix VARCHAR(50)
		, waste FLOAT
		, qty INT
	)
	
	-- and a table for storing total useage
	DECLARE @myUseage AS TABLE(
		id INT IDENTITY(1,1)
		, resourceid INT
		, totalUses FLOAT
	)

	-- populate @myResources with all resources that exist in this project
	INSERT INTO @myResources(resourceid, resourceName, useage, price, unit, suffix, waste, qty)
	SELECT
		resourceid
		, resourceName
		, tblCatalogueUseage.useage
		, tblCatalogueUseage.price
		, unit
		, suffix
		, waste
		, qty = 0
	FROM
		tblCatalogueUseage
		RIGHT JOIN tblCatalogue ON tblCatalogueUseage.catalogueId = tblCatalogue.id
		, tblResources
		, tblTaskResources
		, tblSupplierPriority
		, tblUnits
	WHERE
		tblCatalogue.resourceId = tblResources.id
		AND tblUnits.id = tblResources.unitId
		AND tblTaskResources.catalogueId = tblCatalogue.id
		AND tblSupplierPriority.supplierId = tblCatalogue.supplierId
		AND resourceTypeId = @resourceTypeId
		AND tblSupplierPriority.userId = @userId
	GROUP BY
		resourceid
		, useage
		, tblCatalogue.supplierId
		, resourceName
		, position
		, tblCatalogueUseage.price
		, unit
		, suffix
		, waste
		, tblTaskResources.qty
	ORDER BY resourceName, useage DESC, position
	
	-- get the total qty of each resource in the project
	INSERT INTO @myUseage(resourceId, totalUses)
	SELECT
		resourceId
		, round(SUM(
			(tblTaskResources.uses * tblTasks.qty)
			* .tblTaskResources.qty
		), 0) AS totalUses
	FROM
		tblTasks
		, tblTaskResources
		, tblSpaces
		, tblCatalogue
		, tblResources
	WHERE
		tblTasks.id = tblTaskResources.taskId
		AND catalogueId = tblCatalogue.id
		AND tblTasks.roomId = tblSpaces.id
		AND resourceId = tblResources.id
		AND tblSpaces.projectId = @projectId
		AND tblSpaces.spacePrice = 0
		AND resourceTypeId = @resourceTypeId
	GROUP BY
		resourceid
	HAVING
		round(
			SUM(
				(tblTaskResources.uses * tblTasks.qty)
				* .tblTaskResources.qty
			)
		, 0) > 0


	-- iterate through each record in @myUseage
	-- check useage against @myResources and increment the qty where the useage matches
	DECLARE @resourceId CHAR(11)
	DECLARE @currentUseage INT
	DECLARE @id INT, @uid INT, @rid INT
	DECLARE @useage FLOAT
	DECLARE @qty INT
	DECLARE @remainder FLOAT
	DECLARE @minUseage INT
	DECLARE @lastId INT
	
	-- initialise
	SET @rid = 0;
	SET @uid = 0;

	SELECT @resourceId = min(resourceId) FROM @myUseage
	WHILE @resourceId is not null
	BEGIN
		-- track the lowest useage available for this resource
		-- we use this at the end to round-up any remaining useage that is less than this value
		-- lastid is used when the totaluses is null or less than minUseage
		SELECT TOP 1 @minUseage = useage, @lastid = id
		FROM @myResources
		WHERE resourceid = @resourceid
		ORDER BY useage

--SELECT msg = '1. Start tracking the lowest usage. Min Usage: ', lowest_useage = @minUseage

		-- get the total uses
		-- we'll want to break this down by the useage starting with the highest denominator
		SELECT TOP 1 @uid = id, @currentUseage = totalUses
		FROM @myUseage
		WHERE resourceid = @resourceid AND id > @uid

--SELECT msg = '2. Get the total uses for this Resource. ', currentUseage = @currentUseage

		-- check a usage exists for the currentUsage
--SELECT msg = '2aa. ', resourceid = @resourceid, useage = @currentUseage
--SELECT TOP 1 id FROM @myResources WHERE resourceid = @resourceid AND useage <= @currentUseage

		IF EXISTS(SELECT TOP 1 id FROM @myResources WHERE resourceid = @resourceid AND useage <= @currentUseage)
		BEGIN
--SELECT msg = '2a. Usage DOES exist.';
			
			-- get the top resource
			-- calculate the qty
			SELECT TOP 1
				@id = id
				, @useage = useage
				, @qty = floor((@currentUseage/useage))
				, @remainder = CAST(@currentUseage AS INT) % CAST(useage AS INT)
			FROM @myResources
			WHERE resourceid = @resourceid AND useage <= @currentUseage

--SELECT TOP 1 msg = '3. Get the highest usage Resource',
--id
--, useage
--, currentUseage = @currentUseage
--, floor((@currentUseage/useage)) AS qty
--, CAST(@currentUseage AS INT) % CAST(useage AS INT) AS remainder
--, isNull(round(price*(@currentUseage/useage),2), 0) AS currPrice
--FROM @myResources
--WHERE resourceid = @resourceid AND useage <= @currentUseage



			-- update qty in resources
			UPDATE @myResources SET qty = @qty WHERE id = @id

			-- update useage with the remaining uses
			UPDATE @myUseage
			SET totalUses = @remainder
			WHERE resourceid = @resourceid
		END
		ELSE
		BEGIN
--SELECT msg = '6a. Remainder is < minimum useage so increment Qty'
			UPDATE @myResources SET qty = (qty+1) WHERE id = @lastid
			UPDATE @myUseage SET totalUses = 0 WHERE resourceid = @resourceid
		END

		-- if the remainder is less than the lowest useage
		-- increment the lowest useage
--SELECT msg = '6. Check if remainder < usage', remainder = @remainder, minUseage = @minUseage
		IF (@remainder < @minUseage AND @remainder > 0) OR @remainder IS NULL
		BEGIN
--SELECT msg = '6a. Remainder is < minimum useage so increment Qty'
			UPDATE @myResources SET qty = (qty+1) WHERE id = @lastid
			UPDATE @myUseage SET totalUses = 0 WHERE resourceid = @resourceid
		END

		

		-- only step to the next resource if we've assigned all useage for the current resource
		-- this would be indicated by 0 in totalUses
--SELECT msg = '7. IF totalUses = 0 move to next resource', totalUses FROM @myUseage WHERE resourceid = @resourceId	
		IF EXISTS(SELECT totalUses FROM @myUseage WHERE resourceid = @resourceId AND totalUses = 0)
		BEGIN
			SELECT @resourceId = min(resourceId)
			FROM @myUseage
			WHERE resourceId > @resourceId
		END
	END	
	
	-- return our final resources
	SELECT
		resourceid
		, resourceName
		, unit
		, useage
		, suffix
		, price
		, qty
		, round((price * qty),2) AS cost
		, round(((price * qty)*waste),2) AS wasteCost
		, round((price * qty) + ((price * qty)*waste),2) AS totalCost
	FROM @myResources
	WHERE qty > 0
END
GO
