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
	[application_id] [nvarchar](50) NOT NULL,
	[loan_sk_id] [nvarchar](50) NOT NULL,
	[loan_originated] [bit] NOT NULL,
	[client_sk_id] [bit] NOT NULL,
	[date_sk_id] [int] NOT NULL,
	[product_sk_id] [int] NOT NULL,
	[client_type_sk_id] [int] NOT NULL,
	[journey_sk_id] [int] NOT NULL,
	[journey_stage_sk_id] [int] NOT NULL,
	[ally_slug] [int],
	[ally_brand] [int],
    [DPDplus31] [int],
    [DPDplus31_unpaid_principal] [float],
	[usr_ult_act] [nvarchar](50) NOT NULL,
	[fec_ult_act] [date] NOT NULL
 CONSTRAINT [PK_stg_applications] PRIMARY KEY NONCLUSTERED 
(
	[application_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO


