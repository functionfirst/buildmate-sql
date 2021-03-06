USE [getbuild_mate]
GO
/****** Object:  View [dbo].[view_RESOURCES]    Script Date: 01/08/2014 21:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_RESOURCES]
AS
SELECT dbo.Project.userID, dbo.TaskResourceStack.projectId, dbo.Resource.resourceName, dbo.Resource.resourceTypeId, dbo.TaskResourceStack.qty, 
               dbo.TaskResourceStack.price, dbo.Resource.waste, dbo.TaskResourceStack.useage, dbo.TaskResourceStack.suffix, dbo.Catalogue.supplierId, 
               dbo.Supplier.supplierName, dbo.TaskResourceStack.id, dbo.TaskResourceStack.resourceId, dbo.TaskResourceStack.catalogueResourceId, 
               dbo.TaskResourceStack.lastUpdated, dbo.TaskResourceStack.productCode, dbo.Resource.manufacturer, dbo.Resource.partId
FROM  dbo.TaskResourceStack LEFT OUTER JOIN
               dbo.Project ON dbo.TaskResourceStack.projectId = dbo.Project.id LEFT OUTER JOIN
               dbo.Resource ON dbo.TaskResourceStack.resourceId = dbo.Resource.id LEFT OUTER JOIN
               dbo.ResourceUnit ON dbo.Resource.unitId = dbo.ResourceUnit.ID LEFT OUTER JOIN
               dbo.CatalogueUseage ON dbo.TaskResourceStack.catalogueResourceId = dbo.CatalogueUseage.id LEFT OUTER JOIN
               dbo.Catalogue ON dbo.CatalogueUseage.catalogueId = dbo.Catalogue.id LEFT OUTER JOIN
               dbo.Supplier ON dbo.Catalogue.supplierId = dbo.Supplier.id
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
         Begin Table = "TaskResourceStack (dbo)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project (dbo)"
            Begin Extent = 
               Top = 7
               Left = 310
               Bottom = 148
               Right = 520
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Resource (dbo)"
            Begin Extent = 
               Top = 7
               Left = 568
               Bottom = 148
               Right = 752
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ResourceUnit (dbo)"
            Begin Extent = 
               Top = 7
               Left = 800
               Bottom = 112
               Right = 984
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CatalogueUseage (dbo)"
            Begin Extent = 
               Top = 7
               Left = 1032
               Bottom = 148
               Right = 1216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Catalogue (dbo)"
            Begin Extent = 
               Top = 112
               Left = 800
               Bottom = 235
               Right = 984
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Supplier (dbo)"
            Begin Extent = 
               Top = 154
               Left = 48
               Bottom = 295
          ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_RESOURCES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Right = 232
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
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_RESOURCES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_RESOURCES'
GO
