using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Commerce.Promotions
{
	internal static class Helper
	{
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        public static Database GetDB()
        {
            return DatabaseFactory.CreateDatabase();
        }
        
        
        public static byte GetByte(object oVal)
		{
			try
			{
				return (byte)oVal;
			}
			catch
			{
				return 0;
			}
		}

		public static int GetInt(object iVal)
		{

			try
			{
				return (int)iVal;
			}
			catch
			{
				return 0;
			}
		}
		public static bool GetBool(object oVal)
		{
			try
			{
				return (bool)oVal;
			}
			catch
			{
				return false;
			}
		}
		public static decimal GetDecimal(object iVal)
		{
			try
			{
				return (decimal)iVal;
			}
			catch
			{
				return 0;
			}
		}
		public static DateTime GetDateTime(object dVal)
		{
			try
			{
				return (DateTime)dVal;
			}
			catch
			{
				return DateTime.Parse("1/1/1900");
			}

		}
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
		public static double GetDouble(object dVal)
		{
			try
			{
				return (double)dVal;
			}
			catch
			{
				return 0;
			}
		}
		public static string GetString(object oVal)
		{
			return oVal.ToString();
		}
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
		public static long GetLong(object dVal)
		{
			try
			{
				return (long)dVal;
			}
			catch
			{
				return 0;
			}
		}
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
		public static short GetShort(object dVal)
		{
			try
			{
				return (short)dVal;
			}
			catch
			{
				return 0;
			}
		}
	}
}
