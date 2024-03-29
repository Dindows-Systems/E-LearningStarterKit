USE [ELearning]
GO
/****** Object:  StoredProcedure [dbo].[CSK_Elearning_Guardar_Resultado_Examen]    Script Date: 11/05/2006 11:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	

	CREATE PROCEDURE [dbo].[CSK_Elearning_Guardar_Resultado_Examen]
	(
		@usuario nvarchar(255),
		@productID int,
		@totalPreguntas int,
		@totalRespuestasCorrectas int,
		@totalRespuestasIncorrectas int		
	)
	AS
		declare @cantidad int

		select @cantidad=count(*) from [Elearning_Examen_Rendido]
		where ([userName]=@usuario) and ([productID]=@productID)
	
	if (@cantidad=0)	

	INSERT INTO [ELearning].[dbo].[Elearning_Examen_Rendido]
           ([userName]
           ,[productID]
           ,[totalPreguntas]
           ,[totalRespuestasCorrectas]
           ,[totalRespuestasIncorrectas]
           ,[puntajeTotal]
           ,[fecha_actualizacion])
     VALUES(
           @usuario
           ,@productID
           ,@totalPreguntas
           ,@totalRespuestasCorrectas
           ,@totalRespuestasIncorrectas
           ,round(cast(@totalrespuestascorrectas as decimal)/cast(@totalpreguntas as decimal)*10,2)
           ,getdate())
	else
	
	UPDATE [ELearning].[dbo].[Elearning_Examen_Rendido]
	   SET [totalPreguntas] = @totalPreguntas
		  ,[totalRespuestasCorrectas] = @totalRespuestasCorrectas
		  ,[totalRespuestasIncorrectas] = @totalRespuestasIncorrectas
		  ,[puntajeTotal] = round(cast(@totalrespuestascorrectas as decimal)/cast(@totalpreguntas as decimal)*10,2)
		  ,[fecha_actualizacion] = getdate() 
	 where ([userName]=@usuario) and ([productID]=@productID)

	RETURN 



