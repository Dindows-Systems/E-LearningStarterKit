set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

	

	ALTER PROCEDURE [dbo].[CSK_Store_Product_Modulo_Insert]
	(
		@productID int,		
		@nombre nvarchar(500),
		@descripcion nvarchar(500),
		@ruta_descargar nvarchar(500),
		@ruta_reproducir nvarchar(500)		
	)
	AS
		DECLARE @secuencia int

		select @secuencia=isnull(max(secuence),0)+1 
		from csk_store_product_modulos
		where productID=@productID
		
		INSERT INTO [ELearning].[dbo].[CSK_Store_Product_Modulos]
           ([productID]
           ,[secuence]
           ,[nombre]
           ,[descripcion]
           ,[ruta_descargar]
           ,[ruta_reproducir]
           ,[borrado])
		VALUES
           (@productID,@secuencia,@nombre,
			@descripcion,@ruta_descargar,@ruta_reproducir,0)

	RETURN 




