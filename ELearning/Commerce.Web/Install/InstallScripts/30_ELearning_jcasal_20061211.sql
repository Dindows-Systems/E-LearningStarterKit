-- UPDATE A CSK_Content_Text
UPDATE [dbo].[CSK_Content_Text] SET 
[contentGUID] = '17e365cd-bb41-4365-81c1-f910b5b05633', [title] = N'', [contentName] = N'CheckoutTopLeft', [content] = N'
		<p>
				<strong>¿Qué ocurre cuando coloca su orden?<br /></strong>Cuando presiona el botón "Colocar su orden", le enviaremos un e-mail notificándole la recepción de su orden. Su contrato para comprar un item no estará completo hasta que le enviemos un e-mail notificándole que el item ha sido enviado. </p>
		<p>
				<strong>Política de Devoluciones:</strong> Dentro de los 30 días de la entrega, usted puede retornar mercadería nueva que se encuentre en su condición original. Aplican excepciones y restricciones--lea nuestra <a href="./DevolutionsPolicy.aspx">Política de Devoluciones</a> completa.<br /></p>', [iconPath] = N'', [dateExpires] = NULL, [contentGroupID] = 0, [lastEditedBy] = NULL, [externalLink] = N'', [status] = N'', [listOrder] = 1, [callOut] = N'', [createdOn] = '20060807', [createdBy] = N'', [modifiedOn] = '20060807', [modifiedBy] = NULL WHERE [contentID] = 5


-- UPDATE A CSK_STORE_AD
UPDATE [dbo].[CSK_Store_Ad] SET 
[pageName] = N'default.aspx', [listOrder] = 0, [placement] = N'Center', [adText] = N'<H1><FONT face=Verdana>Aprende&nbsp;.Net y Visual Studio 2005</FONT></H1>
<TABLE>
<TBODY>
<TR>
<TD width=130>
<P><STRONG><A href="product/00003.aspx"><IMG src="images/ProductImages/Herramientas%20de%20Desarrollo/Visual%20Studio/IntroNetVb2005.jpg"></A></STRONG></P>
<P><STRONG><A href="product/00003.aspx">Introducción a la Plataforma .NET con Visual Basic 2005</A></STRONG> <BR>La mejor forma de dar los primeros pasos con .NET y Visual Basic 2005</P></TD>
<TD width=130>
<P><STRONG><A href="product/00001.aspx"><IMG src="images/ProductImages/Herramientas%20de%20Desarrollo/Visual%20Studio/WinAppsVs2005.jpg"></A></STRONG></P>
<P><STRONG><A href="product/00003.aspx">Desarrollo de Aplicaciones Windows con Visual Studio 2005</A> <BR></STRONG>Crea paso a paso las mejores interfaces Windows con Visual Studio 2005</P></TD>
<TD width=130>
<P><A href="product/00002.aspx"><IMG src="images/ProductImages/Herramientas%20de%20Desarrollo/Visual%20Studio/WebAppsVs2005.jpg"></A></P>
<P><STRONG><A href="product/00003.aspx">Desarrollo de Aplicaciones Web con Visual Studio 2005</A></STRONG> <BR>Conoce lo fácil que es crear tu propio Sitio Web con Visual Studio 2005</P></TD></TR></TBODY></TABLE>', [productSku] = N'0', [promoID] = 0, [categoryID] = 15, [dateExpires] = '20070220', [isActive] = 1, [isDeleted] = 0, [createdOn] = '20060930', [createdBy] = NULL, [modifiedOn] = '20061112', [modifiedBy] = N'admin' WHERE [adID] = 2


-- UPDATE A aspnet_Profile
UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:39:LastShippingAddress:S:39:474:RecentlyViewedProducts:S:513:620:CurrentOrderShipping:S:1133:66:CurrentOrderTax:S:1199:66:LastBillingAddress:S:1265:526:FavoriteCategories:S:1791:162:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $ 0,60<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="AZ" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-06T23:50:30</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-06T23:50:30</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00006</ItemNumber>
    <ItemName>Optimice su PC con XP (Digital)</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-11-06T23:50:22.015625-05:00</LastVisited>
    <ImagePath>images/productimages/Sistemas Operativos/Windows/CursoOptimizacionXpPeq.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="Alex" LastName="Armijos" Email="alex_armijos@yahoo.com" Address1="Samanes 1 " Address2="" City="Guayaquil" StateOrRegion="GY" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-06T23:51:38</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-06T23:51:38</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061107' WHERE [UserId] = '07676cc3-5b16-40ee-a9aa-2a313196cfb8'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:39:LastShippingAddress:S:39:511:RecentlyViewedProducts:S:550:1963:CurrentOrderShipping:S:2513:66:CurrentOrderTax:S:2579:66:LastBillingAddress:S:2645:511:FavoriteCategories:S:3156:489:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $ 0,60<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="El " LastName="Test 12" Email="test12@algo.com" Address1="Sauces" Address2="" City="Ibarra" StateOrRegion="IM" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-03T23:52:11</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-03T23:52:11</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00009</ItemNumber>
    <ItemName>Oracle Database 10g: Introducción a SQL (Digital)</ItemName>
    <ItemCount>0</ItemCount>
    <LastVisited>2006-11-06T22:03:54.96875-05:00</LastVisited>
    <ImagePath>images/productimages/Bases de Datos/Oracle/Oracle10gSQL.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00008</ItemNumber>
    <ItemName>Lo Nuevo de Word 2007</ItemName>
    <ItemCount>0</ItemCount>
    <LastVisited>2006-11-06T22:03:11.765625-05:00</LastVisited>
    <ImagePath>images/productimages/Utilitarios/Office/Office2007StdBox.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00003</ItemNumber>
    <ItemName>Introducción a la Plataforma .NET con Visual Basic 2005</ItemName>
    <ItemCount>2</ItemCount>
    <LastVisited>2006-11-03T23:52:05.765625-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/IntroNetVb2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00001</ItemNumber>
    <ItemName>Desarrollo de Aplicaciones Windows con Visual Studio 2005</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-11-03T23:45:57.859375-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>0.8400</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="El " LastName="Test 12" Email="test12@algo.com" Address1="Sauces" Address2="" City="Ibarra" StateOrRegion="IM" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-03T23:52:15</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-03T23:52:15</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>visualstudio</ItemName>
    <ItemCount>4</ItemCount>
    <LastVisited>2006-11-03T23:45:55.6875-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061107' WHERE [UserId] = '78440fd6-40c1-4462-b83c-354573ab5ef2'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:39:LastShippingAddress:S:39:474:RecentlyViewedProducts:S:513:162:CurrentOrderShipping:S:675:66:CurrentOrderTax:S:741:66:LastBillingAddress:S:807:536:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $ 0,60<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="AZ" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-10-22T03:06:28</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-10-22T03:06:28</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" /><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="Alex" LastName="Armijos" Email="alex_armijos@yahoo.com" Address1="samanes 1 mz 122 v 9" Address2="" City="Guayaquil" StateOrRegion="GY" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-10-22T03:06:35</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-10-22T03:06:35</ModifiedOn>
  <CreatedBy />
</Address>', [LastUpdatedDate] = '20061022' WHERE [UserId] = 'cabf04d4-662a-4cf1-b8f6-405f9d9fde95'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:650:FavoriteCategories:S:650:492:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00001</ItemNumber>
    <ItemName>Desarrollo de Aplicaciones Windows con Visual Studio 2005</ItemName>
    <ItemCount>0</ItemCount>
    <LastVisited>2006-10-04T08:15:55.4173856-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>visualstudio</ItemName>
    <ItemCount>9</ItemCount>
    <LastVisited>2006-10-04T08:07:28.5886016-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061004' WHERE [UserId] = 'f494e42d-7e6a-447d-920b-5a9b86d33139'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061104' WHERE [UserId] = '4eae6707-4247-4dd1-a611-60233fe2dd54'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061103' WHERE [UserId] = '6be01cbd-4ae6-4eaf-a19d-62a81233a0e6'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:39:LastShippingAddress:S:39:474:RecentlyViewedProducts:S:513:1089:CurrentOrderShipping:S:1602:66:CurrentOrderTax:S:1668:66:LastBillingAddress:S:1734:504:FavoriteCategories:S:2238:489:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $ 0,60<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="AZ" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-12T15:01:21</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-12T15:01:21</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00004</ItemNumber>
    <ItemName>SQL Server 2005 para Desarrolladores</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-11-12T14:37:13.171875-05:00</LastVisited>
    <ImagePath>images/productimages/Bases de Datos/SQL Server/Sql2005Devs.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00005</ItemNumber>
    <ItemName>Desarrollo de Aplicaciones Windows con Visual Studio 2005 (Digital)</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-11-12T14:36:19.859375-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="dsd" LastName="sdsd" Email="sdsd@ddfd.com" Address1="sdsd" Address2="sds" City="sss" StateOrRegion="AZ" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-12T14:53:43</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-12T14:53:43</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>visualstudio</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-11-12T14:36:17.5625-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061112' WHERE [UserId] = '8c35c2dd-1d94-430a-8ac7-7c0991886a33'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:39:LastShippingAddress:S:39:474:RecentlyViewedProducts:S:513:602:CurrentOrderShipping:S:1115:66:CurrentOrderTax:S:1181:66:LastBillingAddress:S:1247:508:FavoriteCategories:S:1755:162:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $ 1,20<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="AZ" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-10-04T19:32:54</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-10-04T19:32:54</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00006</ItemNumber>
    <ItemName>Optimice su PC con XP (Digital)</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-10-04T19:05:34.7565136-05:00</LastVisited>
    <ImagePath>images/productimages/Sistemas Operativos/Windows/CursoOptimizacionXpPeq.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<decimal>1.2000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>1.2000</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="byron" LastName="mora" Email="bmora79@yAHOO.ES" Address1="b" Address2="b" City="Machala" StateOrRegion="EO" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-10-04T19:33:05</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-10-04T19:33:05</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061005' WHERE [UserId] = '3a455add-7a05-4e59-94df-7f229049e841'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:FavoriteCategories:S:162:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" /><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061004' WHERE [UserId] = '784f3eba-19dc-42b0-abc8-828f2fa6d66d'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061112' WHERE [UserId] = '97d75942-754d-4d6e-83b0-851a90f07b0e'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061107' WHERE [UserId] = '744bd37e-4a62-40b8-a89d-8590c17d9d84'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:39:LastShippingAddress:S:39:470:RecentlyViewedProducts:S:509:620:CurrentOrderShipping:S:1129:66:CurrentOrderTax:S:1195:61:LastBillingAddress:S:1256:470:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $ 0,90<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="" Zip="" Country="">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-06T22:24:52</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-06T22:24:52</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00006</ItemNumber>
    <ItemName>Optimice su PC con XP (Digital)</ItemName>
    <ItemCount>0</ItemCount>
    <LastVisited>2006-11-06T22:29:49.984375-05:00</LastVisited>
    <ImagePath>images/productimages/Sistemas Operativos/Windows/CursoOptimizacionXpPeq.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<decimal>0.9000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>0</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="" Zip="" Country="">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-06T22:24:52</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-06T22:24:52</ModifiedOn>
  <CreatedBy />
</Address>', [LastUpdatedDate] = '20061107' WHERE [UserId] = '3fd3abcb-a997-412b-a64e-874dd2b2a49b'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:FavoriteCategories:S:162:492:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" /><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>visualstudio</ItemName>
    <ItemCount>0</ItemCount>
    <LastVisited>2006-10-04T11:35:35.3764928-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061004' WHERE [UserId] = '2bca4f45-d0e9-441a-8759-8cf5182c9bd0'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061104' WHERE [UserId] = '6151e493-4bbf-4a1f-b920-965035c8b171'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:38:LastShippingAddress:S:38:470:RecentlyViewedProducts:S:508:2440:CurrentOrderShipping:S:2948:66:CurrentOrderTax:S:3014:61:LastBillingAddress:S:3075:470:FavoriteCategories:S:3545:492:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $0.90<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="" Zip="" Country="">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-10-03T20:27:07</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-10-03T20:27:07</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00001</ItemNumber>
    <ItemName>Desarrollo de Aplicaciones Windows con Visual Studio 2005</ItemName>
    <ItemCount>0</ItemCount>
    <LastVisited>2006-11-12T17:57:41.828125-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00006</ItemNumber>
    <ItemName>Optimice su PC con XP (Digital)</ItemName>
    <ItemCount>4</ItemCount>
    <LastVisited>2006-10-04T06:00:36.5026576-05:00</LastVisited>
    <ImagePath>images/productimages/Sistemas Operativos/Windows/CursoOptimizacionXpPeq.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00004</ItemNumber>
    <ItemName>SQL Server 2005 para Desarrolladores</ItemName>
    <ItemCount>6</ItemCount>
    <LastVisited>2006-10-03T05:48:36.671875-05:00</LastVisited>
    <ImagePath>images/productimages/Bases de Datos/SQL Server/Sql2005Devs.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00002</ItemNumber>
    <ItemName>Desarrollo de Aplicaciones Web con Visual Studio 2005</ItemName>
    <ItemCount>11</ItemCount>
    <LastVisited>2006-09-30T08:51:23.375-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/WebAppsVs2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00003</ItemNumber>
    <ItemName>Introducción a la Plataforma .NET con Visual Basic 2005</ItemName>
    <ItemCount>12</ItemCount>
    <LastVisited>2006-09-30T08:51:11.3125-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/IntroNetVb2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<decimal>0.9000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>0</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="" LastName="" Email="" Address1="" Address2="" City="" StateOrRegion="" Zip="" Country="">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-10-03T20:27:07</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-10-03T20:27:07</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>visualstudio</ItemName>
    <ItemCount>34</ItemCount>
    <LastVisited>2006-09-30T08:51:06.421875-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061112' WHERE [UserId] = 'ed86b0b6-89d6-4f6a-a303-a9245b3e205e'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:FavoriteCategories:S:162:492:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" /><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>visualstudio</ItemName>
    <ItemCount>0</ItemCount>
    <LastVisited>2006-10-09T09:56:46.1442608-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061009' WHERE [UserId] = '1034bf29-960c-4383-957d-bec96b0e1d6b'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061103' WHERE [UserId] = '556a5041-bbf4-435f-9195-ca2ebd01fd6f'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:162:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', [LastUpdatedDate] = '20061022' WHERE [UserId] = '2e7d7dbc-3abc-4a82-9e83-d90e27c14ef0'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'CurrentOrderShippingMethod:S:0:39:LastShippingAddress:S:39:524:RecentlyViewedProducts:S:563:2459:CurrentOrderShipping:S:3022:66:CurrentOrderTax:S:3088:66:LastBillingAddress:S:3154:524:FavoriteCategories:S:3678:492:', [PropertyValuesString] = N'Servientrega Mercancía Premiere: $ 0,60<?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="Julio" LastName="Casal" Email="julio_casal@hotmail.com" Address1="Sauces 7" Address2="" City="Guayaquil" StateOrRegion="GY" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-12T14:18:32</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-12T14:18:32</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00005</ItemNumber>
    <ItemName>Desarrollo de Aplicaciones Windows con Visual Studio 2005 (Digital)</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-11-12T14:35:09.703125-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00006</ItemNumber>
    <ItemName>Optimice su PC con XP (Digital)</ItemName>
    <ItemCount>4</ItemCount>
    <LastVisited>2006-11-11T23:22:13.421875-05:00</LastVisited>
    <ImagePath>images/productimages/Sistemas Operativos/Windows/CursoOptimizacionXpPeq.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00004</ItemNumber>
    <ItemName>SQL Server 2005 para Desarrolladores</ItemName>
    <ItemCount>13</ItemCount>
    <LastVisited>2006-11-11T23:20:44.71875-05:00</LastVisited>
    <ImagePath>images/productimages/Bases de Datos/SQL Server/Sql2005Devs.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00003</ItemNumber>
    <ItemName>Introducción a la Plataforma .NET con Visual Basic 2005</ItemName>
    <ItemCount>7</ItemCount>
    <LastVisited>2006-11-11T23:15:19.609375-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/IntroNetVb2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00001</ItemNumber>
    <ItemName>Desarrollo de Aplicaciones Windows con Visual Studio 2005</ItemName>
    <ItemCount>19</ItemCount>
    <LastVisited>2006-11-11T22:50:19.71875-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/WinAppsVs2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<decimal>0.6000</decimal><?xml version="1.0" encoding="utf-16"?>
<decimal>5.0400</decimal><?xml version="1.0" encoding="utf-16"?>
<Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" AddressID="0" UserName="" FirstName="Julio" LastName="Casal" Email="julio_casal@hotmail.com" Address1="Sauces 7" Address2="" City="Guayaquil" StateOrRegion="GY" Zip="" Country="EC">
  <IsLoaded>false</IsLoaded>
  <IsNew>true</IsNew>
  <CreatedOn>2006-11-12T14:18:59</CreatedOn>
  <ModifiedBy />
  <ModifiedOn>2006-11-12T14:18:59</ModifiedOn>
  <CreatedBy />
</Address><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>visualstudio</ItemName>
    <ItemCount>15</ItemCount>
    <LastVisited>2006-11-11T22:50:13.640625-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061112' WHERE [UserId] = 'b1af4177-930e-4b7a-8609-f27db08ffd65'


UPDATE [dbo].[aspnet_Profile] SET 
[PropertyNames] = N'RecentlyViewedProducts:S:0:1067:FavoriteCategories:S:1067:504:', [PropertyValuesString] = N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00003</ItemNumber>
    <ItemName>Introducción a la Plataforma .NET con Visual Basic 2005</ItemName>
    <ItemCount>1</ItemCount>
    <LastVisited>2006-10-14T16:46:29.4292239-05:00</LastVisited>
    <ImagePath>images/productimages/Herramientas de Desarrollo/Visual Studio/IntroNetVb2005.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>00006</ItemNumber>
    <ItemName>Optimice su PC con XP (Digital)</ItemName>
    <ItemCount>4</ItemCount>
    <LastVisited>2006-10-14T16:28:33.2358204-05:00</LastVisited>
    <ImagePath>images/productimages/Sistemas Operativos/Windows/CursoOptimizacionXpPeq.jpg</ImagePath>
    <SortingBy>LastVisited</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem><?xml version="1.0" encoding="utf-16"?>
<ArrayOfTrackedItem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <TrackedItem>
    <ItemID>0</ItemID>
    <ItemNumber>0</ItemNumber>
    <ItemName>herramientasdedesarrollo</ItemName>
    <ItemCount>4</ItemCount>
    <LastVisited>2006-10-14T16:16:36.0063354-05:00</LastVisited>
    <SortingBy>ItemCount</SortingBy>
    <SortingOrder>Descending</SortingOrder>
  </TrackedItem>
</ArrayOfTrackedItem>', [LastUpdatedDate] = '20061019' WHERE [UserId] = 'f13c90ec-6405-471f-bc67-f5f6404e5875'



