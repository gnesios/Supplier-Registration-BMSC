<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WPRegistrationFormUserControl.ascx.cs" Inherits="BMSCSupplierRegistration.WPRegistrationForm.WPRegistrationFormUserControl" %>

<div class="message-container"><asp:Literal ID="ltrMessage" runat="server"></asp:Literal></div>

<div id="divForm" runat="server">
<div class="fieldsgroup">
  <div class="header">Detalles de la empresa e informaci&oacute;n general</div>
  <div class="fields">
    <span class="print">Tipo de empresa</span>
    <asp:DropDownList ID="ddlType" runat="server" ToolTip="Tipo de empresa" ClientIDMode="Static">
      <asp:ListItem Text="EMPRESA JURÍDICA" Value="EJ" Selected="True" />
      <asp:ListItem Text="EMPRESA UNIPERSONAL" Value="EU" />
      <asp:ListItem Text="PERSONA NATURAL" Value="PN" />
    </asp:DropDownList>
    <span class="print">Nombre/Razón social (legal)</span>
    <asp:TextBox ID="txbName" runat="server" MaxLength="24" ToolTip="Nombre o razón social legal" placeholder="Nombre o razón social legal *" /><br class="print" />
    <span class="print">CI/NIT</span>
    <asp:TextBox ID="txbCi" runat="server" MaxLength="12" ToolTip="CI o NIT" placeholder="CI o NIT *" /><br class="print" />
    <span class="print">Dirección legal</span>
    <asp:TextBox ID="txbAddress" runat="server" MaxLength="255" ToolTip="Dirección legal" placeholder="Dirección legal *" /><br class="print" />
    <span class="print">Dirección de correspondencia</span>
    <asp:TextBox ID="txbMail" runat="server" MaxLength="128" ToolTip="Dirección de correspondencia" placeholder="Dirección de correspondencia *" /><br class="print" />
    <span class="print">Telefónos</span>
    <asp:TextBox ID="txbPhones" runat="server" MaxLength="64" ToolTip="Teléfonos" placeholder="Teléfonos *" /><br class="print" />
    <span class="print">Correo electrónico</span>
    <asp:TextBox ID="txbEmail" runat="server" MaxLength="64" ToolTip="Correo electrónico" placeholder="Correo electrónico (opcional)" /><br class="print" />
    <span class="print">Página Web</span>
    <asp:TextBox ID="txbWebsite" runat="server" MaxLength="128" ToolTip="Página web" placeholder="Página web (opcional)" /><br class="print" />
    <hr />
    <span class="print">Nombre representante legal o propietario</span>
    <asp:TextBox ID="txbLegal1" runat="server" MaxLength="64" ToolTip="Nombre del representante legal o propietario" placeholder="Nombre del representante legal o propietario *" /><br class="print" />
    <span class="print">Cargo representante legal o propietario</span>
    <asp:TextBox ID="txbLegal2" runat="server" MaxLength="64" ToolTip="Cargo del representante legal" placeholder="Cargo del representante legal o propietario *" /><br class="print" />
    <span class="print">Correo electrónico representante legal o propietario</span>
    <asp:TextBox ID="txbLegal3" runat="server" MaxLength="64" ToolTip="Correo electrónico del representante legal o propietario" placeholder="Correo electrónico del representante legal o propietario (opc.)" /><br class="print" />
    <span class="print">Teléfonos representante legal o propietario</span>
    <asp:TextBox ID="txbLegal4" runat="server" MaxLength="64" ToolTip="Teléfonos del representante legal o propietario" placeholder="Teléfonos del representante legal o propietario *" /><br class="print" />
    <hr />
    <span class="print">Producto/Servicio General</span>
    <asp:DropDownList ID="ddlServiceGen1" runat="server" ToolTip="Producto o servicio ofrecido 1 (general)" /><br class="print" />
    <asp:DropDownList ID="ddlServiceGen2" runat="server" ToolTip="Producto o servicio ofrecido 2 (general)" /><br class="print" />
    <span class="print">Productos/Servicios Específicos</span>
    <asp:TextBox ID="txbServiceSpe" runat="server" TextMode="MultiLine" ToolTip="Producto o servicio ofrecido (específico)" placeholder="Producto o servicio ofrecido (específico) *" /><br class="print" />
    <span class="print form">Lugar donde provee el servicio *</span>
    <asp:CheckBoxList ID="cblCity" runat="server" RepeatColumns="2" RepeatDirection="Vertical" ToolTip="Lugar donde provee el servicio *" RepeatLayout="Table" ClientIDMode="Static">
      <asp:ListItem Text="NACIONAL" Value="NACIONAL" />
      <asp:ListItem Text="LA PAZ" Value="LP" Selected="True" />
      <asp:ListItem Text="COCHABAMBA" Value="CB" Selected="True" />
      <asp:ListItem Text="SANTA CRUZ" Value="SCZ" Selected="True" />
      <asp:ListItem Text="POTOSÍ" Value="PO" />
      <asp:ListItem Text="BENI" Value="BE" />
      <asp:ListItem Text="INTERNACIONAL" Value="INTERNACIONAL" />
      <asp:ListItem Text="TARIJA" Value="TJA" />
      <asp:ListItem Text="ORURO" Value="OR" />
      <asp:ListItem Text="PANDO" Value="PA" />
      <asp:ListItem Text="SUCRE" Value="SU" />
    </asp:CheckBoxList><br class="print" />
  </div>
  <asp:Label ID="lblCity" runat="server" Visible="false" CssClass="error-message">* debe elegir al menos una ciudad</asp:Label>
  <asp:ValidationSummary ID="sum1" runat="server" DisplayMode="BulletList" HeaderText="* debe llenar todos los campos" CssClass="error-message" ClientIDMode="Static" ValidationGroup="group1" />
  <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txbName" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvCi" runat="server" ControlToValidate="txbCi" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txbAddress" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvMail" runat="server" ControlToValidate="txbMail" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvPhones" runat="server" ControlToValidate="txbPhones" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RegularExpressionValidator ID="rxvEmail" runat="server" ControlToValidate="txbEmail" CssClass="error-message" Text="* 'Correo electrónico' no válido" Display="Dynamic" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="true" />
  <asp:RegularExpressionValidator ID="revWebsite" runat="server" ControlToValidate="txbWebsite" CssClass="error-message" Text="* 'Página web' no válida" Display="Dynamic" ValidationExpression="^((ftp|http|https):\/\/)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$" SetFocusOnError="true" />
  <asp:RequiredFieldValidator ID="rfvLegal1" runat="server" ControlToValidate="txbLegal1" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvLegal2" runat="server" ControlToValidate="txbLegal2" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RegularExpressionValidator ID="rxvLegal3" runat="server" ControlToValidate="txbLegal3" CssClass="error-message" Text="* 'Correo electrónico del representante' no válido" Display="Dynamic" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="true" />
  <asp:RequiredFieldValidator ID="rfvLegal4" runat="server" ControlToValidate="txbLegal4" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvServiceGen1" runat="server" ControlToValidate="ddlServiceGen1" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvServiceGen2" runat="server" ControlToValidate="ddlServiceGen2" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvServiceSpe" runat="server" ControlToValidate="txbServiceSpe" CssClass="error-message" ValidationGroup="group1" SetFocusOnError="true"></asp:RequiredFieldValidator>
</div>
<div class="fieldsgroup">
  <div class="header">Informaci&oacute;n bancaria</div>
  <div class="fields">
    <span class="print">Nombre del Banco</span>
    <asp:TextBox ID="txbBank1" runat="server" MaxLength="32" ToolTip="Nombre del Banco" placeholder="Nombre del Banco *" /><br class="print" />
    <span class="print">Nombre del beneficiario</span>
    <asp:TextBox ID="txbBank2" runat="server" MaxLength="64" ToolTip="Nombre del beneficiario" placeholder="Nombre del beneficiario *" /><br class="print" />
    <span class="print">Número de cuenta de pago BMSC (Pago a cuentas de otros Bancos, efectivo o cheques sólo excepciones previa autorización) (Pago cuentas proveedores del Exterior incluir datos completos SWIFT)</span>
    <asp:TextBox ID="txbBank3" runat="server" MaxLength="16" ToolTip="Número de cuenta de pago BMSC" placeholder="Número de cuenta de pago BMSC *" /><br class="print" />
    <span class="print">Moneda</span>
    <asp:DropDownList ID="ddlBank4" runat="server" ToolTip="Moneda">
      <asp:ListItem Text="BOLIVIANOS" Value="BOLIVIANOS" Selected="True" />
      <asp:ListItem Text="DÓLARES" Value="DOLARES" />
      <asp:ListItem Text="EUROS" Value="EUROS" />
      <asp:ListItem Text="OTRA" Value="OTRA" />
    </asp:DropDownList>
    <span class="links">En caso de no contar con una cuenta en el Banco Mercantil Santa Cruz S.A. y de ser adjudicados para algún proceso deberán llenar los formularios indicados en:
      <a href="/Documents/Proveedores/Formulario_Informacion_Bancaria_1.xlsx">ARCHIVO A</a> y <a href="/Documents/Proveedores/Formulario_Informacion_Bancaria_2.xlsx">ARCHIVO B</a>.
    </span>
  </div>
  <asp:ValidationSummary ID="sum2" runat="server" DisplayMode="BulletList" HeaderText="* debe llenar todos los campos" CssClass="error-message" ClientIDMode="Static" ValidationGroup="group2" />
  <asp:RequiredFieldValidator ID="rfvBank1" runat="server" ControlToValidate="txbBank1" CssClass="error-message" ValidationGroup="group2" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvBank2" runat="server" ControlToValidate="txbBank2" CssClass="error-message" ValidationGroup="group2" SetFocusOnError="true"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="rfvBank3" runat="server" ControlToValidate="txbBank3" CssClass="error-message" ValidationGroup="group2" SetFocusOnError="true"></asp:RequiredFieldValidator>
</div>

<div class="fieldsgroup documents">
  <div class="header">Documentos requeridos a ser adjuntados</div>
  <div class="fields">
    <span id="checkdoc1_span" runat="server"><input id="checkdoc1" class="check" type="checkbox" runat="server" ClientIDMode="Static"><label for="checkdoc1">Testimonio de constituci&oacute;n</label>
      <span class="infopopup" id="infopopup1" onclick="Popup(this);">
        <span class="infoicon"></span>
        <span class="infotext" id="infotext1">
          Testimonio de Constitución debidamente inscrito y resellado en FUNDEMPRESA (empresas unipersonales no requieren presentar esta documentación).
        </span>
      </span>
    </span>
    <span id="checkdoc2_span" runat="server"><input id="checkdoc2" class="check" type="checkbox" runat="server" ClientIDMode="Static" checked disabled><label for="checkdoc2">Poder del representante legal</label>
      <span class="infopopup" id="infopopup2" onclick="Popup(this);">
        <span class="infoicon"></span>
        <span class="infotext" id="infotext2">
          Poder del Representante Legal debidamente inscrito en FUNDEMPRESA, y que contenga facultades otorgadas al apoderado para participar en procesos de licitación, presentar propuestas y en su caso suscribir contratos para la provisión/prestación del bien/servicio... (Este requisito no aplica a empresas unipersonales).
        </span>
      </span>
    </span>
    <span id="checkdoc3_span" runat="server"><input id="checkdoc3" class="check" type="checkbox" runat="server" ClientIDMode="Static"><label for="checkdoc3">Matrícula de comercio</label>
      <span class="infopopup" id="infopopup3" onclick="Popup(this);">
        <span class="infoicon"></span>
        <span class="infotext" id="infotext3">
          Matrícula de Comercio ante FUNDEMPRESA debidamente actualizada y vigente a su presentación (Certificado de Vigencia de Matrícula de Registro de Empresa en Bolivia, si se trata de empresa constituida como Sociedad en cualquiera de las modalidades).
        </span>
      </span>
    </span>
    <span><input id="checkdoc4" class="check" type="checkbox" runat="server" ClientIDMode="Static"><label for="checkdoc4">Número de identificación tributaria</label>
      <span class="infopopup" id="infopopup4" onclick="Popup(this);">
        <span class="infoicon"></span>
        <span class="infotext" id="infotext4">
          Número de Identificación Tributaria (N.I.T.) vigente.
        </span>
      </span>
    </span>
    <span><input id="checkdoc5" class="check" type="checkbox" runat="server" ClientIDMode="Static" checked disabled><label for="checkdoc5">Cédula de identidad del representante legal</label>
      <span class="infopopup" id="infopopup5" onclick="Popup(this);">
        <span class="infoicon"></span>
        <span class="infotext" id="infotext5">
          Cédula de Identidad del Representante Legal vigente a la fecha de presentación de la propuesta.
        </span>
      </span>
    </span>
    <span><input id="checkdoc6" class="check" type="checkbox" runat="server" ClientIDMode="Static" checked disabled><label for="checkdoc6">Formulario de registro de proveedor</label>
      <span class="infopopup" id="infopopup6" onclick="Popup(this);">
        <span class="infoicon"></span>
        <span class="infotext" id="infotext6">
          Formulario Registro de Proveedores, el cual es generado en la siguiente pantalla; debe imprimir, firmar y convertirlo a PDF para adjuntarlo a este formulario de registro.
        </span>
      </span>
    </span>
  </div>
</div>

<div class="print legal">
  Yo / Nosotros autorizo / autorizamos al Banco Mercantil Santa Cruz S.A. a investigar todos mis / nuestros antecedentes personales y/o comerciales que se encuentren en bases de datos administrados por la Autoridad de Supervisión del Sistema Financiero, por cualquier Buró de Información o por otras entidades públicas o privadas a efectos de que el Banco pueda considerar y evaluar la documentación adjunta.  Asimismo, autorizo / autorizamos expresamente al Banco efectuar esta labor por intermedio de terceras empresas contratadas para dicho fin bajo los respectivos términos y condiciones de confidencialidad conforme a Ley.  El Banco será propietario exclusivo de toda información que obtenga y no estará obligado a emitir información alguna, ni a restituir los antecedentes que se hubieran recopilado en el curso de las investigaciones emergentes de manera previa a las solicitudes de los créditos relacionados. Toda la información contenida en este formulario es una declaración jurada, en caso de adjudicación, me / nos comprometo / comprometemos a presentar la documentación de respaldo declarada en original o fotocopia legalizada, si así se requiere.
</div>

<div id="divAttach" runat="server" class="fieldsgroup attach" visible="false">
  <div class="header">Documentos adjuntados</div>
  <div class="fields">
    <span id="file1_span" runat="server">
      <asp:FileUpload ID="file1" runat="server" accept=".pdf" onchange="UploadFile(this);" ClientIDMode="Static" />
      <label for="file1">
        <span id="file-name1" class="file-box">Testimonio de constituci&oacute;n</span>
        <span class="file-button">buscar archivo...</span>
      </label>
    </span>
    <span id="file2_span" runat="server">
      <asp:FileUpload ID="file2" runat="server" accept=".pdf" onchange="UploadFile(this);" ClientIDMode="Static" />
      <label for="file2">
        <span id="file-name2" class="file-box">Poder del representante legal</span>
        <span class="file-button">buscar archivo...</span>
      </label>
    </span>
    <span id="file3_span" runat="server">
      <asp:FileUpload ID="file3" runat="server" accept=".pdf" onchange="UploadFile(this);" ClientIDMode="Static" />
      <label for="file3">
        <span id="file-name3" class="file-box">Matr&iacute;cula de comercio</span>
        <span class="file-button">buscar archivo...</span>
      </label>
    </span>
    <span id="file4_span" runat="server">
      <asp:FileUpload ID="file4" runat="server" accept=".pdf" onchange="UploadFile(this);" ClientIDMode="Static" />
      <label for="file4">
        <span id="file-name4" class="file-box">N&uacute;mero de identificaci&oacute;n tributaria</span>
        <span class="file-button">buscar archivo...</span>
      </label>
    </span>
    <span id="file5_span" runat="server">
      <asp:FileUpload ID="file5" runat="server" accept=".pdf" onchange="UploadFile(this);" ClientIDMode="Static" />
      <label for="file5">
        <span id="file-name5" class="file-box">C&eacute;dula de identidad del representante legal</span>
        <span class="file-button">buscar archivo...</span>
      </label>
    </span>
    <span>
      <asp:FileUpload ID="file6" runat="server" accept=".pdf" onchange="UploadFile(this);" ClientIDMode="Static" />
      <label for="file6">
        <span id="file-name6" class="file-box">Formulario de registro de proveedor</span>
        <span class="file-button">buscar archivo...</span>
      </label>
    </span>
  </div>
  <asp:RegularExpressionValidator ID="revFile1" runat="server" ErrorMessage="* debe cargar un archivo en formato pdf" Display="Dynamic" ValidationExpression="^.+(.pdf|.PDF)$" ControlToValidate="file1" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:CustomValidator ID="cuvFile1" runat="server" ErrorMessage="* el archivo cargado excede el límite de 1 MB" Display="Dynamic" ControlToValidate="file1" OnServerValidate="cuvFile1_ServerValidate" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:RegularExpressionValidator ID="revFile2" runat="server" ErrorMessage="* debe cargar un archivo en formato pdf" Display="Dynamic" ValidationExpression="^.+(.pdf|.PDF)$" ControlToValidate="file2" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:CustomValidator ID="cuvFile2" runat="server" ErrorMessage="* el archivo cargado excede el límite de 1 MB" Display="Dynamic" ControlToValidate="file2" OnServerValidate="cuvFile2_ServerValidate" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:RegularExpressionValidator ID="revFile3" runat="server" ErrorMessage="* debe cargar un archivo en formato pdf" Display="Dynamic" ValidationExpression="^.+(.pdf|.PDF)$" ControlToValidate="file3" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:CustomValidator ID="cuvFile3" runat="server" ErrorMessage="* el archivo cargado excede el límite de 1 MB" Display="Dynamic" ControlToValidate="file3" OnServerValidate="cuvFile3_ServerValidate" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:RegularExpressionValidator ID="revFile4" runat="server" ErrorMessage="* debe cargar un archivo en formato pdf" Display="Dynamic" ValidationExpression="^.+(.pdf|.PDF)$" ControlToValidate="file4" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:CustomValidator ID="cuvFile4" runat="server" ErrorMessage="* el archivo cargado excede el límite de 1 MB" Display="Dynamic" ControlToValidate="file4" OnServerValidate="cuvFile4_ServerValidate" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:RegularExpressionValidator ID="revFile5" runat="server" ErrorMessage="* debe cargar un archivo en formato pdf" Display="Dynamic" ValidationExpression="^.+(.pdf|.PDF)$" ControlToValidate="file5" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:CustomValidator ID="cuvFile5" runat="server" ErrorMessage="* el archivo cargado excede el límite de 1 MB" Display="Dynamic" ControlToValidate="file5" OnServerValidate="cuvFile5_ServerValidate" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:RegularExpressionValidator ID="revFile6" runat="server" ErrorMessage="* debe cargar un archivo en formato pdf" Display="Dynamic" ValidationExpression="^.+(.pdf|.PDF)$" ControlToValidate="file6" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:CustomValidator ID="cuvFile6" runat="server" ErrorMessage="* el archivo cargado excede el límite de 1 MB" Display="Dynamic" ControlToValidate="file6" OnServerValidate="cuvFile6_ServerValidate" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:RequiredFieldValidator ID="rfvFile1" runat="server" ErrorMessage="* debe cargar el documento testimonio" Display="Dynamic" ControlToValidate="file1" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" Enabled="false" />
  <asp:RequiredFieldValidator ID="rfvFile2" runat="server" ErrorMessage="* debe cargar el documento poder" Display="Dynamic" ControlToValidate="file2" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" Enabled="false" />
  <asp:RequiredFieldValidator ID="rfvFile3" runat="server" ErrorMessage="* debe cargar el documento matrícula" Display="Dynamic" ControlToValidate="file3" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" Enabled="false" />
  <asp:RequiredFieldValidator ID="rfvFile4" runat="server" ErrorMessage="* debe cargar el documento NIT" Display="Dynamic" ControlToValidate="file4" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" Enabled="false" />
  <asp:RequiredFieldValidator ID="rfvFile5" runat="server" ErrorMessage="* debe cargar el documento CI" Display="Dynamic" ControlToValidate="file5" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
  <asp:RequiredFieldValidator ID="rfvFile6" runat="server" ErrorMessage="* debe cargar el formulario impreso y firmado" Display="Dynamic" ControlToValidate="file6" CssClass="error-message" ValidationGroup="group3" SetFocusOnError="true" />
</div>

<div class="print note">* Información adicional técnica y/o legal de la empresa podrá solicitarse de acuerdo a requerimiento del Banco Mercantil Santa Cruz S.A.</div>
<div class="print sign">Firma(s) Representante(s) Legales de la Empresa</div>

<div id="divCaptcha" runat="server" class="captcha" visible="false">
  <script src='https://www.google.com/recaptcha/api.js'></script>
  <div class="g-recaptcha" data-sitekey="<%= ConfigurationManager.AppSettings["SiteKey"] %>"></div>
  <asp:Label runat="server" ID="lblCaptcha" CssClass="error-message"></asp:Label>
</div>

<asp:Button runat="server" ID="btnPrint" Text="Imprimir" OnClick="btnPrint_Click" />
<asp:Button runat="server" ID="btnConfirm" Text="Confirmar" OnClick="btnConfirm_Click" Visible="false" ValidationGroup="group3" />
<input type="button" runat="server" id="btnPrintAgain" value="Reimprimir formulario" visible="false" onclick="window.print();" />
<asp:Label ID="lblError" runat="server" class="error-message"></asp:Label>
<script src="/_catalogs/masterpage/bmsc/supplier/form.js"></script>
</div>