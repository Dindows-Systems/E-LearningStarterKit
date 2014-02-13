-- UPDATE A CSK_Shipping_GetRates
ALTER PROCEDURE [dbo].[CSK_Shipping_GetRates]
	(
		@baseShipping money,
		@constant money,
		@additionalItems int
	)
AS
	--this is a very simple rate calculator that does not take into account
	--distance. Use only for testing
	SELECT     shippingRateID, Service, AmountPerUnit, @baseShipping + (@constant * @additionalItems) AS Rate, isAirOnly, isGroundOnly
	FROM         CSK_Shipping_Rate
	RETURN

