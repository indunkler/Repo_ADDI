USE [DB_SOURCE]
GO

/****** Object:  View [dbo].[SRC_Clients]    Script Date: 28/3/2022 13:26:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[SRC_Applications] AS
SELECT DISTINCT 
c.[application_id],
c.[loan_id],
c.[loan_originated],
c.[prospect_id],
c.[date_time] as date_application,
c.[h_vintage] as hour_application,
c.[w_vintage] as first_dow_application,
convert(varchar(7),c.[m_vintage] )as month_application,
convert(varchar(7),c.[q_vintage] )as quarter_application,
convert(varchar(20), c.[product]) as product,
convert(varchar(8), c.[client_type_db]) as client_type,
c.[amount],
c.[ally_slug],
c.[journey_name],
c.[journey_stage_name],
c.[learning_population],
convert(int,c.[DPDplus31]) as DPDplus31,
convert(float,c.[DPDplus31_unpaid_principal]) as DPDplus31_unpaid_principal ,
convert(int, c.[ally_brand]) as ally_brand
  from [DB_SOURCE].[dbo].master c

GO
