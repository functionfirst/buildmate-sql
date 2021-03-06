USE [getbuild_mate]
GO
/****** Object:  UserDefinedFunction [dbo].[HtmlEncode]    Script Date: 01/08/2014 21:33:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[HtmlEncode]
(
    @UnEncoded as varchar(500)
)
RETURNS varchar(500)
AS
BEGIN
  DECLARE @Encoded as varchar(500)

  --order is important here. Replace the amp first, then the lt and gt. 
  --otherwise the &lt will become &amp;lt; 
  SELECT @Encoded = 
  Replace(
    Replace(
      Replace(@UnEncoded,'&','&amp;'),
    '<', '&lt;'),
  '>', '&gt;')

  RETURN @Encoded
END
GO
