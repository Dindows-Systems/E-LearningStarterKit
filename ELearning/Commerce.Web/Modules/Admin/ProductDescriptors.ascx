<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductDescriptors.ascx.cs" Inherits="Modules_Admin_ProductDescriptors" %>
			            <asp:Label ID="lblProductID" runat="server" Visible="False" meta:resourcekey="lblProductIDResource1"></asp:Label>
			            <h1>
                            <asp:Localize ID="DescriptorsContent" runat="server" meta:resourcekey="DescriptorsContentResource1" Text="Descriptors"></asp:Localize></h1>
				         <table class="admintable1">
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="DecriptiveSectionsContent" runat="server" meta:resourcekey="DecriptiveSectionsContentResource1" Text="Decriptive Sections"></asp:Localize>
                                    
                                </td>
					            <td class="adminitem" style="width:450px" >
                                    
                                    <asp:Repeater ID="rptDescriptors" runat="server" OnItemCommand="DeleteDescriptor">
                                       <ItemTemplate>
                                       <table width="100%" cellspacing="0">
                                            <tr bgcolor="whitesmoke">
                                                <td width="20">
                                                <asp:Label ID="lblDescriptorID" runat="server" Text='<%# Eval("descriptorID") %>' Visible="False" meta:resourcekey="lblDescriptorIDResource1"></asp:Label>
                                                <asp:ImageButton ID="imgSave" runat="server" ImageUrl="~/images/icons/icon_disk.gif"  CommandName="Save" CommandArgument='<%# Eval("descriptorID") %>' meta:resourcekey="imgSaveResource1"/></td>
                                                <td width="90%"> 
                                                    <b>
                                                        <%# Eval("title") %>
                                                    </b> &nbsp;<asp:CheckBox ID="chkIsBulletedList" runat="server" Checked='<%# (bool)Eval("isBulletedList") %>' Text="Is Bulleted List" meta:resourcekey="chkIsBulletedListResource1" />
                                                    &nbsp;&nbsp;<b><asp:Localize ID="ListOrderContent" runat="server" meta:resourcekey="ListOrderContentResource1" Text="List Order"></asp:Localize>:</b>&nbsp;<asp:TextBox ID="txtDescriptorListOrder" runat="server" Text='<%# Eval("listOrder") %>' width="20px" meta:resourcekey="txtDescriptorListOrderResource1"></asp:TextBox>
                                                </td>
                                                <td align="right">
                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/icons/delete.gif" CommandName="Delete" CommandArgument='<%# Eval("descriptorID") %>' meta:resourcekey="ImageButton1Resource1"/></td>                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">

                                                <asp:TextBox ID="txtDescriptor" runat="server" TextMode="MultiLine" Height="100px" Width="400px"
                                                Text='<%# Eval("descriptor") %>' meta:resourcekey="txtDescriptorResource1" ></asp:TextBox>
                                                
                                                </td>
                                            </tr>
                                       </table>
                                       </ItemTemplate>
                                       
                                    </asp:Repeater>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="AddDescriptiveSectionContent" runat="server" meta:resourcekey="AddDescriptiveSectionContentResource1" Text="Add a Descriptive Section"></asp:Localize></td>
					            <td class="adminitem" style="width: 450px">
                                    <asp:Localize ID="ListOrderContent" runat="server" meta:resourcekey="ListOrderContentResource2" Text="List Order"></asp:Localize><br />
                                    <asp:TextBox ID="txtDescriptorListOrder" runat="server" Width="28px" meta:resourcekey="txtDescriptorListOrderResource2">1</asp:TextBox><br />
                                    <asp:Localize ID="TitleContent" runat="server" meta:resourcekey="TitleContentResource1" Text="Title"></asp:Localize><br />
                                    <asp:TextBox ID="txtDescriptorTitle" runat="server" Width="300px" meta:resourcekey="txtDescriptorTitleResource1"></asp:TextBox><br />
                                    <asp:CheckBox ID="chkIsBulletedList" runat="server" Text="Is Bulleted List" meta:resourcekey="chkIsBulletedListResource2" /><br />
                                    <br />
                                    <asp:Localize ID="TextListContent" runat="server" meta:resourcekey="TextListContentResource1" Text="Text/List"></asp:Localize><br />
						            <asp:textbox id="txtDescriptor" runat="server" TextMode="MultiLine" Height="123px" Width="400px" meta:resourcekey="txtDescriptorResource2"></asp:textbox>
                                    <br />
                                    <asp:Button ID="btnSaveDescriptor" runat="server" Text="Save" OnClick="btnSaveDescriptor_Click" meta:resourcekey="btnSaveDescriptorResource1" /></td>
				            </tr>
				            </table> 