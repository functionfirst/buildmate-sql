USE [getbuild_mate]
GO
/****** Object:  View [dbo].[ViewOfUseageStack]    Script Date: 01/08/2014 21:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewOfUseageStack]
AS
SELECT TOP (100) PERCENT dbo.Project.userID, dbo.BuildElement.projectId, dbo.BuildElement.id AS buildElementId, dbo.Task.id AS taskId, dbo.TaskResource.resourceId, 
               dbo.CatalogueUseage.id AS catalogueUseageId, dbo.CatalogueUseage.suffix, dbo.CatalogueUseage.useage, dbo.CatalogueUseage.price, 
               dbo.BuildElementType.isEditable, dbo.Resource.waste
FROM  dbo.Resource LEFT OUTER JOIN
               dbo.TaskResource ON dbo.Resource.id = dbo.TaskResource.resourceId LEFT OUTER JOIN
               dbo.Catalogue ON dbo.Catalogue.resourceId = dbo.Resource.id LEFT OUTER JOIN
               dbo.CatalogueUseage ON dbo.CatalogueUseage.catalogueId = dbo.Catalogue.id LEFT OUTER JOIN
               dbo.Task ON dbo.TaskResource.taskId = dbo.Task.id LEFT OUTER JOIN
               dbo.BuildElement ON dbo.Task.buildElementId = dbo.BuildElement.id LEFT OUTER JOIN
               dbo.Project ON dbo.BuildElement.projectId = dbo.Project.id LEFT OUTER JOIN
               dbo.ProjectStatus ON dbo.ProjectStatus.ID = dbo.Project.projectStatusId LEFT OUTER JOIN
               dbo.BuildElementType ON dbo.BuildElement.buildElementTypeId = dbo.BuildElementType.id AND 
               dbo.ProjectStatus.isEditable = dbo.BuildElementType.isEditable
WHERE (dbo.CatalogueUseage.discontinued = 0) AND (dbo.BuildElement.spacePrice = 0) AND (dbo.Catalogue.supplierId IN
                   (SELECT TOP (1) dbo.SupplierPriority.supplierId
                    FROM   dbo.SupplierPriority LEFT OUTER JOIN
                                   dbo.Catalogue AS Catalogue_1 ON Catalogue_1.supplierId = dbo.SupplierPriority.supplierId
                    WHERE (dbo.SupplierPriority.userID = dbo.Project.userID) AND (Catalogue_1.resourceId = dbo.Resource.id)
                    ORDER BY dbo.SupplierPriority.position DESC))
ORDER BY dbo.TaskResource.resourceId, dbo.CatalogueUseage.useage DESC
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Resource (dbo)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TaskResource (dbo)"
            Begin Extent = 
               Top = 7
               Left = 280
               Bottom = 148
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Catalogue (dbo)"
            Begin Extent = 
               Top = 7
               Left = 512
               Bottom = 130
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CatalogueUseage (dbo)"
            Begin Extent = 
               Top = 7
               Left = 744
               Bottom = 148
               Right = 928
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Task (dbo)"
            Begin Extent = 
               Top = 7
               Left = 976
               Bottom = 148
               Right = 1173
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BuildElement (dbo)"
            Begin Extent = 
               Top = 133
               Left = 512
               Bottom = 274
               Right = 719
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project (dbo)"
            Begin Extent = 
               Top = 154
               Left = 48
               Bottom = 295
               Right' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewOfUseageStack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectStatus (dbo)"
            Begin Extent = 
               Top = 7
               Left = 1221
               Bottom = 148
               Right = 1405
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BuildElementType (dbo)"
            Begin Extent = 
               Top = 154
               Left = 306
               Bottom = 295
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewOfUseageStack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewOfUseageStack'
GO
