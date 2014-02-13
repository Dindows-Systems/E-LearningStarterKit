using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace WekeRoad.Tools
{
    [Serializable]
    public class ActiveList<ItemType> : List<ItemType> where ItemType : ActiveRecord<ItemType>, new()
    {
        

        public void Load(IDataReader rdr)
        {
            ItemType item = null;
            while (rdr.Read())
            {
                item = new ItemType();
                item.Load(rdr);
                this.Add(item);
            }
        }

        public void Load(DataTable tbl)
        {
            ItemType item = null;
            foreach (DataRow dr in tbl.Rows)
            {
                item = new ItemType();
                item.Load(dr);
                this.Add(item);
            }
        }
    }
}
