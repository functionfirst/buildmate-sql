/****** Object:  Trigger [dbo].[updateProfitOverhead]    Script Date: 05/19/2014 00:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 11th May 2014
-- Description:	Update user profile with profit and overheads from the inserted project
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'updateProfitOverhead')
	EXEC ('DROP TRIGGER dbo.updateProfitOverhead')
GO

CREATE TRIGGER [dbo].[updateProfitOverhead]
   ON  [dbo].[Project]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
    DECLARE @profit FLOAT, @overhead FLOAT, @userId UNIQUEIDENTIFIER
    SELECT @profit = profit, @overhead = overhead, @userid = userid FROM INSERTED
    
	UPDATE UserProfile SET defaultProfit = @profit, defaultOverhead = @overhead WHERE userId = @userId
END
