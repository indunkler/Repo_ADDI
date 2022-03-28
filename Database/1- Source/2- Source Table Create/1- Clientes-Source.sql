USE [DB_SOURCE]
GO

/****** Object:  Table [dbo].[clients]    Script Date: 28/3/2022 10:39:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[clients](
	[addicupo_state] [nvarchar](50) NOT NULL,
	[remaining_addicupo] [nvarchar](50) NOT NULL,
	[id] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO