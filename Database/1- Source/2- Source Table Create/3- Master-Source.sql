USE [DB_SOURCE]
GO

/****** Object:  Table [dbo].[master]    Script Date: 28/3/2022 12:47:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[master](
	[application_id] [nvarchar](50) NULL,
	[loan_id] [nvarchar](50) NULL,
	[loan_originated] [bit] NULL,
	[prospect_id] [nvarchar](50) NULL,
	[date_time] [nvarchar](50) NULL,
	[h_vintage] [int] NULL,
	[d_vintage] [date] NULL,
	[w_vintage] [date] NULL,
	[m_vintage] [nvarchar](50) NULL,
	[q_vintage] [nvarchar](50) NULL,
	[product] [nvarchar](50) NULL,
	[client_type_db] [nvarchar](50) NULL,
	[amount] [float] NULL,
	[ally_slug] [int] NULL,
	[journey_name] [nvarchar](50) NULL,
	[journey_stage_name] [nvarchar](50) NULL,
	[learning_population] [bit] NULL,
	[DPDplus31] [nvarchar](50) NULL,
	[DPDplus31_unpaid_principal] [nvarchar](50) NULL,
	[ally_brand] [nvarchar](50) NULL
) ON [PRIMARY]
GO


