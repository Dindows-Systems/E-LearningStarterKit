<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" Title="Commerce Starter Kit Login" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.3, Version=6.3.20063.53, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">
</script>
    <br />
    <br />
   <table style="width:750px;align:left" >
   <tr><td align="center"><asp:Label ID="LabelError" runat="server" Visible="False" Width="385px" ForeColor="Red"></asp:Label></td></tr>
   <tr><td align="center">  
    <table align="center"  class="logtable" >
            <tr>
                <td class="loginheader" >
                    <asp:Localize ID="NewCustomerContent" runat="server" meta:resourcekey="NewCustomerContentResource1" Text="I am a New Customer"></asp:Localize>
                </td>
                <td class="loginheader" >
                    <asp:Localize ID="ReturningCustomerContent" runat="server" meta:resourcekey="ReturningCustomerContentResource1" Text="I am a Returning Customer"></asp:Localize>
                </td>
            </tr>            
            <tr>
                <td class="logincell" >
                    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" CreateUserButtonText="Continue" meta:resourcekey="CreateUserWizard1Resource1" OnCreatedUser="CreateUserWizard1_CreatedUser">
                        <WizardSteps>
                            <asp:CreateUserWizardStep runat="server" meta:resourcekey="CreateUserWizardStepResource1">
                            <ContentTemplate>                                    
                                    <br />
                                    <table style="width:97%">
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Localize ID="NewRegister" runat="server" meta:resourcekey="NewRegisterResource1" Text="Sign Up for Your New Account"></asp:Localize></td>                                            
                                        </tr>
                                        <tr><td colspan="2">&nbsp;</td></tr>
                                        <tr>
                                            <td style="width:45%" align="left">
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" meta:resourcekey="UserNameLabelResource1" Text="Usuario:"></asp:Label></td>
                                            <td style="width:55%" align="left">
                                                <asp:TextBox ID="UserName" runat="server" meta:resourcekey="UserNameResource1"></asp:TextBox><asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                    ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1" meta:resourcekey="UserNameRequiredResource1" Text="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" meta:resourcekey="PasswordLabelResource1" Text="Password:"></asp:Label></td>
                                            <td align="left">
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" meta:resourcekey="PasswordResource1"></asp:TextBox><asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1" meta:resourcekey="PasswordRequiredResource1" Text="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword" meta:resourcekey="ConfirmPasswordLabelResource1" Text="Confirm Password:"></asp:Label></td>
                                            <td align="left">
                                            <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" meta:resourcekey="ConfirmPasswordResource1"></asp:TextBox><asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                                    ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                                    ValidationGroup="CreateUserWizard1" meta:resourcekey="ConfirmPasswordRequiredResource1" Text="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" meta:resourcekey="EmailLabelResource1" Text="E-mail:"></asp:Label></td>
                                            <td align="left">
                                                <asp:TextBox ID="Email" runat="server" meta:resourcekey="EmailResource1"></asp:TextBox><asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                                    ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1" meta:resourcekey="EmailRequiredResource1" Text="*"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Email"
                                                    ErrorMessage="Ingrese un correo valido." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ValidationGroup="CreateUserWizard1"></asp:RegularExpressionValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question" meta:resourcekey="QuestionLabelResource1" Text="Security Question:"></asp:Label></td>
                                            <td align="left">
                                                <asp:TextBox ID="Question" runat="server" meta:resourcekey="QuestionResource1"></asp:TextBox><asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
                                                    ErrorMessage="Security question is required." ToolTip="Security question is required."
                                                    ValidationGroup="CreateUserWizard1" meta:resourcekey="QuestionRequiredResource1" Text="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer" meta:resourcekey="AnswerLabelResource1" Text="Security Answer:"></asp:Label></td>
                                            <td align="left">
                                                <asp:TextBox ID="Answer" runat="server" meta:resourcekey="AnswerResource1"></asp:TextBox><asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                                    ErrorMessage="Security answer is required." ToolTip="Security answer is required."
                                                    ValidationGroup="CreateUserWizard1" meta:resourcekey="AnswerRequiredResource1" Text="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="left">
                                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                                    ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                                    ValidationGroup="CreateUserWizard1" meta:resourcekey="PasswordCompareResource1"></asp:CompareValidator></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="left">
                                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False" meta:resourcekey="ErrorMessageResource1"></asp:Literal></td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                Fecha de Nacimiento:</td>
                                            <td align="center" nowrap>
                                                <igtxt:WebDateTimeEdit ID="WebDateTimeEdit1" runat="server" Culture="Spanish (Ecuador)">
                                                </igtxt:WebDateTimeEdit>
                                                &nbsp; dd/mm/yyyy&nbsp;
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="WebDateTimeEdit1"
                                                    ErrorMessage="RequiredFieldValidator" ValidationGroup="CreateUserWizard1" meta:resourcekey="RequiredFieldValidator1Resource1" ></asp:RequiredFieldValidator>
                                                </td>                                                
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Localize ID="PaisContent" runat="server" meta:resourcekey="PaisContentResource1" Text="Pais"></asp:Localize></td>                                            
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownPaises" runat="server" DataSourceID="SqlDataSourcePaises"
                                                    DataTextField="descripcion" DataValueField="id_tipo" meta:resourcekey="DropDownPaisesResource1">
                                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourcePaises" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
                                                    SelectCommand="SELECT [id_tipo], [descripcion] FROM [Elearning_Tipo] WHERE ([id_super_tipo] = @id_super_tipo) and ([id_tipo] <> @id_tipo) ">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="1" Name="id_super_tipo" Type="Int32" />
                                                        <asp:Parameter DefaultValue="1" Name="id_tipo" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                Ciudad:</td>
                                            <td align="left">
                                                <asp:TextBox ID="TextBoxCiudades" runat="server" Width="143px" meta:resourcekey="TextBoxCiudadesResource1"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                                                    ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxCiudades"
                                                    ErrorMessage="RequiredFieldValidator" meta:resourcekey="RequiredFieldValidator2Resource1" ValidationGroup="CreateUserWizard1"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                Nivel de Estudios:</td>
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownNivelEstudio" runat="server" DataSourceID="SqlDataSourceNivelEstudio"
                                                    DataTextField="descripcion" DataValueField="id_tipo" meta:resourcekey="DropDownNivelEstudioResource1">
                                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceNivelEstudio" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
                                                    SelectCommand="SELECT [id_tipo], [descripcion] FROM [Elearning_Tipo] WHERE ([id_super_tipo] = @id_super_tipo)">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="3" Name="id_super_tipo" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                Ocupaci&oacute;n:</td>
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownOcupacion" runat="server" DataSourceID="SqlDataSourceOcupacion"
                                                    DataTextField="descripcion" DataValueField="id_tipo" meta:resourcekey="DropDownOcupacionResource1">
                                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceOcupacion" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
                                                    SelectCommand="SELECT [id_tipo], [descripcion] FROM [Elearning_Tipo] WHERE ([id_super_tipo] = @id_super_tipo)">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="4" Name="id_super_tipo" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                Area de Desempe&ntilde;o:</td>
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownListArea" runat="server" DataSourceID="SqlDataSourceArea"
                                                    DataTextField="descripcion" DataValueField="id_tipo" meta:resourcekey="DropDownListAreaResource1">
                                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceArea" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
                                                    SelectCommand="SELECT [id_tipo], [descripcion] FROM [Elearning_Tipo] WHERE ([id_super_tipo] = @id_super_tipo)">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="5" Name="id_super_tipo" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 58px">
                                                Cargo:</td>
                                            <td align="left" style="height: 58px">
                                                <asp:DropDownList ID="DropDownListCargo" runat="server" DataSourceID="SqlDataSourceCargo"
                                                    DataTextField="descripcion" DataValueField="id_tipo" meta:resourcekey="DropDownListCargoResource1">
                                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceCargo" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
                                                    SelectCommand="SELECT [id_tipo], [descripcion] FROM [Elearning_Tipo] WHERE ([id_super_tipo] = @id_super_tipo)">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="6" Name="id_super_tipo" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>                                        
                                    </table>
                                </ContentTemplate>
                            </asp:CreateUserWizardStep>
                            <asp:CompleteWizardStep runat="server" meta:resourcekey="CompleteWizardStepResource1" AllowReturn="false">                                
                            </asp:CompleteWizardStep>
                        </WizardSteps>
                    </asp:CreateUserWizard>
                
                </td>
                <td class="logincelltop" align="left" valign="top">
                    <br />
                    <br />                   
                     <asp:Login ID="Login1" runat="server"                    
                        PasswordRecoveryText="Forgot Password?" 
                        PasswordRecoveryUrl="~/PasswordRecover.aspx" meta:resourcekey="Login1Resource1" UserNameLabelText="Usuario:" 
                     >
                    </asp:Login>
                </td>
            </tr>
        </table>
        </td></tr></table>
</asp:Content>

