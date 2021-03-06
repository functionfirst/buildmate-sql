USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getProjectCosts]    Script Date: 01/08/2014 21:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 18th August 2011
-- Description:	Retrieves total costs for the project
-- =============================================
CREATE PROCEDURE [dbo].[getProjectCosts]
	-- Add the parameters for the stored procedure here
	@pid BIGINT,
	@userId UNIQUEIDENTIFIER
	, @totalOnly BIT = NULL
	, @projectTotal MONEY = NULL OUTPUT
	, @vatTotal MONEY = NULL OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @vatRate FLOAT
	DECLARE @grandTotal MONEY, @labourCost MONEY, @materialCost MONEY, @plantCost MONEY
	DECLARE @subcontractorTotal MONEY, @overhead MONEY, @profit MONEY, @overheadPercent INT, @profitPercent INT
	DECLARE @profitOverheadTotal MONEY, @subtotal MONEY, @discountCost MONEY, @vatCost MONEY, @additionalCost MONEY
	DECLARE @adhocCosts MONEY
	DECLARE @incVAT BIT, @incDiscount BIT
	DECLARE @vatnumber VARCHAR(20)
	DECLARE @materialVAT MONEY, @plantVAT MONEY
	SET @labourCost = 0
	SET @materialCost = 0
	SET @plantCost = 0
	SET @additionalCost = 0
	SET @vatCost = 0
	SET @discountCost = 0
	SET @vatRate = 0
	SET @vatnumber = ''
	SET @materialVAT = -1
	SET @plantVAT = -1

	-- get project data	
	SELECT
		@overheadPercent = overhead,
		@profitPercent = profit,
		@incVAT = incVAT,
		@incDiscount = incDiscount,
		@vatRate = isNull(vatRate, 0),
		@vatnumber = vatnumber
	FROM Project
	LEFT JOIN UserProfile ON UserProfile.userId = @userId
	WHERE id = @pid AND Project.userid = @userId

	-- check for vat rate
	 --IF @vatRate = 0
		--BEGIN
		--	SET @vatRate = 20
		--END

	-- calculate sum of resources for entire project
	DECLARE @sum AS TABLE(
		resourceTypeId INT
		, buildCost FLOAT
	)
	INSERT INTO @sum(resourceTypeId, buildCost)
	SELECT resourceTypeId,
		buildCost = 
		CASE
			WHEN incWaste=1 THEN (TaskResourceStack.qty*TaskResourceStack.price*(1+(waste/100)))
			ELSE (TaskResourceStack.qty*TaskResourceStack.price)
		END
	FROM TaskResourceStack
	LEFT JOIN [Resource] ON TaskResourceStack.resourceId = [Resource].id
	WHERE projectId = @pid

	-- labour costs
	SELECT @labourCost = SUM(buildCost) FROM @sum WHERE resourceTypeId = 1
	
	-- material costs
	SELECT @materialCost = SUM(buildCost) FROM @sum WHERE resourceTypeId = 2

	-- plant costs
	SELECT @plantCost = SUM(buildCost) FROM @sum WHERE resourceTypeId = 3
	

	-- sundry item costs
	SELECT @subcontractorTotal = SUM(spacePrice+(spacePrice*subcontractPercent/100))
	FROM BuildElement, Project
	WHERE userId = @userId AND projectId = @pid
	AND Project.id = BuildElement.projectId

	-- adhoc Costs
	SELECT @adhocCosts = 
		isNull(
			SUM(
				CASE adhocTypeId
					WHEN 1 THEN TaskAddition.price
					WHEN 2 THEN (TaskAddition.price/100) * TaskAddition.percentage 
					WHEN 3 THEN TaskAddition.price + ((TaskAddition.price/100) * TaskAddition.percentage) 
				END
			)
		,0)
	FROM TaskAddition
	LEFT JOIN Task ON TaskAddition.taskId = Task.id
	LEFT JOIN BuildElement ON Task.buildElementId = BuildElement.id
	WHERE BuildElement.projectId = @pid
	

	-- calculate subtotal
	SET @subtotal = isNull(@labourCost, 0) + isNull(@materialCost, 0) + isNull(@plantCost, 0) + isnull(@adhocCosts, 0) + isnull(@subcontractorTotal, 0)

	-- calculate overhead and profit
	SET @overhead = (@subtotal/100)*@overheadPercent
	SET @profit = ((@overhead+@subtotal)/100)*@profitPercent
	SET @profitOverheadTotal = @overhead + @profit

	-- check for and calculate contractor discount (2.5%)
	IF @incDiscount = 1
	BEGIN
		SET @discountCost = ((@subtotal+@profitoverheadTotal)/100) * 2.5
	END

	-- check for and calculate inclusive VAT
	If @incVAT =  1 AND len(@vatnumber) > 0
	BEGIN
		-- vat registered so add vat to everything
		SET @vatCost = ((@subtotal+@discountCost+@profitoverheadTotal)/100) * @vatRate
	END
	
	-- check for non-vat registered
	-- vat is only applied to plant and material cost
	-- do not return vat as a cost value
	IF @incVAT = 1 AND isnull(@vatnumber, 0) = 0
	BEGIN
		DECLARE @noneVATCalc INT
		SET @noneVATCalc = isNull(@materialCost, 0) + isNull(@plantCost, 0)
		SET @materialVAT = (isnull(@materialCost, 0)/100)*@vatRate
		SET @plantVAT = (isnull(@plantCost,0)/100)*@vatRate
		--SET @vatCost = @plantVAT + @materialVAT
		
		SET @subtotal = @subtotal + @materialVAT + @plantVAT
	END

	-- calculate additonal costs
	SET @additionalCost = @vatCost + @discountCost
	
	-- calculate the grand total
	SET @grandTotal = @subtotal + @profitOverheadTotal + @additionalCost
	
	IF @totalOnly IS NULL
	BEGIN
		SELECT
			labourCost = isNull(@labourCost, 0),
			materialCost = isNull(@materialCost, 0),
			materialVAT = isNull(@materialVAT, 0),
			plantCost = isNull(@plantCost, 0),
			plantVAT = isNull(@plantVAT, 0),
			subcontractorTotal = isNull(@subcontractorTotal, 0),
			adhocCosts = isNull(@adhocCosts, 0),
			subtotal = isNull(@subTotal, 0),
			overheadPercent = @overheadPercent,
			overhead = @overhead,
			profitPercent = @profitPercent,
			profit = isNull(@profit, 0),
			profitOverheadTotal = @profitOverheadTotal,
			incDiscount = isnull(@incDiscount,''),
			incVat = isnull(@incVAT,''),
			vatNumber = @vatNumber,
			vatRate = @vatRate,
			discountCost = @discountCost,
			vatCost = @vatCost,
			additionalCost = @additionalCost,
			grandTotal = @grandTotal
		
		--UPDATE Project SET totalValue = @grandTotal WHERE id = @pid AND userId = @userId
		END
	ELSE
		SELECT @projectTotal = isNull(@grandTotal, 0), @vatTotal = @vatCost
END
GO
