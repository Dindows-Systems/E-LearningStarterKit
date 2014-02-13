-------------------
-- ELEARNING TABLES
-------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Elearning_PaymentMethods]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Elearning_PaymentMethods](
	[PaymentMethodID] [smallint] IDENTITY(1,1) NOT NULL,
	[PaymentDescription] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_Table_1_createdOn]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](50) NOT NULL,
	[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_Table_1_modifiedOn]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Elearning_PaymentMethods] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END


-------------------
-- CSK TABLES
-------------------

BEGIN TRANSACTION
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CSK_Store_Order_orderGuid
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_OrderDate_1
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_OrderStatusID
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_OrderSubTotal
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_Shipping_1
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_HandlingAmount
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_Tax_1
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_taxRate
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CMRC_Orders_discountAmount
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CSK_Store_Order_createdOn
GO
ALTER TABLE dbo.CSK_Store_Order
	DROP CONSTRAINT DF_CSK_Store_Order_modifiedOn
GO
CREATE TABLE dbo.Tmp_CSK_Store_Order
	(
	orderID int NOT NULL IDENTITY (1, 1),
	orderGuid nvarchar(50) NOT NULL,
	orderNumber varchar(50) NULL,
	orderDate smalldatetime NOT NULL,
	orderStatusID int NOT NULL,
	userName varchar(100) NOT NULL,
	email nvarchar(50) NULL,
	firstName nvarchar(50) NULL,
	lastName nvarchar(50) NULL,
	shippingMethod varchar(100) NULL,
	subTotalAmount money NOT NULL,
	shippingAmount money NOT NULL,
	handlingAmount money NOT NULL,
	taxAmount money NOT NULL,
	taxRate numeric(18, 0) NOT NULL,
	PaymentMethodID smallint NOT NULL,
	BankDepositNumber char(10) NULL,
	couponCodes nvarchar(50) NULL,
	discountAmount money NOT NULL,
	specialInstructions nvarchar(1500) NULL,
	shipToAddress nvarchar(500) NULL,
	billToAddress nvarchar(500) NULL,
	userIP nvarchar(50) NOT NULL,
	shippingTrackingNumber nvarchar(150) NULL,
	numberOfPackages int NULL,
	packagingNotes nvarchar(500) NULL,
	createdOn datetime NULL,
	createdBy nvarchar(50) NULL,
	modifiedOn datetime NULL,
	modifiedBy nvarchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CSK_Store_Order_orderGuid DEFAULT (newid()) FOR orderGuid
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_OrderDate_1 DEFAULT (getdate()) FOR orderDate
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_OrderStatusID DEFAULT ((0)) FOR orderStatusID
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_OrderSubTotal DEFAULT ((0)) FOR subTotalAmount
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_Shipping_1 DEFAULT ((0)) FOR shippingAmount
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_HandlingAmount DEFAULT ((0)) FOR handlingAmount
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_Tax_1 DEFAULT ((0)) FOR taxAmount
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_taxRate DEFAULT ((0)) FOR taxRate
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CMRC_Orders_discountAmount DEFAULT ((0)) FOR discountAmount
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CSK_Store_Order_createdOn DEFAULT (getdate()) FOR createdOn
GO
ALTER TABLE dbo.Tmp_CSK_Store_Order ADD CONSTRAINT
	DF_CSK_Store_Order_modifiedOn DEFAULT (getdate()) FOR modifiedOn
GO
SET IDENTITY_INSERT dbo.Tmp_CSK_Store_Order ON
GO
IF EXISTS(SELECT * FROM dbo.CSK_Store_Order)
	 EXEC('INSERT INTO dbo.Tmp_CSK_Store_Order (orderID, orderGuid, orderNumber, orderDate, orderStatusID, userName, email, firstName, lastName, shippingMethod, subTotalAmount, shippingAmount, handlingAmount, taxAmount, taxRate, couponCodes, discountAmount, specialInstructions, shipToAddress, billToAddress, userIP, shippingTrackingNumber, numberOfPackages, packagingNotes, createdOn, createdBy, modifiedOn, modifiedBy)
		SELECT orderID, orderGuid, orderNumber, orderDate, orderStatusID, userName, email, firstName, lastName, shippingMethod, subTotalAmount, shippingAmount, handlingAmount, taxAmount, taxRate, couponCodes, discountAmount, specialInstructions, shipToAddress, billToAddress, userIP, shippingTrackingNumber, numberOfPackages, packagingNotes, createdOn, createdBy, modifiedOn, modifiedBy FROM dbo.CSK_Store_Order WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_CSK_Store_Order OFF
GO
ALTER TABLE dbo.CSK_Store_Transaction
	DROP CONSTRAINT FK_CSK_Store_Transaction_CSK_Store_Order
GO
ALTER TABLE dbo.CSK_Store_OrderItem
	DROP CONSTRAINT FK_CSK_Store_OrderItem_CSK_Store_Order
GO
ALTER TABLE dbo.CSK_Store_OrderNote
	DROP CONSTRAINT FK_CSK_Store_OrderNote_CSK_Store_Order
GO
DROP TABLE dbo.CSK_Store_Order
GO
EXECUTE sp_rename N'dbo.Tmp_CSK_Store_Order', N'CSK_Store_Order', 'OBJECT' 
GO
ALTER TABLE dbo.CSK_Store_Order ADD CONSTRAINT
	PK_CSK_Store_Order PRIMARY KEY CLUSTERED 
	(
	orderID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.CSK_Store_Order', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.CSK_Store_Order', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.CSK_Store_Order', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.CSK_Store_OrderNote ADD CONSTRAINT
	FK_CSK_Store_OrderNote_CSK_Store_Order FOREIGN KEY
	(
	orderID
	) REFERENCES dbo.CSK_Store_Order
	(
	orderID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.CSK_Store_OrderNote', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.CSK_Store_OrderNote', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.CSK_Store_OrderNote', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.CSK_Store_OrderItem ADD CONSTRAINT
	FK_CSK_Store_OrderItem_CSK_Store_Order FOREIGN KEY
	(
	orderID
	) REFERENCES dbo.CSK_Store_Order
	(
	orderID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.CSK_Store_OrderItem', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.CSK_Store_OrderItem', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.CSK_Store_OrderItem', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.CSK_Store_Transaction ADD CONSTRAINT
	FK_CSK_Store_Transaction_CSK_Store_Order FOREIGN KEY
	(
	orderID
	) REFERENCES dbo.CSK_Store_Order
	(
	orderID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.CSK_Store_Transaction', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.CSK_Store_Transaction', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.CSK_Store_Transaction', 'Object', 'CONTROL') as Contr_Per 



------------------------
-- ELEARNING CONSTRAINTS
------------------------

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CSK_Store_Order_Elearning_PaymentMethods]') AND type = 'F')
ALTER TABLE dbo.CSK_Store_Order ADD CONSTRAINT
	FK_CSK_Store_Order_Elearning_PaymentMethods FOREIGN KEY
	(
	PaymentMethodID
	) REFERENCES dbo.Elearning_PaymentMethods
	(
	PaymentMethodID
	)
GO

-------------------
-- ELEARNING CAMBIOS
-------------------

USE [ELearning]
GO
/****** Object:  Table [dbo].[CSK_Store_Product_Modulos]    Script Date: 10/04/2006 06:02:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CSK_Store_Product_Modulos](
	[productID] [int] NOT NULL,
	[secuence] [int] NOT NULL,
	[descripcion] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ruta_descargar] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ruta_reproducir] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[borrado] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

	

	CREATE PROCEDURE [dbo].[CSK_Store_Product_GetByOrderUser]
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
		and detalleOrden.orderID=ordenes.orderID
		and detalleOrden.productID=producto.productID
		and producto.isDeleted=0
		and ordenes.orderStatusID not in (1,99,9999,200)
		order by ordenes.orderDate desc
	RETURN 
	
	
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

USE [ELearning]
GO
	

	create PROCEDURE [dbo].[CSK_Store_Product_GetByOrderUserCount]
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