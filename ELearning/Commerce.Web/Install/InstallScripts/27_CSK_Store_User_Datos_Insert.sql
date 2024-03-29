set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CSK_Store_User_Datos_Insert]
	(		
		@usuario nvarchar(500),
		@pais int,
		@ciudad nvarchar(100),
		@fecha_nacimiento nvarchar(500),
		@tipo_curso int,
		@nivel_curso int,
		@ocupacion int,
		@desempenio int,
		@cargo int		
	)
	AS
		INSERT INTO Elearning_User_Datos
           ([userName]
           ,[pais]
           ,[ciudad]
           ,[fecha_nacimiento]
           ,[tipo_curso]
           ,[nivel_estudio]
           ,[ocupacion]
           ,[desempenio]
           ,[cargo])
     VALUES
           (@usuario
           ,@pais
           ,@ciudad
           ,@fecha_nacimiento
           ,@tipo_curso
           ,@nivel_curso
           ,@ocupacion
           ,@desempenio
           ,@cargo)

	RETURN 
