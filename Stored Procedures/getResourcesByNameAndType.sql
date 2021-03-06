USE [getbuild_mate]
GO
/****** Object:  StoredProcedure [dbo].[getResourcesByNameAndType]    Script Date: 01/08/2014 21:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 20th September 2011
-- Description:	Query a list of resource of this type and matching the string
-- =============================================
CREATE PROCEDURE [dbo].[getResourcesByNameAndType]
	-- Add the parameters for the stored procedure here
	@resourceTypeId INT,
	@resourceName VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @id INT, @string VARCHAR(MAX), @term VARCHAR(120)
	SET @resourceName = ' ' + @resourceName
	
	DECLARE @search AS TABLE (
		id INT PRIMARY KEY IDENTITY(1,1)
		, term VARCHAR(120)
	)
	INSERT @search(term)
	SELECT * FROM dbo.split(@resourceName, ' ')
	
	-- initial search sql string
	SET @string =	'SELECT top 500 [Resource].id, resourceName, categoryName, unit, manufacturer, partId' +
					' FROM [Resource]' +
					' LEFT JOIN ResourceCategory ON [Resource].categoryId = ResourceCategory.id' +
					' LEFT JOIN ResourceUnit on [Resource].unitId = ResourceUnit.Id' +
					' WHERE resourceTypeId = ' + CONVERT(VARCHAR(2), @resourceTypeId) 
	
	-- prepare to loop through search terms
	SELECT @id = max(id) FROM @search
	
	-- iterate through each Resource row
	WHILE @id is not null
	BEGIN
		SELECT @term = term FROM @search WHERE id = @id
		
		IF @term is not null
		BEGIN
			SET @string = @string + ' AND (resourceName LIKE ''%' + @term + '%'' OR keywords LIKE ''%'+ @term+'%'' OR manufacturer LIKE ''%'+ @term+'%'' OR partId LIKE ''%'+@term+'%'')'  
			--SET @string = @string + ' AND CONTAINS ((resourceName, keywords, manufacturer, partId), ''' + @term + ''')'
		END
		
		-- check if Resource loop is ended
		SELECT @id = max(id) FROM @search WHERE id < @id
	END
	
	-- run the search
	EXEC (@string)
END
GO
