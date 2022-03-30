USE [DB_DW]

DROP VIEW IF EXISTS [dbo].[dim_tiempo]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[dim_tiempo]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[dim_tiempo] AS
SELECT DISTINCT
convert( int ,replace((left([date_application],10)),''-'','''')) as date_sk
      ,[hour_application] as hour_app
      ,[first_dow_application] as first_dow_app
      ,[month_application] as month_app
      ,[quarter_application] as quarter_app  
  FROM [DB_SOURCE].[dbo].[SRC_Applications]
 ' 
GO

