var yafEditor = function(name) {
	this.Name			= name;
}

yafEditor.prototype.FormatText = function(command, option) {
	var textObj = document.getElementById(this.Name);
	switch(command) {
		case "bold":
			wrapSelection(textObj,"[b]","[/b]");
			break;
		case "italic":
			wrapSelection(textObj,"[i]","[/i]");
			break;
		case "underline":
			wrapSelection(textObj,"[u]","[/u]");
			break;
		case "code":
			wrapSelection(textObj,"[code]","[/code]");
			break;
		case "img":
			wrapSelection(textObj,"[img]","[/img]");
			break;
		case "quote":
			wrapSelection(textObj,"[quote]","[/quote]");
			break;
		case "justifyleft":
			wrapSelection(textObj,"[left]","[/left]");
			break;
		case "justifycenter":
			wrapSelection(textObj,"[center]","[/center]");
			break;
		case "justifyright":
			wrapSelection(textObj,"[right]","[/right]");
			break;
		case "createlink":
			var url = prompt('Enter URL:','http://');
			if (url != '' && url != null)
			{
				if (getSelection(textObj))
				{
					wrapSelection(textObj,'[url='+url+']','[/url]');
				}
				else
				{
					// ask for the description text...
					var desc = prompt('Enter URL Description:','');
					if (desc != '' && desc != null)
						replaceSelection(textObj,'[url='+url+']'+desc+'[/url]');
					else
						replaceSelection(textObj,'[url]'+url+'[/url]');
				}
			}
			break;
		case "color":
			wrapSelection(textObj,"[color="+option+"]","[/color]");
			break;
		case "fontsize":
			wrapSelection(textObj,"[size="+option+"]","[/size]");
			break;
		default:
			alert("Unknown in FormatText " + command);
			break;
	}
}

yafEditor.prototype.AddImage = function() {
	var textObj = document.getElementById(this.Name);
	var img = prompt('Enter image URL:','http://');
	if(img!='' && img!=null)
		replaceSelection(textObj,'[img]'+img+'[/img]');
}

yafEditor.prototype.InsertSmiley = function(code) {
	var textObj = document.getElementById(this.Name);
	replaceSelection(textObj,code);
}

function Button_Load(img) {
	img.className	= "ButtonOut";
	img.onmouseover	= function(){Button_Over(this);}
	img.onmouseout	= function(){Button_Out(this);}
}

function Button_Over(img) {
	if(typeof(img._enabled)=="boolean" && !img._enabled)
		img.className = "ButtonOff";
	else
		img.className = "ButtonOver";
}

function Button_Out(img) {
	if(typeof(img._enabled)=="boolean" && !img._enabled)
		img.className = "ButtonOff";
	else if(typeof(img._selected)=="boolean" && img._selected)
		img.className = "ButtonChecked";
	else
		img.className = "ButtonOut";
}

function Button_SetState(doc,name,cmd) {
	var img = document.getElementById(name);
	try {
		img._selected = doc.queryCommandState(cmd);
	}
	catch(e) {
		img._selected = false;
	}
	img._enabled	= doc.queryCommandEnabled(cmd);

	if(!img._enabled)
		img.className = "ButtonOff";
	else if(img._selected)
		img.className = "ButtonChecked";
	else
		img.className = "ButtonOut";
}

function storeCaret(input) {
	if(input.createTextRange) {
		input.caretPos = document.selection.createRange().duplicate();
	}
}

function setSelectionRange(input, selectionStart, selectionEnd) {
	if (input.setSelectionRange) {
		input.focus();
		input.setSelectionRange(selectionStart, selectionEnd);
	} else if(input.createTextRange) {
		var range = input.createTextRange();
		range.collapse(true);
		range.moveEnd('character', selectionEnd);
		range.moveStart('character', selectionStart);
		range.select();
	}
}

function setCaretToPos (input, pos) {
	setSelectionRange(input, pos, pos);
}

function replaceSelection (input, replaceString) {
	if (input.setSelectionRange) {
		var selectionStart = input.selectionStart;
		var selectionEnd = input.selectionEnd;
		input.value = input.value.substring(0, selectionStart)
					+ replaceString
					+ input.value.substring(selectionEnd);
		if (selectionStart != selectionEnd) // has there been a selection
			setSelectionRange(input, selectionStart, selectionStart + 
				replaceString.length);
		else // set caret
			setCaretToPos(input, selectionStart + replaceString.length);
	} else if (document.selection) {
		if(input.caretPos) {
			var caretPos = input.caretPos;
			caretPos.text = caretPos.text.charAt(caretPos.text.length - 1) == ' ' ? text + ' ' : replaceString;
			if(caretPos.text!='') {
				caretPos.moveStart('character', -replaceString.length);
				caretPos.select();
			}
		} else {
			input.value += replaceString;
		}
	} else {
		input.value += replaceString;
		input.focus();
	}
}

function wrapSelection (input, preString, postString) {
	if (input.setSelectionRange) {
		var selectionStart = input.selectionStart;
		var selectionEnd = input.selectionEnd;
		input.value = input.value.substring(0, selectionStart)
					+ preString
					+ input.value.substring(selectionStart,selectionEnd)
					+ postString
					+ input.value.substring(selectionEnd);
		if (selectionStart != selectionEnd) // has there been a selection
			setSelectionRange(input, selectionStart, preString.length + postString.length + selectionEnd);
		else // set caret
			setCaretToPos(input, selectionStart + (preString+postString).length);
	} else if (document.selection) {
		var sel = document.selection.createRange().text;
		if(sel) {
			document.selection.createRange().text = preString + sel + postString;
			input.focus();
		} else {
			input.value += preString + postString;
			input.focus();
		}
	} else {
		input.value += preString + postString;
		input.focus();
	}
}

function getSelection(input) {
	if(input.setSelectionRange) {
		return input.selectionStart != input.selectionEnd;
	} else if(document.selection) {
		var range = document.selection.createRange();
		return range.parentElement()==input && range.text!='';
	} else {
		return false;
	}
}
