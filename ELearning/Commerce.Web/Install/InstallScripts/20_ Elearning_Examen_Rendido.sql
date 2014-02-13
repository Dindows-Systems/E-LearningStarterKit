
USE [ELearning]
GO
/****** Object:  Table [dbo].[Elearning_Examen_Rendido]    Script Date: 11/05/2006 11:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elearning_Examen_Rendido](
	[userName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[productID] [int] NOT NULL,
	[totalPreguntas] [int] NOT NULL,
	[totalRespuestasCorrectas] [int] NOT NULL,
	[totalRespuestasIncorrectas] [int] NOT NULL,
	[puntajeTotal] [decimal](18, 2) NOT NULL,
	[fecha_actualizacion] [datetime] NOT NULL,
 CONSTRAINT [PK_Elearning_Examen_Rendido_1] PRIMARY KEY CLUSTERED 
(
	[userName] ASC,
	[productID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
