/****** Object:  Trigger [dbo].[SetModifiedAtBuildElement]    Script Date: 05/19/2014 00:43:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 14th January 2014
-- Description:	Save the date the record was last modified
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'SetModifiedAtBuildElement')
	EXEC ('DROP TRIGGER dbo.SetModifiedAtBuildElement')
GO

CREATE TRIGGER [dbo].[SetModifiedAtBuildElement]
   ON  [dbo].[BuildElement]
   AFTER UPDATE
AS 
BEGIN
	IF NOT UPDATE(modified_at)
    BEGIN
        UPDATE t
            SET t.modified_at = getdate()
            FROM dbo.BuildElement AS t
            INNER JOIN inserted AS i 
            ON t.ID = i.ID;
    END
END
