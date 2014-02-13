using System;
using System.Collections.Generic;
using System.Text;

namespace Commerce.Stats
{
    public enum BehaviorType : int
    {
        BrowsingCategory = 1,
        BrowsingProduct = 2,
        ClickingOnAd = 3,
        ClickingOnPromo = 4,
        ClickingOnUpsell = 5,
        ClickingOnCrosssell = 6,
        ClickingOnBundle = 7,
        RunningSearch = 8,
        AddingItemToBasket = 9,
        CheckingOut = 10,
        Paying = 11,
        ViewingReceipt = 12,
        RemovingItemFromBasket = 13,
        AdjustingQuantity = 14,
        LoggingIn = 15,
        LoggingOut = 16
    }
}
