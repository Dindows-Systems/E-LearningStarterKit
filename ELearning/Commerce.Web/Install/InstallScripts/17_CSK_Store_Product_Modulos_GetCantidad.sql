set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

	

	create PROCEDURE [dbo].[CSK_Store_Product_Modulos_GetCantidad]
	(
		@product_id int
	)
	AS
		select count(*)
		from csk_store_product_modulos
		where borrado=0
		and productID=@product_id

	RETURN 



