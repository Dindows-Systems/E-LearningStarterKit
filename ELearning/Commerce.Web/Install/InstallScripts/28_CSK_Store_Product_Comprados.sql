set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO
USE [ELearning]
GO

	

	create PROCEDURE [dbo].[CSK_Store_Product_Comprados]
	(
		@user nvarchar(256),
		@product_id int
	)
	AS
		select count(*)
		from csk_store_orderitem a,csk_store_order b
		where a.productID=@product_id
		and b.orderID=a.orderID
		and b.username=@user

	RETURN 



