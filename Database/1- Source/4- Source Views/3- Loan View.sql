USE [DB_SOURCE]
GO

/****** Object:  View [dbo].[SRC_Clients]    Script Date: 28/3/2022 13:26:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[SRC_Loans] AS

SELECT DISTINCT 
[loan_id],
[state]
  from [DB_SOURCE].[dbo].loan_status c

GO