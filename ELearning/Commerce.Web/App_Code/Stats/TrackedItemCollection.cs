using System;
using System.Collections;

    
    /// <summary>
    /// Represents a collection of TrackedItem objects.
    /// </summary>
    public class TrackedItemCollection : System.Collections.ICollection
    {

        public const int COLLECTION_LIMIT = 5;
        public void Sort() {
            items.Sort();
        }
        
        
        // Provides the base object storage used by this class
        private System.Collections.ArrayList items;
        
        // This version counter is incremented any time the collection changes.
        private int listVersion;
        
        /// <summary>
        /// Initializes a new instance of the TrackedItemCollection> class.
        /// </summary>
        public TrackedItemCollection()
        {
            items = new System.Collections.ArrayList();
            listVersion = 0;
        }
        
        /// <summary>
        /// Returns a number that can be used to determine if the collection has changed since some previous
        /// reference point, since this value changes each time the collection is modified in any way.
        /// </summary>
        internal int Version
        {
            get
            {
                return listVersion;
            }
        }
        
        /// <summary>
        /// Gets the number objects contained in the collection.
        /// <summary>
        public virtual int Count
        {
            get
            {
                return items.Count;
            }
        }
        
        /// <summary>
        /// Gets a value indicating whether access to the collection is synchronized (thread-safe).
        /// <summary>
        public virtual bool IsSynchronized
        {
            get
            {
                return items.IsSynchronized;
            }
        }
        
        /// <summary>
        /// Gets an object that can be used to synchronize access to the collection.
        /// <summary>
        public virtual object SyncRoot
        {
            get
            {
                return items.SyncRoot;
            }
        }
        
        /// <summary>
        /// Returns the TrackedItem at the specified index of the TrackedItemCollection.
        /// </summary>
        /// <param name='index'>The zero-based index of the TrackedItem to locate in the collection.</param>
        /// <returns> The TrackedItem at the specified index of the collection.</returns>
        /// <exception cref='System.ArgumentOutOfRangeException'><paramref name='index'/> is outside the valid range of indexes for the collection.</exception>
        public virtual TrackedItem this[int index]
        {
            get
            {
                return ((TrackedItem)(this.items[index]));
            }
        }
        
        /// <summary>
        /// Called when an object is being inserted into the collection.
        /// </summary>
        public event TrackedItemCollectionChangedEventHandler Inserting;
        
        /// <summary>
        /// Called after an object has been inserted into the collection.
        /// </summary>
        public event TrackedItemCollectionChangedEventHandler InsertComplete;
        
        /// <summary>
        /// Called when an object is being removed from the collection.
        /// </summary>
        public event TrackedItemCollectionChangedEventHandler Removing;
        
        /// <summary>
        /// Called after an object has been removed from the collection.
        /// </summary>
        public event TrackedItemCollectionChangedEventHandler RemoveComplete;
        
        /// <summary>
        /// Called when the collection is being cleared.
        /// </summary>
        public event TrackedItemCollectionClearedEventHandler Clearing;
        
        /// <summary>
        /// Called after the collection has been cleared.
        /// </summary>
        public event TrackedItemCollectionClearedEventHandler ClearComplete;
        
        /// <summary>
        /// Internal method called whenever the collection changes to increment the Version property.
        /// </summary>
        private void IncrementVersion()
        {
            listVersion = (listVersion + 1);
        }
        
        /// <summary>
        /// Returns a <see cref='System.Collections.IEnumerator'/> object that can be used to enumerate
        /// the entire collection.
        /// </summary>
        public virtual System.Collections.IEnumerator GetEnumerator()
        {
            return items.GetEnumerator();
        }
        
        /// <summary>
        /// Copies the elements of this TrackedItemCollection to a System.Array, starting at a particular System.Array index.
        /// <summary>
        public virtual void CopyTo(System.Array array, int index)
        {
            items.CopyTo(array, index);
        }


        public void AddProduct(string sku, string productName, string imageFile) {
            TrackedItem item = new TrackedItem();
            item.ItemNumber = sku;
            item.ItemName = productName;
            item.ImagePath = imageFile;
            item.LastVisited = DateTime.Now;
            item.SortingBy = SortFilter.LastVisited;
            item.SortingOrder = SortOrder.Descending;
            Add(item);
            //Resort ... so controls don't have to worry about it.  
            Sort(); 
        }
        public void AddCategory(int categoryID, string categoryName) {
            TrackedItem item = new TrackedItem();
            item.ItemID = categoryID;
            item.ItemNumber = categoryID.ToString();
            item.ItemName = categoryName;
            item.LastVisited = DateTime.Now;
            item.SortingBy = SortFilter.ItemCount;
            item.SortingOrder = SortOrder.Descending;
            Add(item);

        }


        /// <summary>
        /// Adds the specified Favorite to the FavoriteCollection collection.
        /// </summary>
        /// <returns>The position into which the new element was inserted.</returns>
        public virtual int Add(TrackedItem value) {
            bool bFound = false;
            int retVal = 0;
            //check to see if this item is in the collection
            int index = 0;
            foreach (TrackedItem i in this) {
                if (i.ItemNumber.Equals(value.ItemNumber)) {
                    i.ItemCount++;
                    bFound = true;
                    retVal = index;
                    break;
                }
                index++;
            }

            if (!bFound) {
                if ((this.Inserting != null)) {
                    this.Inserting(this, value);
                }
                this.IncrementVersion();
                retVal = items.Add(value);
                if ((this.InsertComplete != null)) {
                    this.InsertComplete(this, value);
                }

                //check the limit
                if (this.Count > COLLECTION_LIMIT) {
                    this.RemoveAt(0);
                }
            }            
            return retVal;
        }
        
        
        /// <summary>
        /// Removes the specified TrackedItem from the TrackedItemCollection collection.
        /// </summary>
        public virtual void Remove(TrackedItem value)
        {
            if ((this.Removing != null))
            {
                this.Removing(this, value);
            }
            this.IncrementVersion();
            items.Remove(value);
            if ((this.RemoveComplete != null))
            {
                this.RemoveComplete(this, value);
            }
        }
        
        /// <summary>
        /// Removes the TrackedItem object at the specified index from the TrackedItemCollection collection.
        /// </summary>
        public virtual void RemoveAt(int index)
        {
            object obj = items[index];
            this.Remove(((TrackedItem)(obj)));
        }
        
        /// <summary>
        /// Inserts a TrackedItem object into the TrackedItemCollection collection at the specified position.
        /// </summary>
        /// <param name='index'>The zero-based index at which value should be inserted.</param>
        /// <param name='value'>The TrackedItem to insert into the TrackedItemCollection collection.</param>
        public virtual void Insert(int index, TrackedItem value)
        {
            if ((this.Inserting != null))
            {
                this.Inserting(this, value);
            }
            this.IncrementVersion();
            items.Insert(index, value);
            if ((this.InsertComplete != null))
            {
                this.InsertComplete(this, value);
            }
        }
        
        /// <summary>
        /// determines whether the TrackedItemCollection collection contains a specific TrackedItem object.
        /// </summary>
        /// <param name='value'>The TrackedItem object to locate in the TrackedItemCollection collection.</param>
        /// <returns>True if the System.Object is found in the collection; otherwise, False.</returns>
        public virtual bool Contains(TrackedItem value)
        {
            return items.Contains(value);
        }
        
        /// <summary>
        /// Removes all items from the collection.
        /// </summary>
        public virtual void Clear()
        {
            if ((this.Clearing != null))
            {
                this.Clearing(this);
            }
            this.IncrementVersion();
            items.Clear();
            if ((this.ClearComplete != null))
            {
                this.ClearComplete(this);
            }
        }
        
        /// <summary>
        /// Creates a shallow copy of the collection.
        /// </summary>
        public virtual TrackedItemCollection Clone()
        {
            TrackedItemCollection obj = new TrackedItemCollection();
            obj.items = ((System.Collections.ArrayList)(items.Clone()));
            obj.listVersion = this.listVersion;
            return obj;
        }
        
        /// <summary>
        /// Defines the type of event that is called whenever a new object is inserted into or removed from the TrackedItemCollection collection.
        /// </summary>
        public delegate void TrackedItemCollectionChangedEventHandler(object sender, TrackedItem value);
        
        /// <summary>
        /// Defines the type of event that is called whenever the collection is cleared.
        /// </summary>
        public delegate void TrackedItemCollectionClearedEventHandler(object sender);
    
	

	}






