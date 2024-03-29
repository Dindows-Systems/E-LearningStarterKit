USE [ELearning]
GO
/****** Object:  Table [dbo].[Elearning_User_Datos]    Script Date: 11/05/2006 17:20:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elearning_User_Datos](
	[userName] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[pais] [int] NULL,
	[ciudad] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fecha_nacimiento] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tipo_curso] [int] NULL,
	[nivel_estudio] [int] NULL,
	[ocupacion] [int] NULL,
	[desempenio] [int] NULL,
	[cargo] [int] NULL,
 CONSTRAINT [PK_Elearning_User_Datos] PRIMARY KEY CLUSTERED 
(
	[userName] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
