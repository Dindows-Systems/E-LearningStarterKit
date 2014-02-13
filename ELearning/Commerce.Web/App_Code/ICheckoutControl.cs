using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Common interface for checkout controls.  
/// </summary>
public interface ICheckoutControl
{
	event EventHandler<CheckoutMessageEventArgs> SetCheckoutMessage;
	event EventHandler NextStep;

	void SaveCurrentInfo(); 

	Commerce.Common.Order ShoppingCart { get;set;}

	string Name { get;}
	string Title { get;}
	
}
public class CheckoutMessageEventArgs:EventArgs
{
	private string _message;

	public CheckoutMessageEventArgs (string message, bool isSuccess)
	{
		_message = message;
		_isSuccess = isSuccess; 
	}

	private bool _isSuccess;
	public bool IsSuccess
	{
		get { return _isSuccess; }
	}


	public string Message
	{
		get { return _message;}
	}

}