SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_AttributeType]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_AttributeType](
	[attributeTypeID] [int] IDENTITY(1,1) NOT NULL,
	[attributeType] [nvarchar](50) NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_AttributeType_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_AttributeType_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductAttributeTypes] PRIMARY KEY CLUSTERED 
(
	[attributeTypeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Category]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Category](
	[categoryID] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](150) NOT NULL,
	[imageFile] [nvarchar](150) NULL,
	[parentID] [int] NULL CONSTRAINT [DF_CMRC_ProductCategories_parentID]  DEFAULT (0),
	[shortDescription] [nvarchar](500) NULL,
	[longDescription] [nvarchar](4000) NULL,
	[listOrder] [int] NOT NULL CONSTRAINT [DF_CMRC_ProductCategories_listOrder]  DEFAULT (1),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Category_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Category_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductCategories] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Messaging_Mailer]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Messaging_Mailer](
	[mailerID] [int] IDENTITY(1,1) NOT NULL,
	[mailerName] [nvarchar](50) NOT NULL,
	[toList] [nvarchar](500) NULL,
	[ccList] [nvarchar](500) NULL,
	[fromName] [nvarchar](50) NOT NULL,
	[fromEmail] [nvarchar](50) NOT NULL,
	[subject] [nvarchar](50) NOT NULL,
	[messageBody] [nvarchar](3500) NOT NULL,
	[isHTML] [bit] NOT NULL CONSTRAINT [DF_CMRC_Mailers_isHTML]  DEFAULT (0),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Messaging_Mailer_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Messaging_Mailer_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Mailers] PRIMARY KEY CLUSTERED 
(
	[mailerID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ProductReview]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ProductReview](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL CONSTRAINT [DF_CMRC_Reviews_Title]  DEFAULT (''),
	[Body] [ntext] NOT NULL CONSTRAINT [DF_CMRC_Reviews_Body]  DEFAULT (''),
	[PostDate] [datetime] NOT NULL CONSTRAINT [DF_CMRC_Reviews_PostDate]  DEFAULT (getdate()),
	[AuthorName] [nvarchar](256) NOT NULL CONSTRAINT [DF_CMRC_Reviews_AuthorName]  DEFAULT (''),
	[Rating] [int] NOT NULL CONSTRAINT [DF_CMRC_ProductReviews_Rating]  DEFAULT (0),
	[IsApproved] [bit] NOT NULL CONSTRAINT [DF_CMRC_Reviews_IsApproved]  DEFAULT (0),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Review_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Review_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Reviews] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ProductStatus]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ProductStatus](
	[statusID] [int] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ProductStatus_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ProductStatus_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductStatus] PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Campaign]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Promo_Campaign](
	[campaignID] [int] IDENTITY(1,1) NOT NULL,
	[campaignName] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NOT NULL,
	[objective] [nvarchar](500) NULL,
	[revenueGoal] [money] NULL CONSTRAINT [DF_CMRC_PROMO_Campaigns_revenueGoal]  DEFAULT (0),
	[inventoryGoal] [int] NULL CONSTRAINT [DF_CMRC_PROMO_Campaigns_inventoryGoal]  DEFAULT (0),
	[dateEnd] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_CMRC_PROMO_Campaigns_isActive]  DEFAULT (1),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_Campaign_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_Campaign_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_PROMO_Campaigns] PRIMARY KEY CLUSTERED 
(
	[campaignID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Stats_TrackedItem]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Stats_TrackedItem](
	[itemID] [int] IDENTITY(1,1) NOT NULL,
	[itemName] [nvarchar](250) NOT NULL,
	[itemNumber] [nvarchar](150) NOT NULL,
	[imagePath] [nvarchar](250) NULL,
	[trackedItemType] [int] NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Stats_TrackedItem_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Stats_TrackedItem_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CSK_Stats_TrackedItem] PRIMARY KEY CLUSTERED 
(
	[itemID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ShippingEstimate]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ShippingEstimate](
	[shipEstimateID] [int] IDENTITY(1,1) NOT NULL,
	[shippingEstimate] [nvarchar](150) NOT NULL,
	[leadTimeDays] [int] NOT NULL CONSTRAINT [DF_CMRC_ShipEstimates_leadTimeDays]  DEFAULT (1),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ShippingEstimate_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ShippingEstimate_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ShipEstimates] PRIMARY KEY CLUSTERED 
(
	[shipEstimateID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ProductType]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ProductType](
	[productTypeID] [int] IDENTITY(1,1) NOT NULL,
	[productType] [nvarchar](50) NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ProductType_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ProductType_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductType] PRIMARY KEY CLUSTERED 
(
	[productTypeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_CouponTypes]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_CouponTypes](
	[CouponTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](128) NOT NULL,
	[ProcessingClassName] [nvarchar](256) NOT NULL,
	[IsAspClass] [bit] NOT NULL CONSTRAINT [DF_CSK_CouponTypes_IsAspClass]  DEFAULT ((0)),
 CONSTRAINT [PK_CMRC_CouponTypes] PRIMARY KEY CLUSTERED 
(
	[CouponTypeId] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ShippingType]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ShippingType](
	[shippingTypeID] [int] IDENTITY(1,1) NOT NULL,
	[shippingType] [nvarchar](50) NOT NULL,
	[shippingCode] [nvarchar](10) NULL,
	[isDownloadable] [bit] NOT NULL CONSTRAINT [DF_CMRC_ShippingType_isDownloadable]  DEFAULT (0),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ShippingType_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ShippingType_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ShippingType] PRIMARY KEY CLUSTERED 
(
	[shippingTypeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Ad]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Ad](
	[adID] [int] IDENTITY(1,1) NOT NULL,
	[pageName] [nvarchar](50) NULL,
	[listOrder] [int] NOT NULL CONSTRAINT [DF_CMRC_Ads_listOrder]  DEFAULT ((1)),
	[placement] [nvarchar](50) NOT NULL,
	[adText] [nvarchar](2500) NOT NULL,
	[productSku] [nvarchar](50) NULL CONSTRAINT [DF_CMRC_Ads_productID]  DEFAULT (''),
	[promoID] [int] NULL CONSTRAINT [DF_CMRC_Ads_promoID]  DEFAULT ((0)),
	[categoryID] [int] NULL CONSTRAINT [DF_CMRC_Ads_categoryID]  DEFAULT ((0)),
	[dateExpires] [datetime] NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_CMRC_Ads_isActive]  DEFAULT ((1)),
	[isDeleted] [bit] NOT NULL CONSTRAINT [DF_CMRC_Ads_isDeleted]  DEFAULT ((0)),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Ad_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Ad_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Ads] PRIMARY KEY CLUSTERED 
(
	[adID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Stats_Behavior]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Stats_Behavior](
	[behaviorID] [int] IDENTITY(1,1) NOT NULL,
	[behavior] [nvarchar](50) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Stats_Behavior_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Stats_Behavior_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_STATS_Behavior] PRIMARY KEY CLUSTERED 
(
	[behaviorID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Tax_Rate]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Tax_Rate](
	[rateID] [int] IDENTITY(1,1) NOT NULL,
	[rate] [money] NOT NULL,
	[state] [varchar](50) NOT NULL,
	[zipCode] [varchar](50) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Tax_Rate_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Tax_Rate_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Taxes] PRIMARY KEY CLUSTERED 
(
	[rateID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Content_Group]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Content_Group](
	[groupID] [int] NOT NULL,
	[contentGroup] [varchar](50) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Content_Group_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Content_Group_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PPSD_ContentGroups] PRIMARY KEY CLUSTERED 
(
	[groupID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Tax_Type]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Tax_Type](
	[taxTypeID] [int] IDENTITY(1,1) NOT NULL,
	[taxType] [nvarchar](50) NOT NULL,
	[taxCode] [nvarchar](10) NULL,
	[isExempt] [bit] NOT NULL CONSTRAINT [DF_CMRC_TaxTypes_isExempt]  DEFAULT (0),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Tax_Type_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Tax_Type_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_TaxTypes] PRIMARY KEY CLUSTERED 
(
	[taxTypeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ProductReviewFeedback]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ProductReviewFeedback](
	[feedbackID] [int] IDENTITY(1,1) NOT NULL,
	[ReviewID] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL CONSTRAINT [DF_CMRC_ProductReviewFeedback_UserName]  DEFAULT (''),
	[IsHelpful] [bit] NOT NULL CONSTRAINT [DF_CMRC_ReviewHelpfulness_Helpful]  DEFAULT ((0)),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ReviewFeedback_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_ReviewFeedback_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ReviewHelpfulness] PRIMARY KEY CLUSTERED 
(
	[feedbackID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Coupons_GetCoupon]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[CSK_Coupons_GetCoupon] 
	(
	@couponCode nvarchar(30)
	)
AS
	SELECT 
		C.CouponCode, 
		C.CouponTypeId, 
		C.IsSingleUse, 
		C.UserId, 
		C.NumberUses, 
		C.ExpirationDate, 
		C.XmlData 
	FROM 
		CSK_Coupons C
	WHERE 
		C.CouponCode = @couponCode 	
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Coupons]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Coupons](
	[CouponCode] [nvarchar](30) NOT NULL,
	[CouponTypeId] [int] NOT NULL,
	[IsSingleUse] [bit] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[NumberUses] [int] NOT NULL CONSTRAINT [DF_CMRC_Coupons_NumberUses]  DEFAULT ((0)),
	[ExpirationDate] [datetime] NULL,
	[XmlData] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CMRC_Coupons] PRIMARY KEY CLUSTERED 
(
	[CouponCode] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Util_Currency]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Util_Currency](
	[codeID] [int] IDENTITY(1,1) NOT NULL,
	[code] [char](3) NOT NULL,
	[description] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_CSK_Util_Currency] PRIMARY KEY CLUSTERED 
(
	[codeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Shipping_Rate]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Shipping_Rate](
	[shippingRateID] [int] IDENTITY(1,1) NOT NULL,
	[Service] [varchar](50) NOT NULL,
	[Rate] [money] NULL,
	[AmountPerUnit] [money] NOT NULL,
	[isAirOnly] [bit] NOT NULL CONSTRAINT [DF_CSK_Shipping_Rate_IsAirOnly]  DEFAULT ((0)),
	[isGroundOnly] [bit] NOT NULL CONSTRAINT [DF_CSK_Shipping_Rate_isGroundOnly]  DEFAULT ((0)),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Shipping_Rate_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Shipping_Rate_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ShippingRates] PRIMARY KEY CLUSTERED 
(
	[shippingRateID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Content_Text]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Content_Text](
	[contentID] [int] IDENTITY(1,1) NOT NULL,
	[contentGUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CONTENT_Text_contentGUID]  DEFAULT (newid()),
	[title] [nvarchar](500) NULL,
	[contentName] [nvarchar](50) NOT NULL,
	[content] [nvarchar](3500) NULL,
	[iconPath] [nvarchar](250) NULL,
	[dateExpires] [datetime] NULL,
	[contentGroupID] [int] NOT NULL CONSTRAINT [DF_PPSD_Content_contentGroupID]  DEFAULT ((0)),
	[lastEditedBy] [nvarchar](100) NULL,
	[externalLink] [nvarchar](250) NULL,
	[status] [nvarchar](50) NULL,
	[listOrder] [int] NOT NULL CONSTRAINT [DF_CONTENT_Text_listOrder]  DEFAULT ((1)),
	[callOut] [nvarchar](250) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Content_Text_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Content_Text_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CONTENT_Text] PRIMARY KEY CLUSTERED 
(
	[contentID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Ad_Text]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Ad_Text](
	[adTextID] [int] IDENTITY(1,1) NOT NULL,
	[adID] [int] NOT NULL,
	[adText] [nvarchar](1500) NOT NULL,
	[language] [nvarchar](10) NOT NULL CONSTRAINT [DF_CSK_Store_Ad_Text_language]  DEFAULT (N'en-US'),
 CONSTRAINT [PK_CSK_Store_Ad_Text] PRIMARY KEY CLUSTERED 
(
	[adTextID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Util_Country]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Util_Country](
	[countryID] [int] IDENTITY(1,1) NOT NULL,
	[code] [char](2) NOT NULL,
	[country] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_CSK_Util_Country] PRIMARY KEY CLUSTERED 
(
	[countryID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Util_ZipCode]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Util_ZipCode](
	[zipCodeID] [int] IDENTITY(1,1) NOT NULL,
	[stateAbbreviation] [nvarchar](2) NULL,
	[zipCode] [nvarchar](12) NULL,
 CONSTRAINT [PK_CSK_Util_ZipCode] PRIMARY KEY CLUSTERED 
(
	[zipCodeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ProductRating]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ProductRating](
	[ratingID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[Rating] [int] NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Rating_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Rating_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductRating] PRIMARY KEY CLUSTERED 
(
	[ratingID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[WordCount]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[WordCount]
(@Word VARCHAR(15),
@Phrase VARCHAR(1000))
RETURNS SMALLINT
AS
BEGIN

/* If @Word or @Phrase is NULL the function returns 0 */
IF @Word IS NULL OR @Phrase IS NULL RETURN 0

/* @BiggerWord is a string one character longer than @Word */
DECLARE @BiggerWord VARCHAR(21)
SELECT @BiggerWord = @Word + ''x''

/* Replace @Word with @BiggerWord in @Phrase */
DECLARE @BiggerPhrase VARCHAR(2000)
SELECT @BiggerPhrase = REPLACE (@Phrase, @Word, @BiggerWord)

/* The length difference between @BiggerPhrase and @phrase
   is the number we''''re looking for */
RETURN LEN(@BiggerPhrase) - LEN(@Phrase)
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Address]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Address](
	[addressID] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NULL,
	[address1] [nvarchar](50) NOT NULL,
	[address2] [nvarchar](50) NULL,
	[city] [nvarchar](50) NOT NULL,
	[stateOrRegion] [nvarchar](50) NOT NULL,
	[zip] [nvarchar](50) NOT NULL,
	[country] [nvarchar](50) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Address_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Address_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_AddressBook] PRIMARY KEY CLUSTERED 
(
	[addressID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Bundle]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Promo_Bundle](
	[bundleID] [int] IDENTITY(1,1) NOT NULL,
	[bundleName] [nvarchar](50) NOT NULL CONSTRAINT [DF_CMRC_Bundles_bundleName]  DEFAULT (0),
	[discountPercent] [int] NOT NULL CONSTRAINT [DF_CMRC_Bundles_discountPercent]  DEFAULT (0),
	[description] [nvarchar](500) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_Bundle_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_Bundle_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Bundles] PRIMARY KEY CLUSTERED 
(
	[bundleID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Config]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Config](
	[settingID] [int] IDENTITY(1,1) NOT NULL,
	[attribute] [nvarchar](50) NOT NULL,
	[setting] [nvarchar](150) NOT NULL,
	[dataType] [nvarchar](50) NOT NULL CONSTRAINT [DF_CMRC_Config_dataType]  DEFAULT (N'System.String'),
	[description] [nvarchar](250) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Config_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Config_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Config] PRIMARY KEY CLUSTERED 
(
	[settingID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Manufacturer]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Manufacturer](
	[manufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[manufacturer] [nvarchar](50) NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Manufacturer_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Manufacturer_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Manufacturers] PRIMARY KEY CLUSTERED 
(
	[manufacturerID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_OrderStatus]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_OrderStatus](
	[OrderStatusID] [int] NOT NULL,
	[OrderStatus] [nvarchar](50) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_OrderStatus_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_OrderStatus_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [aaaaaCMRC_OrderStatus_PK] PRIMARY KEY NONCLUSTERED 
(
	[OrderStatusID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Order]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Order](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[orderGuid] [nvarchar](50) NOT NULL CONSTRAINT [DF_CSK_Store_Order_orderGuid]  DEFAULT (newid()),
	[orderNumber] [varchar](50) NULL,
	[orderDate] [smalldatetime] NOT NULL CONSTRAINT [DF_CMRC_Orders_OrderDate_1]  DEFAULT (getdate()),
	[orderStatusID] [int] NOT NULL CONSTRAINT [DF_CMRC_Orders_OrderStatusID]  DEFAULT ((0)),
	[userName] [varchar](100) NOT NULL,
	[email] [nvarchar](50) NULL,
	[firstName] [nvarchar](50) NULL,
	[lastName] [nvarchar](50) NULL,
	[shippingMethod] [varchar](100) NULL,
	[subTotalAmount] [money] NOT NULL CONSTRAINT [DF_CMRC_Orders_OrderSubTotal]  DEFAULT ((0)),
	[shippingAmount] [money] NOT NULL CONSTRAINT [DF_CMRC_Orders_Shipping_1]  DEFAULT ((0)),
	[handlingAmount] [money] NOT NULL CONSTRAINT [DF_CMRC_Orders_HandlingAmount]  DEFAULT ((0)),
	[taxAmount] [money] NOT NULL CONSTRAINT [DF_CMRC_Orders_Tax_1]  DEFAULT ((0)),
	[taxRate] [numeric](18, 0) NOT NULL CONSTRAINT [DF_CMRC_Orders_taxRate]  DEFAULT ((0)),
	[couponCodes] [nvarchar](50) NULL,
	[discountAmount] [money] NOT NULL CONSTRAINT [DF_CMRC_Orders_discountAmount]  DEFAULT ((0)),
	[specialInstructions] [nvarchar](1500) NULL,
	[shipToAddress] [nvarchar](500) NULL,
	[billToAddress] [nvarchar](500) NULL,
	[userIP] [nvarchar](50) NOT NULL,
	[shippingTrackingNumber] [nvarchar](150) NULL,
	[numberOfPackages] [int] NULL,
	[packagingNotes] [nvarchar](500) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Order_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Order_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CSK_Store_Order] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_AttributeTemplate]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_AttributeTemplate](
	[templateID] [int] IDENTITY(1,1) NOT NULL,
	[attributeName] [nvarchar](50) NOT NULL,
	[selectionList] [nvarchar](4000) NOT NULL,
	[description] [nvarchar](500) NULL,
	[attributeTypeID] [int] NOT NULL CONSTRAINT [DF_CMRC_ProductAttributeTemplates_attributeTypeID]  DEFAULT ((1)),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_AttributeTemplate_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_AttributeTemplate_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductAttributeTemplates] PRIMARY KEY CLUSTERED 
(
	[templateID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_TransactionType]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_TransactionType](
	[transactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[transactionType] [nvarchar](50) NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_TransactionType_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_TransactionType_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_OrderTransactionTypes] PRIMARY KEY CLUSTERED 
(
	[transactionTypeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Attribute]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Attribute](
	[productAttributeID] [int] IDENTITY(1,1) NOT NULL,
	[productID] [int] NOT NULL,
	[attributeName] [nvarchar](50) NOT NULL,
	[selectionList] [nvarchar](250) NOT NULL,
	[description] [nvarchar](500) NULL,
	[attributeTypeID] [int] NOT NULL CONSTRAINT [DF_CMRC_ProductAttributes_attributeTypeID]  DEFAULT (1),
	[priceAdjustment] [money] NOT NULL CONSTRAINT [DF_CMRC_ProductAttributes_priceAdjustment]  DEFAULT (0),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Attribute_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Attribute_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductAttributes] PRIMARY KEY CLUSTERED 
(
	[productAttributeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_Category_Map]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Product_Category_Map](
	[productID] [int] NOT NULL,
	[categoryID] [int] NOT NULL,
	[listOrder] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_Categories_listOrder]  DEFAULT (1),
	[isFeatured] [bit] NOT NULL CONSTRAINT [DF_CMRC_Products_Categories_isFeatured]  DEFAULT (0),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Product_Category_Map_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Product_Category_Map_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Products_Categories] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[categoryID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Product](
	[productID] [int] IDENTITY(1,1) NOT NULL,
	[sku] [nvarchar](50) NULL,
	[productName] [nvarchar](150) NOT NULL,
	[shortDescription] [nvarchar](500) NULL,
	[manufacturerID] [int] NULL,
	[attributeXML] [nvarchar](3000) NULL,
	[statusID] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_statusID]  DEFAULT ((1)),
	[productTypeID] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_productTypeID]  DEFAULT ((1)),
	[shippingTypeID] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_shippingTypeID]  DEFAULT ((1)),
	[shipEstimateID] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_shipTimeID]  DEFAULT ((1)),
	[taxTypeID] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_taxTypeID]  DEFAULT ((1)),
	[stockLocation] [nvarchar](150) NULL,
	[ourPrice] [money] NOT NULL,
	[retailPrice] [money] NOT NULL,
	[weight] [numeric](19, 4) NOT NULL CONSTRAINT [DF_CMRC_Products_weight]  DEFAULT ((0)),
	[currencyCode] [char](3) NOT NULL CONSTRAINT [DF_CMRC_Products_currencyCode]  DEFAULT ('USD'),
	[unitOfMeasure] [nvarchar](50) NULL,
	[adminComments] [nvarchar](1000) NULL,
	[length] [numeric](18, 0) NOT NULL CONSTRAINT [DF_CMRC_Products_length]  DEFAULT ((0)),
	[height] [numeric](18, 0) NOT NULL CONSTRAINT [DF_CMRC_Products_height]  DEFAULT ((0)),
	[width] [numeric](18, 0) NOT NULL CONSTRAINT [DF_CMRC_Products_width]  DEFAULT ((0)),
	[dimensionUnit] [varchar](10) NOT NULL CONSTRAINT [DF_CMRC_Products_dimensionUnit]  DEFAULT ('inches'),
	[isDeleted] [bit] NOT NULL CONSTRAINT [DF_CMRC_Products_isDeleted]  DEFAULT ((0)),
	[listOrder] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_listOrder]  DEFAULT ((1)),
	[ratingSum] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_RatingSum]  DEFAULT ((4)),
	[totalRatingVotes] [int] NOT NULL CONSTRAINT [DF_CMRC_Products_totalRatingSum]  DEFAULT ((1)),
	[defaultImage] [nvarchar](50) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Product_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Product_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Products] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'USER',N'dbo', N'TABLE',N'CSK_Store_Product', N'COLUMN',N'attributeXML'))
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'An XML string defining attributes for this product, like Size, Color, etc.' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CSK_Store_Product', @level2type=N'COLUMN',@level2name=N'attributeXML'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Promo](
	[promoID] [int] IDENTITY(1,1) NOT NULL,
	[campaignID] [int] NOT NULL,
	[promoCode] [nvarchar](50) NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[discount] [money] NOT NULL CONSTRAINT [DF_CMRC_PROMOS_amountOff_1]  DEFAULT (0),
	[qtyThreshold] [int] NOT NULL CONSTRAINT [DF_CMRC_PROMOS_qtyThreshold_1]  DEFAULT (0),
	[inventoryGoal] [int] NOT NULL CONSTRAINT [DF_CMRC_PROMOS_Rules_inventoryGoal]  DEFAULT (0),
	[revenueGoal] [money] NOT NULL CONSTRAINT [DF_CMRC_PROMOS_Rules_revenueGoal]  DEFAULT (0),
	[dateEnd] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_CMRC_PROMOS_Rules_isActive]  DEFAULT (1),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_PROMO_Rules] PRIMARY KEY CLUSTERED 
(
	[promoID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Stats_Tracker]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Stats_Tracker](
	[trackingID] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[adID] [int] NULL,
	[promoID] [int] NULL,
	[productSKU] [nvarchar](50) NULL,
	[categoryID] [int] NULL,
	[pageURL] [nvarchar](100) NULL,
	[behaviorID] [int] NOT NULL,
	[searchString] [nvarchar](150) NULL,
	[sessionID] [nvarchar](50) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Stats_Tracker_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Stats_Tracker_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_STATS_Tracker] PRIMARY KEY CLUSTERED 
(
	[trackingID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Product_Promo_Map]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Promo_Product_Promo_Map](
	[productID] [int] NOT NULL,
	[promoID] [int] NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_Product_Promo_Map_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Promo_Product_Promo_Map_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_Products_Promos] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[promoID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Image]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Image](
	[imageID] [int] IDENTITY(1,1) NOT NULL,
	[productID] [int] NOT NULL,
	[imageFile] [varchar](250) NULL,
	[listOrder] [int] NOT NULL CONSTRAINT [DF_CMRC_ProductImages_isDefault]  DEFAULT (0),
	[caption] [nvarchar](500) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Image_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Image_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_ProductImages] PRIMARY KEY CLUSTERED 
(
	[imageID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_ProductDescriptor]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_ProductDescriptor](
	[descriptorID] [int] IDENTITY(1,1) NOT NULL,
	[productID] [int] NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[descriptor] [nvarchar](2500) NOT NULL,
	[isBulletedList] [bit] NOT NULL CONSTRAINT [DF_CSK_Store_ProductDescriptor_isBulletedList]  DEFAULT ((0)),
	[listOrder] [int] NOT NULL CONSTRAINT [DF_CSK_Store_ProductDescriptor_listOrder]  DEFAULT ((1)),
 CONSTRAINT [PK_CSK_Store_ProductDescriptor] PRIMARY KEY CLUSTERED 
(
	[descriptorID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Product_Bundle_Map]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Promo_Product_Bundle_Map](
	[productID] [int] NOT NULL,
	[bundleID] [int] NOT NULL,
 CONSTRAINT [PK_CSK_Store_Product_Bundle_Map] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[bundleID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Product_CrossSell_Map]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Promo_Product_CrossSell_Map](
	[productID] [int] NOT NULL,
	[crossProductID] [int] NOT NULL,
 CONSTRAINT [PK_CSK_Promo_Product_CrossSell_Map] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[crossProductID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_OrderNote]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_OrderNote](
	[noteID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NOT NULL,
	[note] [nvarchar](1500) NOT NULL,
	[orderStatus] [nvarchar](50) NOT NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_OrderNote_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_OrderNote_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_OrderNotes] PRIMARY KEY CLUSTERED 
(
	[noteID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_OrderItem]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_OrderItem](
	[orderItemID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[sku] [nvarchar](50) NULL,
	[productName] [nvarchar](250) NULL,
	[imageFile] [nvarchar](250) NULL,
	[productDescription] [nvarchar](2500) NULL,
	[weight] [money] NULL,
	[dimensions] [nvarchar](50) NULL,
	[quantity] [int] NOT NULL,
	[originalPrice] [money] NOT NULL,
	[pricePaid] [money] NOT NULL,
	[attributes] [nvarchar](3500) NULL,
	[downloadURL] [nvarchar](250) NULL,
	[isShipped] [bit] NOT NULL CONSTRAINT [DF_CSK_Store_OrderItem_isShipped]  DEFAULT ((0)),
	[shipDate] [datetime] NULL,
	[shippingEstimate] [nvarchar](150) NULL,
	[shipmentReference] [nvarchar](50) NULL,
	[rating] [money] NOT NULL CONSTRAINT [DF_CSK_Store_OrderItem_rating]  DEFAULT ((4)),
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_OrderItem_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_OrderItem_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMRC_OrderItems] PRIMARY KEY CLUSTERED 
(
	[orderItemID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Transaction]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[CSK_Store_Transaction](
	[transactionID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NOT NULL,
	[authorizationCode] [nvarchar](50) NULL,
	[transactionDate] [datetime] NOT NULL CONSTRAINT [DF_CMRC_OrderTransactions_transactionDate]  DEFAULT (getdate()),
	[transactionTypeID] [int] NOT NULL CONSTRAINT [DF_CMRC_OrderTransactions_transationTypeID]  DEFAULT ((1)),
	[amount] [money] NOT NULL CONSTRAINT [DF_CMRC_OrderTransactions_amount]  DEFAULT ((0)),
	[transactionNotes] [nvarchar](500) NULL,
	[createdOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Transaction_createdOn]  DEFAULT (getdate()),
	[createdBy] [nvarchar](50) NULL,
	[modifiedOn] [datetime] NULL CONSTRAINT [DF_CSK_Store_Transaction_modifiedOn]  DEFAULT (getdate()),
	[modifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CSK_Store_Transaction] PRIMARY KEY CLUSTERED 
(
	[transactionID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[vwProduct]') AND OBJECTPROPERTY(id, N'IsView') = 1)
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwProduct]
AS
SELECT     dbo.CSK_Store_Product.productID, dbo.CSK_Store_Product.sku, dbo.CSK_Store_Product.productName, dbo.CSK_Store_Product.shortDescription, 
                      dbo.CSK_Store_Product.manufacturerID, dbo.CSK_Store_Product.statusID, dbo.CSK_Store_Product.productTypeID, 
                      dbo.CSK_Store_Product.shippingTypeID, dbo.CSK_Store_Product.shipEstimateID, dbo.CSK_Store_Product.taxTypeID, 
                      dbo.CSK_Store_Product.stockLocation, dbo.CSK_Store_Product.ourPrice, dbo.CSK_Store_Product.retailPrice, dbo.CSK_Store_Product.weight, 
                      dbo.CSK_Store_Product.currencyCode, dbo.CSK_Store_Product.unitOfMeasure, dbo.CSK_Store_Product.adminComments, 
                      dbo.CSK_Store_Product.length, dbo.CSK_Store_Product.height, dbo.CSK_Store_Product.width, dbo.CSK_Store_Product.dimensionUnit, 
                      dbo.CSK_Store_Product.isDeleted, dbo.CSK_Store_Product.listOrder, dbo.CSK_Store_Product.ratingSum, dbo.CSK_Store_Product.totalRatingVotes, 
                      dbo.CSK_Store_Product.createdOn, dbo.CSK_Store_Product.createdBy, dbo.CSK_Store_Product.modifiedOn, dbo.CSK_Store_Product.modifiedBy, 
                      dbo.CSK_Store_ShippingEstimate.shippingEstimate, dbo.CSK_Store_ShippingEstimate.leadTimeDays,
                          (SELECT     TOP (1) imageFile
                            FROM          dbo.CSK_Store_Image
                            WHERE      (productID = dbo.CSK_Store_Product.productID)
                            ORDER BY listOrder) AS imageFile,
                          (SELECT     TOP (1) categoryID
                            FROM          dbo.CSK_Store_Category
                            WHERE      (dbo.CSK_Store_Product.productID = dbo.CSK_Store_Product.productID)
                            ORDER BY categoryID) AS categoryID, CONVERT(money, dbo.CSK_Store_Product.ratingSum) / CONVERT(money, 
                      dbo.CSK_Store_Product.totalRatingVotes) AS rating, dbo.CSK_Store_Manufacturer.manufacturer, dbo.CSK_Store_ProductStatus.status, 
                      dbo.CSK_Tax_Type.taxType, dbo.CSK_Tax_Type.taxCode, dbo.CSK_Store_ShippingType.shippingType, dbo.CSK_Store_ShippingType.shippingCode, 
                      dbo.CSK_Store_Product.defaultImage
FROM         dbo.CSK_Store_Product INNER JOIN
                      dbo.CSK_Store_ShippingEstimate ON dbo.CSK_Store_Product.shipEstimateID = dbo.CSK_Store_ShippingEstimate.shipEstimateID INNER JOIN
                      dbo.CSK_Store_Manufacturer ON dbo.CSK_Store_Product.manufacturerID = dbo.CSK_Store_Manufacturer.manufacturerID INNER JOIN
                      dbo.CSK_Store_ProductStatus ON dbo.CSK_Store_Product.statusID = dbo.CSK_Store_ProductStatus.statusID INNER JOIN
                      dbo.CSK_Tax_Type ON dbo.CSK_Store_Product.taxTypeID = dbo.CSK_Tax_Type.taxTypeID INNER JOIN
                      dbo.CSK_Store_ShippingType ON dbo.CSK_Store_Product.shippingTypeID = dbo.CSK_Store_ShippingType.shippingTypeID
WHERE     (dbo.CSK_Store_Product.isDeleted = 0)
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'USER',N'dbo', N'VIEW',N'vwProduct', NULL,NULL))
EXEC dbo.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[36] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CSK_Store_Product"
            Begin Extent = 
               Top = 37
               Left = 281
               Bottom = 305
               Right = 441
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "CSK_Store_ShippingEstimate"
            Begin Extent = 
               Top = 26
               Left = 544
               Bottom = 173
               Right = 945
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CSK_Store_Manufacturer"
            Begin Extent = 
               Top = 30
               Left = 84
               Bottom = 138
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CSK_Store_ProductStatus"
            Begin Extent = 
               Top = 156
               Left = 51
               Bottom = 264
               Right = 202
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CSK_Tax_Type"
            Begin Extent = 
               Top = 263
               Left = 46
               Bottom = 371
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CSK_Store_ShippingType"
            Begin Extent = 
               Top = 198
               Left = 490
               Bottom = 306
               Right = 644
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidt' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProduct'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane2' , N'USER',N'dbo', N'VIEW',N'vwProduct', NULL,NULL))
EXEC dbo.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'hs = 42
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3090
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProduct'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'USER',N'dbo', N'VIEW',N'vwProduct', NULL,NULL))
EXEC dbo.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'USER',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwProduct'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GetParentCategory]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetParentCategory]
	(
	@categoryID int
	)
RETURNS int
AS
	BEGIN
	DECLARE @parentID int
	DECLARE @category varchar(50)
	DECLARE @loopCount int
	DECLARE @thisID int
	
	SET @parentID=9999
	
	SET @loopCount=1;
	while(@parentID IS NOT NULL AND @loopCount<10)
	BEGIN
		SELECT @parentID=parentID,
		@thisID=categoryID  
		FROM 
		CMRC_ProductCategories 
		WHERE categoryID=@categoryID
		
		SET @categoryID=@parentID
		SET @loopCount=@loopCount+1
	END
	
	RETURN @thisID
	END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Category_GetCrumbs]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Category_GetCrumbs] 
	@categoryID int
AS
	DECLARE @parentID int
	DECLARE @category varchar(50)
	DECLARE @output varchar(500)
	DECLARE @loopCount int
	SET @parentID=9999
	
	CREATE TABLE #cats(
		categoryID int,
		category varchar(50),
		listOrder int
	)
	
	SET @loopCount=1
	
	while(@parentID <>0 AND @loopCount<10)
	BEGIN
		SELECT @parentID=parentID,@category=categoryName  FROM CSK_Store_Category WHERE categoryID=@categoryID
		
		IF(@category<>'''')
			SET @output=@output+'';''+@category
		
		INSERT INTO #cats(categoryID, category, listOrder) VALUES(@categoryID, @category, @loopCount)
		SET @categoryID=@parentID
		SET @loopCount=@loopCount+1
	END
	SELECT * FROM #cats ORDER BY listOrder DESC
	DROP Table #cats
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GetChildren]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetChildren] (@Id int) 
RETURNS @result TABLE (Id int, ParentId int, Level smallint) 
AS 
BEGIN 
DECLARE @Level smallint 
-- get the top level node (magic requirement) 
-- get starting node 
SET @Level = 1 
INSERT @result 
SELECT categoryID, ParentId, @Level FROM CSK_Store_Category WHERE categoryID = @Id 
WHILE @Level < 1000 BEGIN -- weak condition to catch infinite recursion 
-- get child nodes of current level''s nodes 
INSERT @result 
SELECT t.categoryID, t.ParentId, @Level + 1 FROM CSK_Store_Category t 
JOIN @result r ON t.ParentId = r.Id AND @Level = r.Level 
-- no child nodes ==&gt; all done 
IF @@ROWCOUNT = 0 BREAK 
-- advance one level 
SET @Level = @Level + 1 
END 
RETURN 
END 
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_DeletePermanent]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Product_DeletePermanent]
	(
		@productID int
	)
AS
	--FK tables
	BEGIN TRANSACTION
	
	DELETE FROM CSK_PROMO_Product_Bundle_Map WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Promo_Product_CrossSell_Map WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Promo_Product_Promo_Map WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Store_Product_Category_Map WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Store_ProductDescriptor WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Store_ProductRating WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Store_ProductReviewFeedback WHERE reviewID IN (SELECT reviewID FROM CSK_Store_ProductRating WHERE productID=@productID);
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Store_ProductReview WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR
	
	DELETE FROM CSK_Store_Image WHERE productID = @productID;
	IF @@ERROR>0 GOTO TRANS_ERR


	--Product Table
	DELETE FROM CSK_Store_Product WHERE productID=@productID
	IF @@ERROR>0 GOTO TRANS_ERR
	
	
	--remove all items from non-checked out carts
	DELETE FROM CSK_Store_OrderItem 
	WHERE productID=@productID
	AND orderID IN (SELECT orderID FROM CSK_Store_Order WHERE orderStatusID=9999)
	IF @@ERROR>0 GOTO TRANS_ERR

	COMMIT TRANSACTION
	
	RETURN
TRANS_ERR:
	ROLLBACK TRANSACTION' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_ProductMatrix]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Promo_ProductMatrix]
AS


	SELECT     CSK_Promo_Campaign.campaignID, CSK_Promo_Campaign.campaignName, CSK_Promo.promoID, CSK_Promo.promoCode, CSK_Promo.title, 
	                      CSK_Promo.description, CSK_Store_Product.productID, CSK_Store_Product.sku, CSK_Store_Product.productName, CSK_Store_Product.ourPrice, 
	                      CSK_Store_Product.retailPrice, CSK_Store_Product.retailPrice * CSK_Promo.discount / 100 AS discountAmount, 
	                      CSK_Store_Product.retailPrice - CSK_Store_Product.retailPrice * CSK_Promo.discount / 100 AS discountedPrice, CSK_Promo.discount, 
	                      CSK_Promo.qtyThreshold, CSK_Promo.isActive, CSK_Promo.dateEnd
	FROM         CSK_Promo INNER JOIN
	                      CSK_Promo_Product_Promo_Map ON CSK_Promo.promoID = CSK_Promo_Product_Promo_Map.promoID INNER JOIN
	                      CSK_Store_Product ON CSK_Promo_Product_Promo_Map.productID = CSK_Store_Product.productID INNER JOIN
	                      CSK_Promo_Campaign ON CSK_Promo.campaignID = CSK_Promo_Campaign.campaignID
	WHERE     (CSK_Promo.isActive = 1) AND (CSK_Promo.dateEnd >= GETDATE())
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_GetPostAddMulti]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'	CREATE PROCEDURE [dbo].[CSK_Store_Product_GetPostAddMulti]
	(
		@userName nvarchar(50)
	)
AS
	
	--get the last item added
	DECLARE @orderID nvarchar(50)
	SELECT @orderID=orderID FROM CSK_STORE_Order WHERE userName=@userName AND orderStatusID=9999
	
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
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Coupons_SaveCouponType]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[CSK_Coupons_SaveCouponType] 
	(
	@CouponTypeId int, 
	@Description nvarchar(128), 
	@ProcessingClassName nvarchar(256)
	)
AS
	IF EXISTS (SELECT CouponTypeId FROM CSK_CouponTypes WHERE CouponTypeId=@CouponTypeId)

	BEGIN 
		UPDATE CSK_CouponTypes SET 
			Description = @Description, 
			ProcessingClassName = @ProcessingClassName
		WHERE 
			CouponTypeId = @CouponTypeId
		RETURN @CouponTypeId 
	END 
	ELSE
	BEGIN  
		INSERT INTO CSK_CouponTypes
			(Description, ProcessingClassName) 
			VALUES 
			(@Description, @ProcessingClassName)
		RETURN SCOPE_IDENTITY()
	END 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Coupons_GetCouponType]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[CSK_Coupons_GetCouponType] 
	(
	@couponTypeId int
	)
AS
	/* SET NOCOUNT ON */ 
	SELECT 
		CT.CouponTypeId, 
		CT.Description, 
		CT.ProcessingClassName 
	FROM 
		CSK_CouponTypes CT
	WHERE 
		CT.CouponTypeId = @couponTypeId 
		
	RETURN

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Coupons_GetAllCouponTypes]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[CSK_Coupons_GetAllCouponTypes]
AS
	/* SET NOCOUNT ON */ 
	SELECT 
		CT.CouponTypeId, 
		CT.Description, 
		CT.ProcessingClassName 
	FROM 
		CSK_CouponTypes CT


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Tax_GetTaxRate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Tax_GetTaxRate]
	(
	@zip nvarchar(50)
	)
AS
BEGIN
	--use the state that this zip is in
	DECLARE @state char(2)
	SELECT @state=stateAbbreviation FROM CSK_Util_ZipCode WHERE zipCode=@zip
SELECT     rateID, rate, state, zipCode
FROM         CSK_Tax_Rate
WHERE     (state = @state)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Tax_CalculateAmountByZIP]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Tax_CalculateAmountByZIP]
	(
		@zipCode varchar(5),
		@subTotal money
	)
AS
	
	--get the rate for the state
	--apply it to the subtotal
	DECLARE @rate money
	DECLARE @taxAmount money
	SET @taxAmount=0
	
	IF EXISTS (SELECT rate FROM CSK_Tax_Rate WHERE zipCode=@zipCode)
		BEGIN
		SELECT @rate=rate FROM CSK_Tax_Rate WHERE zipCode=@zipCode
		
		SET @taxAmount=@rate*@subTotal
		END
	
	SELECT @taxAmount as taxAmount
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Tax_CalculateAmountByState]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Tax_CalculateAmountByState] 
	(
		@stateAbbreviation varchar(2),
		@subTotal money
	)
AS
	
	--get the rate for the state
	--apply it to the subtotal
	DECLARE @rate money
	DECLARE @taxAmount money
	SET @taxAmount=0
	
	IF EXISTS (SELECT rate FROM CSK_Tax_Rate WHERE state=@stateAbbreviation)
		BEGIN
		SELECT @rate=rate FROM CSK_Tax_Rate WHERE state=@stateAbbreviation
		
		SET @taxAmount=@rate*@subTotal
		END
	
	SELECT @taxAmount as taxAmount
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Tax_SaveZipRate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Tax_SaveZipRate]
	(
	@state nvarchar(2),
	@zipCode nvarchar(50)='''',
	@rate money, 
	@userName nvarchar(50)
	)
AS
	
	IF @zipCode<>''''
	BEGIN
		IF EXISTS(SELECT zipCode FROM CSK_Tax_Rate WHERE zipCode=@zipCode)
			UPDATE CSK_Tax_Rate SET rate=@rate, modifiedOn=getdate(), modifiedBy=@userName WHERE zipCode=@zipCode
		ELSE
			INSERT INTO CSK_Tax_Rate(rate, state,zipCode, createdBy, modifiedBy)
			VALUES(@rate,@state,@zipCode, @userName, @userName)
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT state FROM CSK_Tax_Rate WHERE state=@state)
			UPDATE CSK_Tax_Rate SET rate=@rate, modifiedOn=getdate(), modifiedBy=@userName WHERE state=@state
		ELSE
			INSERT INTO CSK_Tax_Rate(rate, state,zipCode, createdBy, modifiedBy)
			VALUES(@rate,@state,@zipCode, @userName, @userName)
	
	END
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Coupons_SaveCoupon]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[CSK_Coupons_SaveCoupon] 
(
	@CouponCode nvarchar(30), 
	@CouponTypeId int, 
	@IsSingleUse bit, 
	@UserId uniqueidentifier, 
	@NumberUses int, 
	@ExpirationDate datetime, 
	@XmlData nvarchar(MAX)
)
AS
	IF NOT EXISTS (SELECT CouponCode FROM CSK_Coupons WHERE CouponCode = @CouponCode)
	  BEGIN
		--New coupon ... insert.  
		INSERT INTO CSK_Coupons(
			CouponCode, 
			CouponTypeId, 
			IsSingleUse, 
			UserId, 
			NumberUses, 
			ExpirationDate, 
			[XmlData])
		  VALUES (
			@CouponCode, 
			@CouponTypeId, 
			@IsSingleUse, 
			@UserId, 
			@NumberUses, 
			@ExpirationDate, 
			@XmlData)
	  END 
	ELSE 
	  BEGIN 
		UPDATE CSK_Coupons SET 
			CouponTypeId = @CouponTypeId, 
			IsSingleUse = @IsSingleUse, 
			UserId = @UserId, 
			NumberUses = @NumberUses, 
			ExpirationDate = @ExpirationDate, 
			[XmlData] = @XmlData
			WHERE CouponCode = @CouponCode 
	  END 
	RETURN
 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Stats_Tracker_GetByBehaviorID]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
	

	CREATE PROCEDURE [dbo].[CSK_Stats_Tracker_GetByBehaviorID]
	(
		@behaviorID int
	)
	AS
	SELECT 
	trackingID,
		userName,
		adID,
		promoID,
		productSKU,
		categoryID,
		pageURL,
		behaviorID,
		searchString,
		sessionID,
		createdOn,
		createdBy,
		modifiedOn,
		modifiedBy
	
	FROM CSK_Stats_Tracker
	WHERE 
		behaviorID=@behaviorID
	RETURN 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Stats_Tracker_GetByProductAndBehavior]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Stats_Tracker_GetByProductAndBehavior] 
	(
	@behaviorID int,
	@sku nvarchar(50)
	)
AS
	SELECT     trackingID, userName, adID, promoID, productSKU, categoryID, pageURL, behaviorID, searchString, sessionID, createdOn, createdBy, modifiedOn, 
	                      modifiedBy
	FROM         CSK_Stats_Tracker
	WHERE     (productSKU = @sku) AND (behaviorID = @behaviorID)
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_GetMostPopular]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Product_GetMostPopular]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT     TOP (6) vwProduct.productID, vwProduct.sku, vwProduct.productName, vwProduct.shortDescription, COUNT(CSK_Stats_Tracker.trackingID) AS Views, 
	                      vwProduct.imageFile, vwProduct.shippingEstimate, vwProduct.rating, vwProduct.status, vwProduct.ourPrice, vwProduct.retailPrice, 
	                      vwProduct.statusID
	FROM         vwProduct INNER JOIN
	                      CSK_Stats_Tracker ON vwProduct.sku = CSK_Stats_Tracker.productSKU
	GROUP BY vwProduct.productID, vwProduct.sku, vwProduct.productName, vwProduct.shortDescription, vwProduct.imageFile, vwProduct.shippingEstimate, 
	                      vwProduct.rating, vwProduct.status, vwProduct.ourPrice, vwProduct.retailPrice, vwProduct.statusID
	HAVING      (vwProduct.statusID <> 99)
	ORDER BY Views DESC
	
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Stats_Tracker_SynchTrackingCookie]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Stats_Tracker_SynchTrackingCookie]
	(
	@userName nvarchar(50),
	@trackerCookie nvarchar(50)
	)
AS
	UPDATE CSK_Stats_Tracker SET userName=@userName WHERE userName=@trackerCookie
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GetLastViewedSKUs]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetLastViewedSKUs]
	(
	@userName nvarchar(50)
	)
RETURNS @skus TABLE (sku nvarchar(50), holder int)
AS
	BEGIN
		INSERT INTO @skus(sku, holder)
		SELECT TOP 50 productsku,0 FROM CSK_Stats_Tracker
		WHERE behaviorID=2 AND userName=@userName
		ORDER BY CreatedOn DESC
		INSERT INTO @skus
		SELECT DISTINCT sku,1 FROM @skus
		DELETE FROM @skus WHERE holder=0
	RETURN
	END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Shipping_GetRates_Ground]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Shipping_GetRates_Ground]
	(
		@weight money
	)
AS
	--this is a very simple rate calculator that does not take into account
	--distance. Use only for testing
	SELECT     shippingRateID, Service, AmountPerUnit, @weight * AmountPerUnit AS Rate, isAirOnly, isGroundOnly
	FROM         CSK_Shipping_Rate
	WHERE isGroundOnly=1
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Shipping_GetRates_Air]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Shipping_GetRates_Air]
	(
		@weight money
	)
AS
	--this is a very simple rate calculator that does not take into account
	--distance. Use only for testing
	SELECT     shippingRateID, Service, AmountPerUnit, @weight * AmountPerUnit AS Rate, isAirOnly, isGroundOnly
	FROM         CSK_Shipping_Rate
	WHERE isAirOnly=1
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Shipping_GetRates]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Shipping_GetRates]
	(
		@weight money
	)
AS
	--this is a very simple rate calculator that does not take into account
	--distance. Use only for testing
	SELECT     shippingRateID, Service, AmountPerUnit, @weight * AmountPerUnit AS Rate, isAirOnly, isGroundOnly
	FROM         CSK_Shipping_Rate
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_GetProductList]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Promo_GetProductList]
	(
		@promoID int
	)
AS
	SELECT     productID, promoID
	FROM         CSK_Promo_Product_Promo_Map
	WHERE     (promoID = @promoID)
	
	
	SELECT     productID, sku, productName
	FROM         CSK_Store_Product

	RETURN

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_RemoveProducts]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Promo_RemoveProducts] 
	(
	@promoID int
	)
AS
	DELETE FROM CSK_Promo_Product_Promo_Map
	WHERE promoID=@promoID
	RETURN


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_AddProduct]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Promo_AddProduct]
	(
	@promoID int,
	@productID int
	)
AS
	
	INSERT into CSK_Promo_Product_Promo_Map (promoID, productID)
	VALUES (@promoID, @productID)
	
	RETURN




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Content_Update]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
	

	CREATE PROCEDURE [dbo].[CSK_Content_Update]
	(
			@contentID int,
		@contentGUID uniqueidentifier,
		@title nvarchar(500),
		@contentName nvarchar(50),
		@content nvarchar,
		@iconPath nvarchar(250),
		@dateExpires datetime,
		@contentGroupID int,
		@lastEditedBy nvarchar(100),
		@externalLink nvarchar(250),
		@status nvarchar(50),
		@listOrder int,
		@callOut nvarchar(250),
		@createdOn datetime,
		@createdBy nvarchar(50),
		@modifiedOn datetime,
		@modifiedBy nvarchar(50)
	)
	AS
	UPDATE CSK_Content_Text
	SET 
		contentGUID=@contentGUID,
		title=@title,
		contentName=@contentName,
		content=@content,
		iconPath=@iconPath,
		dateExpires=@dateExpires,
		contentGroupID=@contentGroupID,
		lastEditedBy=@lastEditedBy,
		externalLink=@externalLink,
		status=@status,
		listOrder=@listOrder,
		callOut=@callOut,
		createdOn=@createdOn,
		createdBy=@createdBy,
		modifiedOn=@modifiedOn,
		modifiedBy=@modifiedBy	
	WHERE contentID=@contentID

	RETURN 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Content_Get]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Content_Get]
	(
	@contentName nvarchar(50)
	)
AS
	SELECT     contentID, contentGUID, title, contentName, [content], iconPath, dateExpires, contentGroupID, createdBy, lastEditedBy, externalLink, callOut, listOrder, 
	                      status, createdOn, modifiedOn, modifiedBy
	FROM         CSK_Content_Text
	WHERE     (contentName = @contentName)
	RETURN

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Content_Insert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
	

	CREATE PROCEDURE [dbo].[CSK_Content_Insert]
	(
			@contentGUID uniqueidentifier,
		@title nvarchar(500)='''',
		@contentName nvarchar(50),
		@content nvarchar='''',
		@iconPath nvarchar(250)='''',
		@dateExpires datetime=''1/1/1901'',
		@contentGroupID int,
		@lastEditedBy nvarchar(100)='''',
		@externalLink nvarchar(250)='''',
		@status nvarchar(50)='''',
		@listOrder int,
		@callOut nvarchar(250)='''',
		@createdOn datetime=''1/1/1901'',
		@createdBy nvarchar(50)='''',
		@modifiedOn datetime=''1/1/1901'',
		@modifiedBy nvarchar(50)=''''
	)
	
	AS
	INSERT INTO CSK_Content_Text 
	(
		contentGUID,
		title,
		contentName,
		content,
		iconPath,
		dateExpires,
		contentGroupID,
		lastEditedBy,
		externalLink,
		status,
		listOrder,
		callOut,
		createdOn,
		createdBy,
		modifiedOn,
		modifiedBy
	)
	VALUES
	(
	   @contentGUID,
		@title,
		@contentName,
		@content,
		@iconPath,
		@dateExpires,
		@contentGroupID,
		@lastEditedBy,
		@externalLink,
		@status,
		@listOrder,
		@callOut,
		@createdOn,
		@createdBy,
		@modifiedOn,
		@modifiedBy

	)
	SELECT @@IDENTITY as newID
	RETURN 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Content_Save]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'Create PROCEDURE [dbo].[CSK_Content_Save]
	(
		@contentName varchar(200),
		@title varchar(2000),
		@content varchar(8000),
		@groupID int=1,
		@iconPath varchar(500)='''',
		@status varchar(50)=''Active'',
		@userName varchar(200) ='''',
		@callOut varchar(500)='''',
		@externalLink varchar(250)=''''
	)
AS
	--see if it exists
	IF EXISTS (SELECT contentName FROM CSK_Content_Text WHERE contentName=@contentName)
	BEGIN
		--update
		UPDATE CSK_Content_Text SET content=@content, title=@title, 
		contentGroupID=@groupID,iconPath=@iconPath,
		status=@status,lastEditedBy=@userName,
		callOut=@callout,
		externalLink=@externalLink
		 WHERE contentName=@contentName
	END
	ELSE
	BEGIN
		--insert
		INSERT INTO CSK_Content_Text (contentName,content, title,contentGroupID,iconPath,status,createdBy, callOut,externalLink)
		VALUES (@contentName, @content, @title,@groupID,@iconPath,@status,@userName, @callOut,@externalLink);
	END
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Bundle_GetByProductID]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'



	CREATE PROCEDURE [dbo].[CSK_Promo_Bundle_GetByProductID]
	(
		@productID int
	)
	AS
	DECLARE @bundleID int
	SELECT @bundleID=bundleID FROM CSK_Promo_Product_Bundle_Map WHERE productID=@productID
	SELECT     CSK_Promo_Bundle.bundleID, CSK_Promo_Bundle.bundleName, CSK_Promo_Bundle.discountPercent, CSK_Promo_Bundle.description, 
	                      CSK_Promo_Bundle.createdOn, CSK_Promo_Bundle.createdBy, CSK_Promo_Bundle.modifiedOn, CSK_Promo_Bundle.modifiedBy, 
	                      CSK_Store_Product.productID, CSK_Store_Product.sku, CSK_Store_Product.productName, CSK_Store_Product.shortDescription, 
	                      CSK_Store_Product.defaultImage AS imageFile, CSK_Store_Product.ourPrice, CSK_Store_Product.retailPrice, CSK_Store_Product.weight
	FROM         CSK_Promo_Bundle INNER JOIN
	                      CSK_Promo_Product_Bundle_Map ON CSK_Promo_Bundle.bundleID = CSK_Promo_Product_Bundle_Map.bundleID INNER JOIN
	                      CSK_Store_Product ON CSK_Promo_Product_Bundle_Map.productID = CSK_Store_Product.productID
	WHERE     (CSK_Promo_Bundle.bundleID = @bundleID)

	RETURN 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Bundle_GetSelectedProducts]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Promo_Bundle_GetSelectedProducts]
	(
	@bundleID int
	)
AS
	SELECT productID, sku, productName
	FROM CSK_Store_Product
	WHERE productID IN(SELECT productID FROM CSK_Promo_Product_Bundle_Map WHERE bundleID=@bundleID)
	RETURN

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Bundle_GetAvailableProducts]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[CSK_Promo_Bundle_GetAvailableProducts]
	(
	@bundleID int
	)
AS
	
	SELECT productID, sku, productName, imageFile
	FROM vwProduct
	WHERE productID NOT IN(SELECT productID FROM CSK_Promo_Product_Bundle_Map WHERE bundleID=@bundleID)
	
	RETURN

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Promo_Bundle_AddProduct]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Promo_Bundle_AddProduct]
	(
	@bundleID int,
	@productID int
	)
AS
	if not exists(Select productID FROM CSK_Promo_Product_Bundle_Map WHERE productID=@productID
	AND bundleID=@bundleID)
	BEGIN
		INSERT INTO CSK_Promo_Product_Bundle_Map(productID, bundleID)
		VALUES  (@productID, @bundleID)
	
	END
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Order_Query]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Order_Query]
	(
		@dateStart datetime=''1/1/1900'',
		@dateEnd datetime=''1/1/2100'',
		@userName nvarchar(50)='''',
		@orderNumber nvarchar(50)=''''
	)
AS
	
	--get the orders with the criteria above
	
	SELECT     CSK_Store_Order.orderNumber, CSK_Store_Order.orderID, CSK_Store_Order.orderDate, CSK_Store_Order.orderStatusID, CSK_Store_Order.userName, 
	                      CSK_Store_Order.shippingMethod, CSK_Store_Order.subTotalAmount, CSK_Store_Order.shippingAmount, CSK_Store_Order.handlingAmount, 
	                      CSK_Store_Order.taxAmount, CSK_Store_Order.taxRate, CSK_Store_Order.couponCodes, CSK_Store_Order.discountAmount, 
	                      CSK_Store_Order.specialInstructions, CSK_Store_Order.shipToAddress, CSK_Store_Order.billToAddress, CSK_Store_Order.userIP, 
	                      CSK_Store_Order.shippingTrackingNumber, CSK_Store_Order.numberOfPackages, CSK_Store_Order.packagingNotes, CSK_Store_Order.createdOn, 
	                      CSK_Store_Order.createdBy, CSK_Store_Order.modifiedOn, CSK_Store_Order.modifiedBy, CSK_Store_Order.email, CSK_Store_Order.firstName, 
	                      CSK_Store_Order.lastName, SUM(CSK_Store_OrderItem.pricePaid * CONVERT(money, CSK_Store_OrderItem.quantity)) AS SubtotalAmount, 
	                      (SELECT SUM(amount) FROM CSK_Store_Transaction WHERE orderID=CSK_Store_Order.orderID)
	                      AS Payments, CSK_Store_OrderStatus.OrderStatus, CSK_Store_OrderStatus.OrderStatusID AS Expr1
	FROM         CSK_Store_Order INNER JOIN
	                      CSK_Store_OrderItem ON CSK_Store_Order.orderID = CSK_Store_OrderItem.orderID INNER JOIN
	                      CSK_Store_Transaction ON CSK_Store_Order.orderID = CSK_Store_Transaction.orderID INNER JOIN
	                      CSK_Store_OrderStatus ON CSK_Store_Order.orderStatusID = CSK_Store_OrderStatus.OrderStatusID
	GROUP BY CSK_Store_Order.orderNumber, CSK_Store_Order.orderID, CSK_Store_Order.orderDate, CSK_Store_Order.orderStatusID, 
	                      CSK_Store_Order.userName, CSK_Store_Order.shippingMethod, CSK_Store_Order.subTotalAmount, CSK_Store_Order.shippingAmount, 
	                      CSK_Store_Order.handlingAmount, CSK_Store_Order.taxAmount, CSK_Store_Order.taxRate, CSK_Store_Order.couponCodes, 
	                      CSK_Store_Order.discountAmount, CSK_Store_Order.specialInstructions, CSK_Store_Order.shipToAddress, CSK_Store_Order.billToAddress, 
	                      CSK_Store_Order.userIP, CSK_Store_Order.shippingTrackingNumber, CSK_Store_Order.numberOfPackages, CSK_Store_Order.packagingNotes, 
	                      CSK_Store_Order.createdOn, CSK_Store_Order.createdBy, CSK_Store_Order.modifiedOn, CSK_Store_Order.modifiedBy, CSK_Store_Order.email, 
	                      CSK_Store_Order.firstName, CSK_Store_Order.lastName, CSK_Store_OrderStatus.OrderStatus, CSK_Store_OrderStatus.OrderStatusID
	HAVING      (CSK_Store_Order.orderNumber LIKE ''%'' + @orderNumber) AND (CSK_Store_Order.orderDate BETWEEN @dateStart AND @dateEnd) AND 
	                      (CSK_Store_Order.userName LIKE ''%'' + @userName) AND (CSK_Store_OrderStatus.OrderStatusID <> 9999)
	ORDER BY CSK_Store_Order.orderDate DESC
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Config_GetList]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
	
	CREATE PROCEDURE [dbo].[CSK_Store_Config_GetList]

	AS
	SELECT 
	settingID,
		attribute,
		setting,
		dataType,
		description,
		createdOn,
		createdBy,
		modifiedOn,
		modifiedBy
	
	FROM CSK_Store_Config

	RETURN 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Category_GetAllSubs]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Category_GetAllSubs]
	(
		@parentID int
	)
AS
	SELECT     categoryID, categoryName, imageFile, parentID, shortDescription, longDescription, listOrder
	FROM         CSK_Store_Category
	WHERE categoryID IN (SELECT id FROM dbo.GetChildren(@parentID))
	AND categoryID<>@parentID
	ORDER BY listOrder
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Stats_Tracker_GetRecentlyViewedProducts]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Stats_Tracker_GetRecentlyViewedProducts]
	(
	@username nvarchar(50)
	)
AS
	SELECT     TOP 5 CSK_Stats_Tracker.productSKU, CSK_Stats_Tracker.pageURL,  CSK_Store_Product.productName, 
	                      CSK_Store_Product.shortDescription, CSK_Store_Product.ourPrice, CSK_Store_Product.retailPrice,
	                          (SELECT     TOP 1 imageFile
	                            FROM          CSK_Store_Image
	                            WHERE      (productID = CSK_Store_Product.productID)) AS ImageFile, CSK_Store_Product.productID, CSK_Store_ShippingEstimate.shippingEstimate
	FROM         CSK_Stats_Tracker INNER JOIN
	                      CSK_Stats_Behavior ON CSK_Stats_Tracker.behaviorID = CSK_Stats_Behavior.behaviorID INNER JOIN
	                      CSK_Store_Product ON CSK_Stats_Tracker.productSKU = CSK_Store_Product.sku INNER JOIN
	                      CSK_Store_ShippingEstimate ON CSK_Store_Product.shipEstimateID = CSK_Store_ShippingEstimate.shipEstimateID
	WHERE     (CSK_Stats_Behavior.behaviorID = 2) AND (CSK_Store_Product.sku IN
	                          (SELECT     sku
	                            FROM          dbo.GetLastViewedSKUs(@userName) AS GetLastViewedSKUs_1)
	                           )
	GROUP BY CSK_Stats_Tracker.productSKU, CSK_Stats_Tracker.pageURL, CSK_Stats_TRACKER.Username, CSK_Store_Product.productName, 
	                      CSK_Store_Product.shortDescription, CSK_Store_Product.ourPrice, CSK_Store_Product.retailPrice, CSK_Store_Product.productID, 
	                      CSK_Store_ShippingEstimate.shippingEstimate
	HAVING      (CSK_Stats_Tracker.userName=@userName)
	RETURN' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_GetByPriceRange]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
	

	CREATE PROCEDURE [dbo].[CSK_Store_Product_GetByPriceRange]
	(
		@categoryID int,
		@priceStart money,
		@priceEnd money
	)
	AS
	SELECT     productID, sku, productName, shortDescription, manufacturerID, statusID, productTypeID, shippingTypeID, shipEstimateID, taxTypeID, stockLocation, 
	                      ourPrice, retailPrice, weight, currencyCode, unitOfMeasure, adminComments, length, height, width, dimensionUnit, isDeleted, listOrder, RatingSum, 
	                      totalRatingVotes, createdOn, createdBy, modifiedOn, modifiedBy, shippingEstimate, leadTimeDays, imageFile, categoryID, rating, manufacturer, status,
	                       taxType, taxCode, shippingType, shippingCode
	FROM         vwProduct
	WHERE     (productID IN
	                          (SELECT     productID
	                            FROM          CSK_Store_Product_Category_Map
	                            WHERE      (categoryID IN
	                                                       (SELECT     Id
	                                                         FROM          dbo.GetChildren(@categoryID) AS GetChildren_1)))) AND (ourPrice BETWEEN @priceStart AND @priceEnd) AND 
	                      (statusID <> 99)
	RETURN 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_GetByCategoryID]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'



	CREATE PROCEDURE [dbo].[CSK_Store_Product_GetByCategoryID]
	(
		@categoryID int
	)
	AS
	SELECT     productID, sku, productName, shortDescription, manufacturerID, statusID, productTypeID, shippingTypeID, shipEstimateID, taxTypeID, stockLocation, 
	                      ourPrice, retailPrice, weight, currencyCode, unitOfMeasure, adminComments, length, height, width, dimensionUnit, isDeleted, listOrder, RatingSum, 
	                      totalRatingVotes, createdOn, createdBy, modifiedOn, modifiedBy, shippingEstimate, leadTimeDays, imageFile, categoryID, rating, manufacturer, status,
	                       taxType, taxCode, shippingType, shippingCode
	FROM         vwProduct
	WHERE     (productID IN
	                          (SELECT     productID
	                            FROM          CSK_Store_Product_Category_Map
	                            WHERE      (categoryID IN
	                                                       (SELECT     Id
	                                                         FROM          dbo.GetChildren(@categoryID) AS GetChildren_1)))) AND (statusID <> 99)
	RETURN 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_GetByManufacturerID]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
	

	CREATE PROCEDURE [dbo].[CSK_Store_Product_GetByManufacturerID]
	(
		@manufacturerID int,
		@categoryID int
	)
	AS
	SELECT     productID, sku, productName, shortDescription, manufacturerID, statusID, productTypeID, shippingTypeID, shipEstimateID, taxTypeID, stockLocation, 
	                      ourPrice, retailPrice, weight, currencyCode, unitOfMeasure, adminComments, length, height, width, dimensionUnit, isDeleted, listOrder, RatingSum, 
	                      totalRatingVotes, createdOn, createdBy, modifiedOn, modifiedBy, shippingEstimate, leadTimeDays, imageFile, categoryID, rating, manufacturer, status,
	                       taxType, taxCode, shippingType, shippingCode
	FROM         vwProduct
	WHERE     (manufacturerID = @manufacturerID) AND (productID IN
	                          (SELECT     productID
	                            FROM          CSK_Store_Product_Category_Map
	                            WHERE      (categoryID IN
	                                                       (SELECT     Id
	                                                         FROM          dbo.GetChildren(@categoryID) AS GetChildren_1)))) AND (statusID <> 99)
	RETURN 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_SmartSearch]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Product_SmartSearch]
(@DescriptionLength INT,
 @AllWords BIT,

 @Word1 VARCHAR(50) = NULL,
 @Word2 VARCHAR(50) = NULL,
 @Word3 VARCHAR(50) = NULL,
 @Word4 VARCHAR(50) = NULL,
 @Word5 VARCHAR(50) = NULL)
-- @MinPrice money,
 --@MaxPrice money)

AS

--MANY THANKS TO MOODY FOR THIS ROUTINE--

/* Create the table variable that will contain the search results */
DECLARE @Products TABLE
(RowNumber SMALLINT IDENTITY (1,1) NOT NULL,
 ProductID INT,
  productName nvarchar(500),
  shortDescription VARCHAR(2000),
  ourPrice MONEY,
  retailPrice MONEY,
rating money,
  ProductImage nvarchar(250),
  SKU varchar(50),
  Rank INT)

IF @AllWords = 0
   INSERT INTO @Products          
   SELECT ProductID,productName,
          SUBSTRING(shortDescription, 1, @DescriptionLength) + ''...'' AS shortDescription,
           ourPrice,
	  retailPrice,
	rating,
	imageFile,
	sku,
          3 * dbo.WordCount(@Word1, productName) + dbo.WordCount(@Word1, shortDescription) +
          3 * dbo.WordCount(@Word2, productName) + dbo.WordCount(@Word2, shortDescription) +
          3 * dbo.WordCount(@Word3, productName) + dbo.WordCount(@Word3, shortDescription) +
          3 * dbo.WordCount(@Word4, productName) + dbo.WordCount(@Word4, shortDescription) +
          3 * dbo.WordCount(@Word5, productName) + dbo.WordCount(@Word5, shortDescription)
          AS Rank
   FROM dbo.vwProduct
   WHERE statusID<>99
   ORDER BY Rank DESC
  
/* Populate @Products for an all-words search */
IF @AllWords = 1
   INSERT INTO @Products          
   SELECT  ProductID,productName,
          SUBSTRING(shortDescription, 1, @DescriptionLength) + ''...'' AS shortDescription,
           ourPrice,
	  retailPrice,
	rating,
	imageFile,
	sku,        
       (3 * dbo.WordCount(@Word1, productName) + dbo.WordCount(@Word1, shortDescription)) *
          CASE
            WHEN @Word2 IS NULL THEN 1
            ELSE 3 * dbo.WordCount(@Word2, productName) + dbo.WordCount(@Word2, shortDescription)
          END *
          CASE
            WHEN @Word3 IS NULL THEN 1
            ELSE 3 * dbo.WordCount(@Word3, productName) + dbo.WordCount(@Word3, shortDescription)
          END *
          CASE
            WHEN @Word4 IS NULL THEN 1
            ELSE 3 * dbo.WordCount(@Word4, productName) + dbo.WordCount(@Word4, shortDescription)
          END *
          CASE
            WHEN @Word5 IS NULL THEN 1
            ELSE 3 * dbo.WordCount(@Word5, productName) + dbo.WordCount(@Word5, shortDescription)
          END
          AS Rank
   FROM dbo.vwProduct
   WHERE statusID<>99
   ORDER BY Rank DESC


/* Send back the requested products */
SELECT ProductID, productName,
          SUBSTRING(shortDescription, 1, @DescriptionLength) + ''...'' AS shortDescription,
   ProductImage, ourPrice,retailPrice,rating,productImage,SKU,
  Rank
FROM @Products
WHERE Rank > 0 --and UnitCost >=@MinPrice  and UnitCost <= @MaxPrice
 
ORDER BY Rank DESC

 


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Category_GetPageMulti]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Category_GetPageMulti]
	(
		@categoryID int
	)
AS
	--main record
	SELECT     categoryID, categoryName, imageFile, parentID, shortDescription, longDescription, listOrder, createdOn, createdBy, modifiedOn, modifiedBy
	FROM         CSK_Store_Category
	WHERE     (categoryID = @categoryID)
	
	--subs
	EXEC CSK_Store_Category_GetAllSubs @categoryID
	
	--brands
	
	SELECT     CSK_Store_Manufacturer.manufacturerID, CSK_Store_Manufacturer.manufacturer
	FROM         CSK_Store_Manufacturer INNER JOIN
	                      CSK_Store_Product ON CSK_Store_Manufacturer.manufacturerID = CSK_Store_Product.manufacturerID INNER JOIN
	                      CSK_Store_Product_Category_Map ON CSK_Store_Product.productID = CSK_Store_Product_Category_Map.productID
	WHERE     (CSK_Store_Product_Category_Map.categoryID IN
	                          (SELECT     Id
	                            FROM          dbo.GetChildren(@categoryID) AS GetChildren_1))
	GROUP BY CSK_Store_Manufacturer.manufacturerID, CSK_Store_Manufacturer.manufacturer
	
	
	--price range
	DECLARE @minPrice money, @maxPrice money
	SELECT @minPrice=MIN(ourPrice), @maxPrice=MAX(ourPrice)
	FROM CSK_Store_Product 
	WHERE productID IN(select productID FROM CSK_Store_Product_Category_Map WHERE categoryID IN (SELECT id FROM dbo.GetChildren(@categoryID))
	)
	CREATE TABLE #prices(lowRange money, hiRange money)
	DECLARE @thisLow money, @thisHigh money
	SET @thisLow=@minPrice
	SET @thisHigh=2*@thisLow-1
	DECLARE @loopCatch int
	
	--catch infinite loops
	SELECT @loopCatch=1
	WHILE @thisLow<=@maxPrice AND @loopCatch<100
		BEGIN
			
			INSERT INTO #prices(lowRange, hiRange)
			VALUES (@thisLow, @thisHigh)
			
			SET @thisLow=@thisHigh+1
			SET @thisHigh=2*@thisLow-1
			SELECT @loopCatch=@loopCatch+1

		END
	SELECT * FROM #prices
	DROP TABLE #prices
	
	--products
	EXEC CSK_Store_Product_GetByCategoryID @categoryID
	
	--bread crumbs
	EXEC CSK_Store_Category_GetCrumbs @categoryID
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Product_GetByCategoryName]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'



	CREATE PROCEDURE [dbo].[CSK_Store_Product_GetByCategoryName]
	(
		@categoryName nvarchar(50)
	)
	AS
	DECLARE @categoryID int
	SELECT @categoryID=categoryID FROM CSK_Store_Category WHERE categoryName=@categoryName
	EXEC CSK_Store_Product_GetByCategoryID @categoryID
	
	RETURN 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CSK_Store_Category_GetPageByNameMulti]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CSK_Store_Category_GetPageByNameMulti]
	(
		@categoryName nvarchar(50)
	)
AS
	DECLARE @categoryID int
	--replace the spaces here to accomodate URL rewrite
	SELECT @categoryID=categoryID FROM CSK_Store_Category WHERE REPLACE(categoryName,'' '','''')=REPLACE(@categoryName,'' '','''')


	EXEC CSK_Store_Category_GetPageMulti @categoryID
	RETURN
' 
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_ProductAttributes_CMRC_ProductAttributeTypes]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Attribute]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_ProductAttributes_CMRC_ProductAttributeTypes] FOREIGN KEY([attributeTypeID])
REFERENCES [dbo].[CSK_Store_AttributeType] ([attributeTypeID])
GO
ALTER TABLE [dbo].[CSK_Store_Attribute] CHECK CONSTRAINT [FK_CMRC_ProductAttributes_CMRC_ProductAttributeTypes]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_ProductAttributes_CMRC_Products]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Attribute]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_ProductAttributes_CMRC_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Store_Attribute] CHECK CONSTRAINT [FK_CMRC_ProductAttributes_CMRC_Products]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_Categories_CMRC_ProductCategories]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product_Category_Map]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_Categories_CMRC_ProductCategories] FOREIGN KEY([categoryID])
REFERENCES [dbo].[CSK_Store_Category] ([categoryID])
GO
ALTER TABLE [dbo].[CSK_Store_Product_Category_Map] CHECK CONSTRAINT [FK_CMRC_Products_Categories_CMRC_ProductCategories]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_Categories_CMRC_Products]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product_Category_Map]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_Categories_CMRC_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Store_Product_Category_Map] CHECK CONSTRAINT [FK_CMRC_Products_Categories_CMRC_Products]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_CMRC_Manufacturers]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_CMRC_Manufacturers] FOREIGN KEY([manufacturerID])
REFERENCES [dbo].[CSK_Store_Manufacturer] ([manufacturerID])
GO
ALTER TABLE [dbo].[CSK_Store_Product] CHECK CONSTRAINT [FK_CMRC_Products_CMRC_Manufacturers]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_CMRC_ProductStatus]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_CMRC_ProductStatus] FOREIGN KEY([statusID])
REFERENCES [dbo].[CSK_Store_ProductStatus] ([statusID])
GO
ALTER TABLE [dbo].[CSK_Store_Product] CHECK CONSTRAINT [FK_CMRC_Products_CMRC_ProductStatus]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_CMRC_ProductType]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_CMRC_ProductType] FOREIGN KEY([productTypeID])
REFERENCES [dbo].[CSK_Store_ProductType] ([productTypeID])
GO
ALTER TABLE [dbo].[CSK_Store_Product] CHECK CONSTRAINT [FK_CMRC_Products_CMRC_ProductType]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_CMRC_ShipEstimates]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_CMRC_ShipEstimates] FOREIGN KEY([shipEstimateID])
REFERENCES [dbo].[CSK_Store_ShippingEstimate] ([shipEstimateID])
GO
ALTER TABLE [dbo].[CSK_Store_Product] CHECK CONSTRAINT [FK_CMRC_Products_CMRC_ShipEstimates]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_CMRC_ShippingType]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_CMRC_ShippingType] FOREIGN KEY([shippingTypeID])
REFERENCES [dbo].[CSK_Store_ShippingType] ([shippingTypeID])
GO
ALTER TABLE [dbo].[CSK_Store_Product] CHECK CONSTRAINT [FK_CMRC_Products_CMRC_ShippingType]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_CMRC_TaxTypes]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Product]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_CMRC_TaxTypes] FOREIGN KEY([taxTypeID])
REFERENCES [dbo].[CSK_Tax_Type] ([taxTypeID])
GO
ALTER TABLE [dbo].[CSK_Store_Product] CHECK CONSTRAINT [FK_CMRC_Products_CMRC_TaxTypes]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_PROMOS_CMRC_PROMO_Campaigns]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Promo]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_PROMOS_CMRC_PROMO_Campaigns] FOREIGN KEY([campaignID])
REFERENCES [dbo].[CSK_Promo_Campaign] ([campaignID])
GO
ALTER TABLE [dbo].[CSK_Promo] CHECK CONSTRAINT [FK_CMRC_PROMOS_CMRC_PROMO_Campaigns]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_STATS_Tracker_CMRC_STATS_Behavior]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Stats_Tracker]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_STATS_Tracker_CMRC_STATS_Behavior] FOREIGN KEY([behaviorID])
REFERENCES [dbo].[CSK_Stats_Behavior] ([behaviorID])
GO
ALTER TABLE [dbo].[CSK_Stats_Tracker] CHECK CONSTRAINT [FK_CMRC_STATS_Tracker_CMRC_STATS_Behavior]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_Promos_CMRC_Products]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Promo_Product_Promo_Map]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_Promos_CMRC_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Promo_Product_Promo_Map] CHECK CONSTRAINT [FK_CMRC_Products_Promos_CMRC_Products]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_Promos_CMRC_PROMOS]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Promo_Product_Promo_Map]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_Promos_CMRC_PROMOS] FOREIGN KEY([promoID])
REFERENCES [dbo].[CSK_Promo] ([promoID])
GO
ALTER TABLE [dbo].[CSK_Promo_Product_Promo_Map] CHECK CONSTRAINT [FK_CMRC_Products_Promos_CMRC_PROMOS]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_ProductImages_CMRC_Products]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Image]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_ProductImages_CMRC_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Store_Image] CHECK CONSTRAINT [FK_CMRC_ProductImages_CMRC_Products]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CSK_Store_ProductDescriptor_CSK_Store_Product]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_ProductDescriptor]  WITH CHECK ADD  CONSTRAINT [FK_CSK_Store_ProductDescriptor_CSK_Store_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Store_ProductDescriptor] CHECK CONSTRAINT [FK_CSK_Store_ProductDescriptor_CSK_Store_Product]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_Bundles_CMRC_Bundles]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Promo_Product_Bundle_Map]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_Bundles_CMRC_Bundles] FOREIGN KEY([bundleID])
REFERENCES [dbo].[CSK_Promo_Bundle] ([bundleID])
GO
ALTER TABLE [dbo].[CSK_Promo_Product_Bundle_Map] CHECK CONSTRAINT [FK_CMRC_Products_Bundles_CMRC_Bundles]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_Products_Bundles_CMRC_Products]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Promo_Product_Bundle_Map]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_Products_Bundles_CMRC_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Promo_Product_Bundle_Map] CHECK CONSTRAINT [FK_CMRC_Products_Bundles_CMRC_Products]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CSK_Promo_Product_CrossSell_Map_CSK_Store_Product]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Promo_Product_CrossSell_Map]  WITH CHECK ADD  CONSTRAINT [FK_CSK_Promo_Product_CrossSell_Map_CSK_Store_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Promo_Product_CrossSell_Map] CHECK CONSTRAINT [FK_CSK_Promo_Product_CrossSell_Map_CSK_Store_Product]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CSK_Promo_Product_CrossSell_Map_CSK_Store_Product1]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Promo_Product_CrossSell_Map]  WITH CHECK ADD  CONSTRAINT [FK_CSK_Promo_Product_CrossSell_Map_CSK_Store_Product1] FOREIGN KEY([crossProductID])
REFERENCES [dbo].[CSK_Store_Product] ([productID])
GO
ALTER TABLE [dbo].[CSK_Promo_Product_CrossSell_Map] CHECK CONSTRAINT [FK_CSK_Promo_Product_CrossSell_Map_CSK_Store_Product1]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CSK_Store_OrderNote_CSK_Store_Order]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_OrderNote]  WITH CHECK ADD  CONSTRAINT [FK_CSK_Store_OrderNote_CSK_Store_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[CSK_Store_Order] ([orderID])
GO
ALTER TABLE [dbo].[CSK_Store_OrderNote] CHECK CONSTRAINT [FK_CSK_Store_OrderNote_CSK_Store_Order]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CSK_Store_OrderItem_CSK_Store_Order]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_CSK_Store_OrderItem_CSK_Store_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[CSK_Store_Order] ([orderID])
GO
ALTER TABLE [dbo].[CSK_Store_OrderItem] CHECK CONSTRAINT [FK_CSK_Store_OrderItem_CSK_Store_Order]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CMRC_OrderTransactions_CMRC_OrderTransactionTypes]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Transaction]  WITH CHECK ADD  CONSTRAINT [FK_CMRC_OrderTransactions_CMRC_OrderTransactionTypes] FOREIGN KEY([transactionTypeID])
REFERENCES [dbo].[CSK_Store_TransactionType] ([transactionTypeID])
GO
ALTER TABLE [dbo].[CSK_Store_Transaction] CHECK CONSTRAINT [FK_CMRC_OrderTransactions_CMRC_OrderTransactionTypes]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CSK_Store_Transaction_CSK_Store_Order]') AND type = 'F')
ALTER TABLE [dbo].[CSK_Store_Transaction]  WITH CHECK ADD  CONSTRAINT [FK_CSK_Store_Transaction_CSK_Store_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[CSK_Store_Order] ([orderID])
GO
ALTER TABLE [dbo].[CSK_Store_Transaction] CHECK CONSTRAINT [FK_CSK_Store_Transaction_CSK_Store_Order]
