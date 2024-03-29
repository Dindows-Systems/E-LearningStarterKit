set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

	ALTER PROCEDURE [dbo].[CSK_Store_Product_Digitales_Comprados_Carrito]
	(		
		@orderID int,
		@usuario nvarchar(500),		
		@opcion nvarchar(10)
	)
	AS
		
	if (@opcion='1')
	begin
		select count(f.productname)
		from csk_store_orderitem b,csk_store_order a, csk_store_product f
		where 
		b.orderid=@orderID and
		b.orderid=b.orderid
		and a.orderstatusid in (9999)
		and a. username=@usuario
		and f.productid=b.productid
		and b.productid in 
			(
				select d.productid
				from csk_store_orderitem d,csk_store_product e,csk_store_order c
				where 
				c.orderstatusid not in (99,9999,200) and
				c.username=@usuario and 
				d.orderid=c.orderid and
				d.productid=e.productid and
				e.producttypeid=1 and e.shippingtypeid=3
			)
	end
	else
		select f.productid,f.productname
		from csk_store_orderitem b,csk_store_order a, csk_store_product f
		where 
		b.orderid=@orderID and
		b.orderid=b.orderid
		and a.orderstatusid in (9999)
		and a. username=@usuario
		and f.productid=b.productid
		and b.productid in 
			(
				select d.productid
				from csk_store_orderitem d,csk_store_product e,csk_store_order c
				where 
				c.orderstatusid not in (99,9999,200) and
				c.username=@usuario and 
				d.orderid=c.orderid and
				d.productid=e.productid and
				e.producttypeid=1 and e.shippingtypeid=3
			)

	RETURN 


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

	ALTER PROCEDURE [dbo].[CSK_Store_Product_Comprados]
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
		and b.orderstatusid not in (99,9999,200)
	RETURN 


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

	ALTER PROCEDURE [dbo].[CSK_Store_Product_GetByOrderUser]
	(
		@user nvarchar(256)
	)
	AS
		select
			producto.productID,
			producto.productName,	
			producto.shortDescription,
			(
				select top 1 imageFile
				from csk_store_image
				where productID=producto.productID
				order by listOrder
			)  imageFile,
			ordenes.orderDate
		from csk_store_order ordenes, csk_store_orderitem detalleOrden,
			csk_store_product producto
		where ordenes.userName=@user
		and producto.shippingTypeID=3
		and producto.producttypeid=1
		and detalleOrden.orderID=ordenes.orderID
		and detalleOrden.productID=producto.productID
		and producto.isDeleted=0
		and ordenes.orderStatusID not in (1,99,9999,200)
		order by ordenes.orderDate desc
	RETURN 

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO
	

	ALTER PROCEDURE [dbo].[CSK_Store_Product_GetByOrderUserCount]
	(
		@user nvarchar(256)
	)
	AS
		select COUNT(producto.productID)
		from csk_store_order ordenes, csk_store_orderitem detalleOrden,csk_store_product producto
		where ordenes.userName=@user
		and producto.shippingTypeID=3
		and detalleOrden.orderID=ordenes.orderID
		and detalleOrden.productID=producto.productID
		and producto.isDeleted=0
		and ordenes.orderStatusID not in (1,99,9999,200)
	RETURN 



set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO
	
	ALTER PROCEDURE [dbo].[CSK_Elearning_Productos_Comprados]
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
			p.shippingTypeID=3	and p.producttypeid=1 and
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
				p.shippingTypeID=3
				and p.producttypeid=1 and
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


