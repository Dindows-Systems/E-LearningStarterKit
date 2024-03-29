USE [ELearning]
GO
/****** Object:  Table [dbo].[Elearning_Tipo]    Script Date: 11/05/2006 17:19:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elearning_Tipo](
	[id_super_tipo] [int] NOT NULL,
	[id_tipo] [int] NOT NULL,
	[descripcion] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Elearning_Tipo] PRIMARY KEY CLUSTERED 
(
	[id_super_tipo] ASC,
	[id_tipo] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Elearning_Tipo]  WITH CHECK ADD  CONSTRAINT [FK_Elearning_Tipo_Elearning_Super_Tipo] FOREIGN KEY([id_super_tipo])
REFERENCES [dbo].[Elearning_Super_Tipo] ([id_super_tipo])
GO
ALTER TABLE [dbo].[Elearning_Tipo] CHECK CONSTRAINT [FK_Elearning_Tipo_Elearning_Super_Tipo]