USE [DB_STAGE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[stg_applications]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stg_applications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[stg_applications](
    [application_sk_id] int NOT NULL,
    [application_id] [nvarchar](50) NOT NULL,
    [loan_id] [nvarchar](50) NOT NULL,
    [loan_originated] bit NOT NULL,
    [prospect_id] [nvarchar](50) NOT NULL,
    [date_application] [nvarchar](50) NOT NULL,
    [hour_application] [nvarchar](50) NOT NULL,
    [first_dow_application] [date] NOT NULL,
    [month_application] [varchar](7) NOT NULL,
    [quarter_application] [varchar](7) NOT NULL,
    [product] [varchar](20) NOT NULL,
    [client_type] [varchar](8) NOT NULL,
    [amount] [float] NOT NULL,
    [ally_slug] [int] NOT NULL,
    [journey_name] [nvarchar](50) NOT NULL,
    [journey_stage_name] [nvarchar](50) NOT NULL,
    [learning_population] bit NOT NULL,
    [DPDplus31] [int] NOT NULL,
    [DPDplus31_unpaid_principal] [float] NOT NULL,
    [ally_brand] [int] NOT NULL,
	[usr_ult_act] [nvarchar](50) NOT NULL,
	[fec_ult_act] [date] NOT NULL
 CONSTRAINT [PK_stg_applications] PRIMARY KEY NONCLUSTERED 
(
	[application_sk_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
