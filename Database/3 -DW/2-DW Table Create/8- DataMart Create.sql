USE [DB_DW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[dw_datamart]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dw_datamart]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dw_datamart](
	[loan_id] [nvarchar](50) NOT NULL,
	[loan_sk_id] int NOT NULL,
    [loan_state] [nvarchar](50) NOT NULL,
    [loan_originated] bit NOT NULL,
    [client_id] [nvarchar](50) NOt NULL,
    [cliente_cupo_state] [nvarchar](50) NOt NULL,
    [remaining_cupo] float NOT NULL,
	[client_sk] int NOT NULL,
	[date_sk] int NOT NULL,
    [datetime_app] [nvarchar](50) NOt NULL,
    [hour_app]  [int] NOT NULL,
    [first_dow_app] [date] NOT NULL,
    [month_app] [varchar](7) NOt NULL,
    [quarter_app] [varchar](7) NOt NULL,
    [product_sk_id] int NOT NULL,
    [client_type_sk_id] int NOT NULL,
    [amount] float NOT NULL,
    [ally_slug] int NOT NULL,
    [journey_sk_id] int NOT NULL,
    [journey_stage_sk_id] int NOT NULL,
    [learning_population] bit NOT NULL,
    [DPDplus31] int NOT NULL,
    [DPDplus31_unpaid_principal] float NOT NULL,
    [ally_brand] int NOT NULL)

END
GO