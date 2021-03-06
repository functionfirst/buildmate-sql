USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[RESOURCE_COSTS]    Script Date: 01/08/2014 21:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 3rd April 2011
-- Description:	Retrieves data for resource costs within the selected project
-- material_costs.aspx
-- labour_costs.aspx	
-- plant_costs.aspx
-- =============================================
CREATE PROCEDURE [dbo].[RESOURCE_COSTS]
	-- Add the parameters for the stored procedure here
	@userId UNIQUEIDENTIFIER,
	@projectId BIGINT,
	@resourceTypeId INT,
	@grandTotalOnly BIT = 0,
	@grandTotalValue MONEY OUTPUT
AS
BEGIN
	-- DECLARATIONS
	-- Create temporary tables
	DECLARE @myResources AS TABLE(
		id INT IDENTITY(1,1)
		, catalogueId INT
		, resourceName VARCHAR(300)
		, unit VARCHAR(20)
		, qty FLOAT
		, waste FLOAT
	)

	DECLARE @myResourceUses AS TABLE(
		id INT IDENTITY(1,1)
		, catalogueId BIGINT
		, price MONEY
		, useage FLOAT
		, suffix VARCHAR(50)
	)
	
	DECLARE @myTaskResources AS TABLE(
		id INT IDENTITY(1,1)
		, resourceName VARCHAR(300)
		, netQty INT
		, netUnit VARCHAR(20)
		, purchaseQty INT
		, purchaseUnit VARCHAR(50)
		, purchaseCost MONEY
		, projectCost MONEY
		, projectWaste MONEY
		, projectTotalCost MONEY
	)

	-- VARIABLES
	DECLARE @id INT, @useageId INT, @catalogueId INT, @qty FLOAT, @remainder FLOAT, @useage FLOAT, @buyqty FLOAT

	-- 1. get all resources that match the resource type, projectId and user
	INSERT INTO @myResources(catalogueId, resourceName, unit, qty, waste)
	SELECT
		tblCatalogue.id AS catalogueId
		, tblResources.resourceName
		, tblUnits.Unit
		, SUM(tblTasks.qty * (tblTaskResources.qty * tblTaskResources.uses)) AS qty
		, tblResources.waste
	FROM
		tblTaskResources, tblTasks, tblSpaces, tblProjects, tblCatalogue, tblResources, tblUnits
	WHERE
		tblSpaces.spacePrice = 0
		AND tblTaskResources.taskId = tblTasks.id
		AND tblTasks.roomId = tblSpaces.id
		AND tblSpaces.projectId = tblProjects.id
		AND tblTaskResources.catalogueId = tblCatalogue.id
		AND tblCatalogue.resourceId = tblResources.id
		AND tblResources.unitId = tblUnits.id
		AND userId = @userId
		AND projectId = @projectId
		AND resourceTypeId = @resourceTypeID
--AND catalogueid = 104538
	GROUP BY
		tblCatalogue.id
		, tblResources.resourceName
		, tblUnits.Unit
		, tblResources.waste
	ORDER BY resourceName
	
--SELECT * FROM @myResources
	
	-- 2. iterate through @myresources
	SELECT @id = min(id)
	FROM @myResources AS myResources
	WHILE @id is not null
	BEGIN
		-- start the useage stack
		-- calculate the qty used for each useage, starting with the largest useage
		-- also calculate the remainder so we can pass this along to the next lowest useage
		SELECT TOP 1
			--@useageId = tblCatalogueUseage.id
			 @catalogueId = myResources.catalogueId
			, @qty = CEILING(qty/useage)
			--, @remainder = CAST(qty AS NUMERIC(13, 2)) % CAST(useage AS NUMERIC(13,2))
			, @buyqty = CEILING(qty)
			, @useage = useage
		FROM @myResources AS myResources, tblCatalogueUseage
		WHERE myResources.catalogueId = tblCatalogueUseage.catalogueId AND myResources.id = @id
		ORDER BY myResources.id, tblCatalogueUseage.useage

--select catalogueId = @catalogueId, qty = @qty, buyqty = @buyqty, useage = @useage

		-- if qty exists then add it to task resources store
		IF @qty > 0
		BEGIN
			INSERT INTO @myTaskResources(resourceName, netQty, netUnit, purchaseQty, purchaseUnit, purchaseCost, projectCost, projectWaste, projectTotalCost)
			SELECT TOP 1
				resourceName
				, @buyqty AS netQty
				, unit AS netUnit
				, @qty AS purchaseQty
				, suffix AS purchaseUnit
				, price AS purchaseCost
				, round((price * @qty), 2) AS projectCost
				, round((price * @qty)*waste, 2) AS projectWaste
				, round((price * @qty) + ((price * @qty)*waste), 2) AS projectTotalCost
			FROM @myResources AS myResources, tblCatalogueUseage
			WHERE
				myResources.catalogueId = tblCatalogueUseage.catalogueId
				AND myResources.id = @id
		END
		
		-- if remainder is zero then move to next id
		-- update pointer
		SELECT @id = min(id)
		FROM @myResources
		WHERE id > @id
	END
	
	-- get results
	SELECT * FROM @myTaskResources


--	-- BELOW THIS LINE FOR COMPLEXITY
--	-- USES STACKING FOR USEAGE
--	-- Create temporary tables
--	DECLARE @myResources AS TABLE(
--		id INT IDENTITY(1,1)
--		, catalogueId INT
--		, resourceName VARCHAR(300)
--		, unit VARCHAR(20)
--		, qty FLOAT
--		, waste FLOAT
--	)

--	DECLARE @myResourceUses AS TABLE(
--		id INT IDENTITY(1,1)
--		, catalogueId BIGINT
--		, price MONEY
--		, useage FLOAT
--		, suffix VARCHAR(50)
--	)
	
--	DECLARE @myTaskResources AS TABLE(
--		id INT IDENTITY(1,1)
--		, resourceName VARCHAR(300)
--		, netQty INT
--		, netUnit VARCHAR(20)
--		, purchaseQty INT
--		, purchaseUnit VARCHAR(50)
--		, purchaseCost MONEY
--		, projectCost MONEY
--		, projectWaste MONEY
--		, projectTotalCost MONEY
--	)

--	-- VARIABLES
--	DECLARE @id INT, @useageId INT, @catalogueId INT, @qty FLOAT, @remainder FLOAT, @useage FLOAT, @buyqty FLOAT

--	-- 1. get all resources that match the resource type, projectId and user
--	INSERT INTO @myResources(catalogueId, resourceName, unit, qty, waste)
--	SELECT
--		tblCatalogue.id AS catalogueId
--		, tblResources.resourceName
--		, tblUnits.Unit
--		, SUM(tblTasks.qty * (tblTaskResources.qty * tblTaskResources.uses)) AS qty
--		, tblResources.waste
--	FROM
--		tblTaskResources, tblTasks, tblSpaces, tblProjects, tblCatalogue, tblResources, tblUnits
--	WHERE
--		tblSpaces.spacePrice = 0
--		AND tblTaskResources.taskId = tblTasks.id
--		AND tblTasks.roomId = tblSpaces.id
--		AND tblSpaces.projectId = tblProjects.id
--		AND tblTaskResources.catalogueId = tblCatalogue.id
--		AND tblCatalogue.resourceId = tblResources.id
--		AND tblResources.unitId = tblUnits.id
--		AND userId = @userId
--		AND projectId = @projectId
--		AND resourceTypeId = @resourceTypeID
----AND catalogueid = 104538
--	GROUP BY
--		tblCatalogue.id
--		, tblResources.resourceName
--		, tblUnits.Unit
--		, tblResources.waste
--	ORDER BY resourceName
	
--SELECT * FROM @myResources
	
--	-- 2. iterate through @myresources
--	SELECT @id = min(id)
--	FROM @myResources AS myResources
--	WHILE @id is not null
--	BEGIN
--		-- start the useage stack
--		-- calculate the qty used for each useage, starting with the largest useage
--		-- also calculate the remainder so we can pass this along to the next lowest useage
--		SELECT TOP 1
--			@useageId = tblCatalogueUseage.id
--			, @catalogueId = myResources.catalogueId
--			, @qty = FLOOR(qty/useage)
--			, @remainder = CAST(qty AS NUMERIC(13, 2)) % CAST(useage AS NUMERIC(13,2))
			
--			, @buyqty = qty
--			, @useage = useage
--		FROM @myResources AS myResources, tblCatalogueUseage
--		WHERE myResources.catalogueId = tblCatalogueUseage.catalogueId AND qty >= useage AND myResources.id = @id
--		ORDER BY myResources.id, tblCatalogueUseage.useage DESC
		
--		-- check if there's a smaller useage than the current one
--		-- otherwise we need to round-up the remaining qty
--		IF NOT EXISTS(
--			SELECT *
--			FROM tblCatalogueUseage
--			LEFT JOIN tblcatalogue ON tblCatalogueUseage.catalogueid = tblcatalogue.id
--			left join tblresources on tblresources.id = tblcatalogue.resourceid
--			WHERE tblcatalogue.id = @catalogueId AND useage < @useage
--		)
--		BEGIN
--			-- increment the quantity as we're rounding up
--			SET @qty = @qty+1

--			-- wipe out any remainder
--			SET @remainder = 0
--		END
		
--		-- if qty exists then add it to task resources store
--		IF @qty > 0
--		BEGIN
--			INSERT INTO @myTaskResources(resourceName, netQty, netUnit, purchaseQty, purchaseUnit, purchaseCost, projectCost, projectWaste, projectTotalCost)
--			SELECT TOP 1
--				resourceName
--				, useage AS netQty
--				, unit AS netUnit
--				, @qty AS purchaseQty
--				, suffix AS purchaseUnit
--				, price AS purchaseCost
--				, round((price * @qty), 2) AS projectCost
--				, round((price * @qty)*waste, 2) AS projectWaste
--				, round((price * @qty) + ((price * @qty)*waste), 2) AS projectTotalCost
--			FROM @myResources AS myResources, tblCatalogueUseage
--			WHERE
--				myResources.catalogueId = tblCatalogueUseage.catalogueId
--				AND myResources.id = @id AND tblCatalogueUseage.id = @useageId
--		END
		
--		IF @remainder > 0
--		BEGIN
--			-- update resource with remainder
--			-- increment qty in @myResources
--			UPDATE @myResources SET qty = @remainder
--		END
--		ELSE
--			-- if remainder is zero then move to next id
--			-- update pointer
--			SELECT @id = min(id)
--			FROM @myResources
--			WHERE id > @id
		
--			-- do some resets
--			SET @remainder = 0
--			SET @qty = 0
--			SET @useage = 0
--			SET @catalogueId = 0
--	END
	
--	-- get results
--	SELECT * FROM @myTaskResources
END
GO
