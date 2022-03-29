USE [DB_DW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[dim_journeys]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dim_journeys]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dim_journeys](
	[journey_sk_id] [int] NOT NULL,
	[journey_description] [nvarchar](50) NOT NULL,
	[fecha_desde] [date] ,
	[fecha_hasta] [date],
	[usr_ult_act] [nvarchar](50) NOT NULL,
	[fec_ult_act] [date] NOT NULL
 CONSTRAINT [PK_dim_journeys] PRIMARY KEY NONCLUSTERED 
(
	[journey_sk_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO