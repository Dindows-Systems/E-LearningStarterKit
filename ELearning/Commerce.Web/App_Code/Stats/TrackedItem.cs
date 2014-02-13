using System;
public enum SortFilter {
    ItemCount,
    LastVisited
}

public enum SortOrder {
    Ascending,
    Descending
}
public class TrackedItem:IComparable {

    private int _itemID;

    public int ItemID {
        get {
            return _itemID;
        }
        set {
            _itemID = value;
        }
    }
    private string itemNumber;

    public string ItemNumber
    {
        get { return itemNumber; }
        set { itemNumber = value; }
    }
	
    private string _itemName;

    public string ItemName {
        get {
            return _itemName;
        }
        set {
            _itemName = value;
        }
    }

    private int _itemCount;

    public int ItemCount {
        get {
            return _itemCount;
        }
        set {
            _itemCount = value;
        }
    }
    private DateTime _lastVisited;

    public DateTime LastVisited {
        get {
            return _lastVisited;
        }
        set {
            _lastVisited = value;
        }
    }
    private string  _imagePath;

    public string  ImagePath {
        get {
            return _imagePath;
        }
        set {
            _imagePath = value;
        }
    }
	
    private SortFilter sortingBy = SortFilter.ItemCount;
    public SortFilter SortingBy {
        get {
            return sortingBy;
        }
        set {
            sortingBy = value;
        }
    }

    private  SortOrder sortingOrder = SortOrder.Ascending;
    public  SortOrder SortingOrder {
        get {
            return sortingOrder;
        }
        set {
            sortingOrder = value;
        }
    }
    #region IComparable 

    public int CompareTo(object o) {
        if (!(o is TrackedItem))
            throw new InvalidCastException(Resources.Common.NotValidTrackedItem);
        TrackedItem fav = (TrackedItem)o;
        switch (SortingBy) {
            case SortFilter.ItemCount:
                if (sortingOrder == SortOrder.Ascending)
                    return this.ItemCount.CompareTo(fav.ItemCount);
                else
                    return fav.ItemCount.CompareTo(this.ItemCount);
            case SortFilter.LastVisited:
                if (sortingOrder == SortOrder.Ascending)
                    return this.LastVisited.CompareTo(fav.LastVisited);
                else
                    return fav.LastVisited.CompareTo(this.LastVisited);
            default:
                goto case SortFilter.ItemCount;
        }
    }

    #endregion
}