USE [ELearning]
GO
/****** Object:  Table [dbo].[Elearning_Super_Tipo]    Script Date: 11/05/2006 17:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elearning_Super_Tipo](
	[id_super_tipo] [int] NOT NULL,
	[descripcion] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Elearning_Super_Tipo] PRIMARY KEY CLUSTERED 
(
	[id_super_tipo] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
