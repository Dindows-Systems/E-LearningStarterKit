set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

	create PROCEDURE CSK_Store_Product_Digitales_Comprados_Carrito
	(		
		@orderID int,
		@usuario nvarchar(500),		
		@opcion nvarchar(10)
	)
	AS
		
	if (@opcion='1')
	begin
		select count(*)
		from csk_store_orderitem d, csk_store_product c
		where d.orderid=@orderID
		and c.productid=d.productid
		and c.producttypeid=1
		and c.shippingtypeid=3
		and d.productID in
			(	
				select b.productid
				from CSK_Store_Order a, csk_store_orderitem b
				where a.orderid=b.orderid
				and a.username=@usuario 
				and a.orderstatusid not in (1,99,9999,200)
			)
	end
	else
		select d.productID,c.productname
		from csk_store_orderitem d, csk_store_product c
		where d.orderid=@orderID
		and c.productid=d.productid
		and c.producttypeid=1
		and c.shippingtypeid=3
		and d.productID in
			(	
				select b.productid
				from CSK_Store_Order a, csk_store_orderitem b
				where a.orderid=b.orderid
				and a.username=@usuario 
				and a.orderstatusid not in (1,99,9999,200)
			)
	
		



	RETURN 




