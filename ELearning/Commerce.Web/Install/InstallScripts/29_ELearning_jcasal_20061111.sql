ALTER PROCEDURE [dbo].[CSK_Store_Product_GetPostAddMulti]
	(
		@userName nvarchar(50)
	)
AS
	
	--get the last item added
	DECLARE @orderID nvarchar(50)
	SELECT @orderID=O.orderID 
	FROM CSK_STORE_Order O
		 INNER JOIN CSK_Store_OrderItem OI
			ON OI.orderID = O.orderID
	WHERE O.userName=@userName AND O.orderStatusID=9999
	ORDER BY OI.modifiedOn ASC
	
	
	DECLARE @productID int
	SELECT TOP 1 @productID=productID FROM CSK_Store_OrderItem WHERE orderID=@orderID ORDER BY modifiedOn DESC
	
	--recently added
	SELECT     TOP (1) orderItemID, orderID, productID, sku, productName, productDescription, weight, dimensions, quantity, originalPrice, pricePaid, attributes, 
	                      downloadURL, isShipped, shipDate, shipmentReference, createdOn, createdBy, modifiedOn, modifiedBy,
	                          (SELECT     TOP (1) imageFile
	                            FROM          CSK_Store_Image
	                            WHERE      (productID = @productID)) AS imageFile, imageFile AS Expr1, shippingEstimate, rating
	FROM         CSK_Store_OrderItem
	WHERE     (orderID = @orderID) AND (productID = @productID)
	ORDER BY modifiedOn DESC
	
	
	--get the most recently viewed
	SELECT     TOP (20) CSK_Stats_Tracker.userName, CSK_Store_Product.sku, CSK_Store_Product.productName, CSK_Store_Product.ourPrice, 
	                      CSK_Store_Product.retailPrice, CSK_Store_Product.shortDescription, CSK_Store_Product.defaultImage AS imageFile, 
	                      CSK_Store_Product.ratingSum / CSK_Store_Product.totalRatingVotes AS rating, CSK_Store_Product.productID, 
	                      CSK_Store_ShippingEstimate.shippingEstimate
	FROM         CSK_Stats_Tracker INNER JOIN
	                      CSK_Store_Product ON CSK_Stats_Tracker.productSKU = CSK_Store_Product.sku INNER JOIN
	                      CSK_Store_ShippingEstimate ON CSK_Store_Product.shipEstimateID = CSK_Store_ShippingEstimate.shipEstimateID
	WHERE     (NOT (CSK_Store_Product.productID IN
	                          (SELECT     productID
	                            FROM          CSK_Store_OrderItem
	                            WHERE      (orderID = @orderID))))
	GROUP BY CSK_Stats_Tracker.userName, CSK_Store_Product.sku, CSK_Store_Product.productName, CSK_Store_Product.ourPrice, 
	                      CSK_Store_Product.retailPrice, CSK_Store_Product.shortDescription, CSK_Store_Product.defaultImage, 
	                      CSK_Store_Product.ratingSum / CSK_Store_Product.totalRatingVotes, CSK_Store_Product.productID, CSK_Store_ShippingEstimate.shippingEstimate, 
	                      CSK_Store_Product.statusID
	HAVING      (CSK_Stats_Tracker.userName = @userName) AND (CSK_Store_Product.statusID <> 99)
	--EXEC CSK_Stats_Tracker_GetRecentlyViewedProducts @userName
	
	--cross-sells
	SELECT     CSK_Store_Product.productID, CSK_Store_Product.sku, CSK_Store_Product.productName, CSK_Store_Product.shortDescription, 
	                      CSK_Store_Product.manufacturerID, CSK_Store_Product.attributeXML, CSK_Store_Product.statusID, CSK_Store_Product.productTypeID, 
	                      CSK_Store_Product.shippingTypeID, CSK_Store_Product.shipEstimateID, CSK_Store_Product.taxTypeID, CSK_Store_Product.stockLocation, 
	                      CSK_Store_Product.ourPrice, CSK_Store_Product.retailPrice, CSK_Store_Product.weight, CSK_Store_Product.currencyCode, 
	                      CSK_Store_Product.unitOfMeasure, CSK_Store_Product.adminComments, CSK_Store_Product.length, CSK_Store_Product.height, 
	                      CSK_Store_Product.width, CSK_Store_Product.dimensionUnit, CSK_Store_Product.isDeleted, CSK_Store_Product.listOrder, 
	                      CSK_Store_Product.ratingSum, CSK_Store_Product.totalRatingVotes, CSK_Store_Product.defaultImage, CSK_Store_Product.createdOn, 
	                      CSK_Store_Product.createdBy, CSK_Store_Product.modifiedOn, CSK_Store_Product.modifiedBy, 
	                      CSK_Store_Product.ratingSum / CSK_Store_Product.totalRatingVotes AS Rating
	FROM         CSK_Store_Product INNER JOIN
	                      CSK_Promo_Product_CrossSell_Map ON CSK_Store_Product.productID = CSK_Promo_Product_CrossSell_Map.crossProductID
	WHERE     (CSK_Promo_Product_CrossSell_Map.productID = @productID) AND (CSK_Store_Product.statusID <> 99)
	
	--also-boughts
	
	--promotions for basket page
	

	RETURN 


-- UPDATE DE IMÁGENES DE PRODUCTOS
UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00003', [productName] = N'Introducción a la Plataforma .NET con Visual Basic 2005', [shortDescription] = N'Este curso el provee a los estudiantes del conocimiento y las habilidades necesarias para desarrollar aplicaciones en Microsoft Visual Basic 2005 para la plataforma Microsoft .NET. El curso se enfoca en interfaces de usuario, estructura del programa, sintaxis del lenguaje y detalles de implementación. Este es el primer curso en el currículo de Visual Basic 2005 y servirá como punto de entrada para otros cursos de .NET.', [manufacturerID] = 1, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 3, [shippingTypeID] = 1, [shipEstimateID] = 1, [taxTypeID] = 1, [stockLocation] = N'Guayaquil', [ourPrice] = 7.0000, [retailPrice] = 12.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 3, [height] = 2, [width] = 3, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 3, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Herramientas de Desarrollo/Visual Studio/IntroNetVb2005.jpg', [createdOn] = '20060924', [createdBy] = N'admin', [modifiedOn] = '20061003', [modifiedBy] = N'admin' WHERE [productID] = 1


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00004', [productName] = N'SQL Server 2005 para Desarrolladores', [shortDescription] = N'Este curso tiene como objetivo dar a los participantes una introducción rápida al nuevo mundo del desarrollo de bases de datos con SQL Server 2005. El material cubre el manejo del nuevo entorno integrado de herramientas para desarrollador para implementar una base de datos. Se fundamentará los conceptos y principios básicos como creación Tablas, Claves, Claves Foráneas, Vistas, Queries y Procedimientos Almacenados.', [manufacturerID] = 1, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 3, [shippingTypeID] = 1, [shipEstimateID] = 1, [taxTypeID] = 1, [stockLocation] = N'Guayaquil', [ourPrice] = 7.0000, [retailPrice] = 12.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'Unidad', [adminComments] = N'', [length] = 3, [height] = 1, [width] = 2, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 4, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Bases de Datos/SQL Server/Sql2005Devs.jpg', [createdOn] = '20060924', [createdBy] = N'admin', [modifiedOn] = '20061004', [modifiedBy] = N'admin' WHERE [productID] = 2


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00001', [productName] = N'Desarrollo de Aplicaciones Windows con Visual Studio 2005', [shortDescription] = N'Este curso provee a los estudiantes el conocimiento y las habilidades para desarrollar aplicaciones Windows utilizando Visual Studio 2005. El curso se enfoca en interfaces de usuario, estructura del programa y detalles de implementación. El curso incluye código de ejemplo tanto en Visual Basic 2005 como en Visual C# 2005.', [manufacturerID] = 1, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 3, [shippingTypeID] = 1, [shipEstimateID] = 1, [taxTypeID] = 1, [stockLocation] = N'Guayaquil, Ecuador', [ourPrice] = 7.0000, [retailPrice] = 12.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 1, [height] = 5, [width] = 2, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 1, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg', [createdOn] = '20060919', [createdBy] = N'admin', [modifiedOn] = '20061004', [modifiedBy] = N'admin' WHERE [productID] = 3


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00002', [productName] = N'Desarrollo de Aplicaciones Web con Visual Studio 2005', [shortDescription] = N'Este curso provee a los estudiantes el conocimiento y las habilidades para desarrollar aplicaciones Web ASP.NE 2.0 utilizando Visual Studio 2005. El curso se enfoca en interfaces de usuario, estructura y funcionalidad del sitio Web y detalles de implementación. El curso incluye código de ejemplo tanto en Visual Basic 2005 como en Visual C# 2005.', [manufacturerID] = 1, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 3, [shippingTypeID] = 1, [shipEstimateID] = 1, [taxTypeID] = 1, [stockLocation] = N'Guayaquil', [ourPrice] = 7.0000, [retailPrice] = 12.0000, [weight] = 3.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 3, [height] = 2, [width] = 3, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 2, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Herramientas de Desarrollo/Visual Studio/WebAppsVs2005.jpg', [createdOn] = '20060924', [createdBy] = N'admin', [modifiedOn] = '20061004', [modifiedBy] = N'admin' WHERE [productID] = 4


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00005', [productName] = N'Desarrollo de Aplicaciones Windows con Visual Studio 2005 (Digital)', [shortDescription] = N'Este curso provee a los estudiantes el conocimiento y las habilidades para desarrollar aplicaciones Windows utilizando Visual Studio 2005. El curso se enfoca en interfaces de usuario, estructura del programa y detalles de implementación. El curso incluye código de ejemplo tanto en Visual Basic 2005 como en Visual C# 2005.', [manufacturerID] = 1, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 1, [shippingTypeID] = 3, [shipEstimateID] = 1, [taxTypeID] = 2, [stockLocation] = N'Guayaquil, Ecuador', [ourPrice] = 5.0000, [retailPrice] = 9.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 1, [height] = 5, [width] = 2, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 5, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg', [createdOn] = '20061004', [createdBy] = N'admin', [modifiedOn] = '20061004', [modifiedBy] = N'admin' WHERE [productID] = 5


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00006', [productName] = N'Optimice su PC con XP (Digital)', [shortDescription] = N'Usted puede optimizar el rendimiento de su computadora solo con modificar ciertas configuraciones de su sistema operativo. Si pone en práctica los concejos que contiene esta guía, Usted conseguirá que Windows y sus aplicaciones aceleren el arranque y aprovechen mejor los recursos de su PC.', [manufacturerID] = 2, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 1, [shippingTypeID] = 3, [shipEstimateID] = 1, [taxTypeID] = 2, [stockLocation] = N'Guayaquil, Ecuador', [ourPrice] = 5.0000, [retailPrice] = 9.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 2, [height] = 3, [width] = 1, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 6, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Sistemas Operativos/Windows/CursoOptimizacionXpPeq.jpg', [createdOn] = '20061004', [createdBy] = N'admin', [modifiedOn] = '20061004', [modifiedBy] = N'admin' WHERE [productID] = 6


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00007', [productName] = N'Lo Nuevo de Excel 2007', [shortDescription] = N'Este curso presenta las nuevas características y funcionalidad de la última versión de Microsoft Office Excel. Ha habido substanciales cambios a la interfaz gráfica en esta aplicación de hoja de cálculo y este curso le ayudará a conocer rápidamente todas las nuevas funcionalidades. Este curso cubre las nuevas características que le permiten organizar y analizar información del negocio en Office Excel 2007.', [manufacturerID] = 1, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 4, [shippingTypeID] = 1, [shipEstimateID] = 1, [taxTypeID] = 1, [stockLocation] = N'Guayaquil', [ourPrice] = 7.0000, [retailPrice] = 12.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 3, [height] = 2, [width] = 3, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 7, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Utilitarios/Office/Office2007ProBox.jpg', [createdOn] = '20061105', [createdBy] = N'admin', [modifiedOn] = '20061105', [modifiedBy] = N'admin' WHERE [productID] = 10


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00008', [productName] = N'Lo Nuevo de Word 2007', [shortDescription] = N'Este curso presenta las nuevas características y funcionalidad de la última versión de Microsoft Office Word. Ha habido substanciales cambios a la interfaz gráfica en esta aplicación de procesamiento de palabras y este curso le ayudará a conocer rápidamente todas las nuevas funcionalidades. Este curso cubre las nuevas características que le permiten crear documentos con apariencia profesional en Office Word.', [manufacturerID] = 1, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 4, [shippingTypeID] = 1, [shipEstimateID] = 1, [taxTypeID] = 1, [stockLocation] = N'Guayaquil', [ourPrice] = 7.0000, [retailPrice] = 12.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 3, [height] = 2, [width] = 3, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 8, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Utilitarios/Office/Office2007StdBox.jpg', [createdOn] = '20061105', [createdBy] = N'admin', [modifiedOn] = '20061105', [modifiedBy] = N'admin' WHERE [productID] = 11


UPDATE [dbo].[CSK_Store_Product] SET 
[sku] = N'00009', [productName] = N'Oracle Database 10g: Introducción a SQL (Digital)', [shortDescription] = N'Este curso presenta la tecnología de Oracle Database 20g y los conceptos de bases de datos relacionales y el poderoso lenguaje de programación SQL. Este curso provee al estudiante las habilidades SQL escenciales para consultar la base de datos, la meta data y la creación de objetos de base de datos. ', [manufacturerID] = 3, [attributeXML] = N'', [statusID] = 1, [productTypeID] = 1, [shippingTypeID] = 3, [shipEstimateID] = 1, [taxTypeID] = 2, [stockLocation] = N'Guayaquil', [ourPrice] = 7.0000, [retailPrice] = 12.0000, [weight] = 2.0000, [currencyCode] = 'USD', [unitOfMeasure] = N'unidad', [adminComments] = N'', [length] = 3, [height] = 2, [width] = 3, [dimensionUnit] = 'centímetro', [isDeleted] = 0, [listOrder] = 9, [ratingSum] = 4, [totalRatingVotes] = 1, [defaultImage] = N'images/productimages/Bases de Datos/Oracle/Oracle10gSQL.jpg', [createdOn] = '20061105', [createdBy] = N'admin', [modifiedOn] = '20061105', [modifiedBy] = N'admin' WHERE [productID] = 12