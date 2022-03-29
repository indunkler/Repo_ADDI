USE [DB_SOURCE]
GO

/****** Object:  View [dbo].[SRC_Clients]    Script Date: 29/3/2022 17:10:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SRC_Clients] AS

SELECT DISTINCT 
substring(c.id,0,37) as client_id,
c.addicupo_state as cupo_state,
convert(float,c.remaining_addicupo) as remaining_cupo
  from [DB_SOURCE].[dbo].clients c

GO


