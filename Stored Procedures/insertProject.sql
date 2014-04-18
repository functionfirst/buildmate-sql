USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[insertProject]    Script Date: 01/08/2014 21:36:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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
	
	-- create the new project
	INSERT INTO Project (userID, projectName, projectTypeId, [description], customerID, projectStatusId, startDate,
		completionDate, returnDate, retentionPeriod, retentionTypeID, retentionPercentage, tenderTypeId, incVAT, vatRate) 
	VALUES (@userId, @projectName, @projectTypeId, @description, @customerId, @statusId, @startDate,
	@completionDate, @returnDate, @retentionPeriod, @retentionTypeId, @retentionPercentage, @tenderTypeId, @incVAT, @vatRate);
	SELECT @newId = SCOPE_IDENTITY();
END
GO
