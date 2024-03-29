set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

USE [ELearning]
GO

	CREATE PROCEDURE [dbo].[CSK_Elearning_Productos_Comprados]
	(
		@usuario nvarchar(255),
		@opcion nvarchar(1)
	)
	AS
		if (@opcion='1')
		begin
		select p.productid, p.productname, p.shortdescription, 
			(
				select top 1 imageFile
				from csk_store_image
				where productID=p.productid
				order by listOrder
			) defaultimage
		from  csk_store_product p
		where 
			p.productid in
				(
					select a.productid
					from csk_store_orderitem a, csk_store_order b
					where a.orderid=b.orderid
					and b.username=@usuario
					and b.orderstatusid not in (1,99,9999,200)
					group by a.productid
				)
		end 
		else
			select count(*)
			from  csk_store_product p
			where 
				p.productid in
					(
						select a.productid
						from csk_store_orderitem a, csk_store_order b
						where a.orderid=b.orderid
						and b.username=@usuario
						and b.orderstatusid not in (1,99,9999,200)
						group by a.productid
					)

	RETURN 

