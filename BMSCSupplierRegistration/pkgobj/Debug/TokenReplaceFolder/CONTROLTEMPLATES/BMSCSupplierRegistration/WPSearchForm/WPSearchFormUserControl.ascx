<%@ Assembly Name="BMSCSupplierRegistration, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e2abc8d62ca535cb" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WPSearchFormUserControl.ascx.cs" Inherits="BMSCSupplierRegistration.WPSearchForm.WPSearchFormUserControl" %>

<div class="message-container"><asp:Literal ID="ltrMessage" runat="server"></asp:Literal></div>

<div id="divFieldsgroup" runat="server" class="fieldsgroup">
  <div class="header">C&oacute;digo de proveedor</div>
  <div class="fields">
    <asp:TextBox ID="txbCode" runat="server" MaxLength="15" ToolTip="Ingresa tu código de proveedor" placeholder="Código de proveedor *" />
    <asp:TextBox ID="txbHiring" runat="server" ToolTip="Convocatoria relacionada" ReadOnly="true" TextMode="MultiLine" />
  </div>
  <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txbCode" CssClass="error-message" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvHiring" runat="server" ControlToValidate="txbHiring" CssClass="error-message" SetFocusOnError="true"></asp:RequiredFieldValidator>
</div>

<div id="divCaptcha" runat="server" class="captcha">
  <script src='https://www.google.com/recaptcha/api.js'></script>
  <div class="g-recaptcha" data-sitekey="<%= ConfigurationManager.AppSettings["SiteKey"] %>"></div>
  <asp:Label runat="server" ID="lblCaptcha" CssClass="error-message"></asp:Label>
</div>

<asp:Button runat="server" ID="btnConfirm" Text="Confirmar" OnClick="btnConfirm_Click" />
<asp:Label ID="lblError" runat="server" class="error-message"></asp:Label>
