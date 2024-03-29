USE [ELearning]
GO
/****** Object:  Table [dbo].[Elearning_Preguntas]    Script Date: 11/05/2006 11:06:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elearning_Preguntas](
	[productID] [int] NOT NULL,
	[preguntaID] [int] NOT NULL,
	[secuencia] [int] NOT NULL,
	[descripcion] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[estado] [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Elearning_Preguntas_1] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[preguntaID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Elearning_Preguntas]  WITH CHECK ADD  CONSTRAINT [FK_Elearning_Preguntas_CSK_Store_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[Elearning_Preguntas] CHECK CONSTRAINT [FK_Elearning_Preguntas_CSK_Store_Product]