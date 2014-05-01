/****** Object:  StoredProcedure [dbo].[insertProject]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 18th April 2014
-- Description:	Insert new project record
-- =============================================
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'insertProject' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
	EXEC ('DROP PROCEDURE dbo.insertProject')
GO
CREATE PROCEDURE [dbo].[insertProject]
	-- Add the parameters for the stored procedure here
	@userID UNIQUEIDENTIFIER,
	@projectName VARCHAR(300),
	@projectTypeId INT,
	@description VARCHAR(300),
	@customerId INT,
	@statusId INT,
	@startDate DATETIME,
	@completionDate DATETIME,
	@returnDate DATETIME,
	@retentionPeriod INT,
	@retentionTypeId INT,
	@retentionPercentage INT,
	@tenderTypeId INT,
	@overhead FLOAT,
	@profit FLOAT,
	@created_by UNIQUEIDENTIFIER,
	@newId INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- check for VAT set on this users's account
	DECLARE @incVAT BIT, @vatRate FLOAT, @vatnumber VARCHAR(20)
	
	-- get current VatRate
	SELECT @vatRate = isNull(vat,0), @vatnumber = vatnumber
	FROM UserProfile
	WHERE userid = @userID

	-- if vatnumber is set then don't apply Vat to this project
	IF LEN(@vatnumber) > 1
		BEGIN
			SET @incVAT = 0
		END
	ELSE
		SET @IncVat = 1
	
	-- update user profile info for overhead and profit
	UPDATE UserProfile
	SET
		defaultOverhead = @overhead,
		defaultProfit = @profit
	WHERE userid = @userID
	
	-- create the new project
	INSERT INTO Project (userID, projectName, projectTypeId, [description], customerID, projectStatusId, startDate,
		completionDate, returnDate, retentionPeriod, retentionTypeID, retentionPercentage, tenderTypeId, incVAT, vatRate, overhead, profit) 
	VALUES (@userId, @projectName, @projectTypeId, @description, @customerId, @statusId, @startDate,
	@completionDate, @returnDate, @retentionPeriod, @retentionTypeId, @retentionPercentage, @tenderTypeId, @incVAT, @vatRate, @overhead, @profit);
	SELECT @newId = SCOPE_IDENTITY();
END
GO
