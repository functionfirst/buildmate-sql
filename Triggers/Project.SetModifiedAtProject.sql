/****** Object:  Trigger [dbo].[SetModifiedAtProject]    Script Date: 05/19/2014 00:50:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan Jenkins
-- Create date: 29th December 2013
-- Description:	Save the date the record was last modified
-- =============================================
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'SetModifiedAtProject')
	EXEC ('DROP TRIGGER dbo.SetModifiedAtProject')
GO

CREATE TRIGGER [dbo].[SetModifiedAtProject]
   ON  [dbo].[Project]
   AFTER UPDATE
AS 
BEGIN
	IF NOT UPDATE(modified_at)
    BEGIN
        UPDATE t
            SET t.modified_at = getdate()
            FROM dbo.Project AS t
            INNER JOIN inserted AS i 
            ON t.ID = i.ID;
    END
END
