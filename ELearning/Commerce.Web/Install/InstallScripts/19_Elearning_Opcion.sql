USE [ELearning]
GO
/****** Object:  Table [dbo].[Elearning_Opcion]    Script Date: 11/05/2006 11:05:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elearning_Opcion](
	[productID] [int] NOT NULL,
	[preguntaID] [int] NOT NULL,
	[opcionID] [int] NOT NULL,
	[literal] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[descripcion] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[esRespuesta] [bit] NOT NULL,
 CONSTRAINT [PK_Elearning_Opcion] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[preguntaID] ASC,
	[opcionID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Elearning_Opcion]  WITH CHECK ADD  CONSTRAINT [FK_Elearning_Opcion_Elearning_Preguntas] FOREIGN KEY([productID], [preguntaID])
REFERENCES [dbo].[Elearning_Preguntas] ([productID], [preguntaID])
GO
ALTER TABLE [dbo].[Elearning_Opcion] CHECK CONSTRAINT [FK_Elearning_Opcion_Elearning_Preguntas]