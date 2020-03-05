using Microsoft.SharePoint;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace BMSCSupplierRegistration.WPRegistrationForm
{
    public partial class WPRegistrationFormUserControl : UserControl
    {
        private const string LIST_SUPPLIERS = "Proveedores";
        private const string LIST_BUSINESS = "Rubros Proveedores";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            List<Business> supplierBusiness = this.GetSupplierBusiness();
            ddlServiceGen1.DataSource = supplierBusiness;
            ddlServiceGen2.DataSource = supplierBusiness;

            ddlServiceGen1.DataValueField = "Id";
            ddlServiceGen2.DataValueField = "Id";
            ddlServiceGen1.DataTextField = "Name";
            ddlServiceGen2.DataTextField = "Name";

            ddlServiceGen1.DataBind();
            ddlServiceGen2.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid && this.IsCaptchaValid())
                {
                    SPSecurity.RunWithElevatedPrivileges(delegate()
                    {
                        using (SPSite sps = new SPSite(SPContext.Current.Web.Url))
                        using (SPWeb spw = sps.OpenWeb())
                        {
                            SPListItemCollection itemsList = spw.Lists[LIST_SUPPLIERS].Items;
                            SPListItem newItem = itemsList.Add();

                            newItem["Tipo_x0020_empresa"] = ddlType.SelectedItem.Text;
                            newItem["Title"] = txbName.Text.Trim();
                            newItem["NIT"] = txbCi.Text.Trim();
                            newItem["Direcci_x00f3_n"] = txbAddress.Text.Trim();
                            newItem["Correo"] = txbMail.Text.Trim();
                            newItem["Tel_x00e9_fonos"] = txbPhones.Text.Trim();
                            newItem["Correo_x0020_e_x002e_"] = txbEmail.Text.Trim();
                            newItem["P_x00e1_gina_x0020_web"] = string.IsNullOrWhiteSpace(txbWebsite.Text) ? "" : txbWebsite.Text.Trim();
                            newItem["Nombre_x0020_rep_x002e__x0020_le"] = txbLegal1.Text.Trim();
                            newItem["Cargo_x0020_rep_x002e__x0020_leg"] = txbLegal2.Text.Trim();
                            newItem["Correo_x0020_rep_x002e__x0020_le"] = txbLegal3.Text.Trim();
                            newItem["Tel_x00e9_fonos_x0020_rep_x002e_"] = txbLegal4.Text.Trim();
                            newItem["Prod_x002e__x0020_serv_x002e__x0"] = ddlServiceGen1.SelectedItem.Text;
                            newItem["Prod_x002e__x0020_serv_x002e__x01"] = ddlServiceGen2.SelectedItem.Text;
                            newItem["Prod_x002e__x0020_serv_x002e__x00"] = txbServiceSpe.Text.Trim();

                            string selectedCities = ";#";
                            foreach (ListItem item in cblCity.Items)
                            {
                                if (item.Selected)
                                    selectedCities += item.Value + ";#";
                            }
                            newItem["_x00c1_mbito"] = selectedCities;

                            newItem["Banco"] = txbBank1.Text.Trim();
                            newItem["Beneficiario"] = txbBank2.Text.Trim();
                            newItem["Cuenta_x0020_pago"] = txbBank3.Text.Trim();
                            newItem["Cuenta_x0020_moneda"] = ddlBank4.SelectedValue;

                            if (file1.HasFile)
                                newItem.Attachments.Add("1_testimonio_constitucion.pdf", file1.FileBytes);
                            if (file2.HasFile)
                                newItem.Attachments.Add("2_poder_representante.pdf", file2.FileBytes);
                            if (file3.HasFile)
                                newItem.Attachments.Add("3_matricula_comercio.pdf", file3.FileBytes);
                            if (file4.HasFile)
                                newItem.Attachments.Add("4_nit.pdf", file4.FileBytes);
                            newItem.Attachments.Add("5_ci_representante.pdf", file5.FileBytes);
                            newItem.Attachments.Add("6_formulario_registro.pdf", file6.FileBytes);

                            try
                            {
                                newItem.Web.AllowUnsafeUpdates = true;
                                newItem.Update();
                            }
                            finally
                            {
                                newItem.Web.AllowUnsafeUpdates = false;
                            }
                        }
                    });

                    lblError.Text = "";
                    Page.Response.Redirect("/Paginas/Formularios/ProveedoresConfirmacion.aspx", true);
                }
                else
                {
                    lblError.Text = "<p>* al parecer eres un robot, ya que no pasaste la prueba.</p>";
                }
          }
          catch (Exception ex)
          {
              lblError.Text = ex.Message;
          }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            try
            {
                Page.Validate("group1");
                Page.Validate("group2");

                #region City selection validation
                bool validCity = true;
                if (cblCity.SelectedIndex == -1)
                {
                  validCity = false;
                  lblCity.Visible = true;
                }
                else
                {
                  lblCity.Visible = false;
                }
                #endregion

                if (Page.IsValid && validCity)
                {
                    #region Validate previous registration
                    string[] previousRegistrationInfo = this.HasPreviousRegistration(txbCi.Text.Trim());
                    if (previousRegistrationInfo[0] == "true")
                    {
                        divForm.Visible = false;
                        ltrMessage.Text = string.Format(
                            "<p>Datos incorrectos en el formulario de registro</p>" +
                            "<p>Le informamos que el NIT ingresado <b>{0}</b>, ya se encuentra registrado.</p>" +
                            "<p>Dicho registro fue realizado en fecha <b>{1}</b>, y actualmente tiene el estado <b>{2}</b>.</p>",
                            txbCi.Text, previousRegistrationInfo[1], previousRegistrationInfo[2]);

                        return;
                    }
                    #endregion

                    #region Disable fields
                    ddlType.Enabled = false;
                    txbName.Enabled = false;
                    txbCi.Enabled = false;
                    txbAddress.Enabled = false;
                    txbMail.Enabled = false;
                    txbPhones.Enabled = false;
                    txbEmail.Enabled = false;
                    txbWebsite.Enabled = false;
                    txbLegal1.Enabled = false;
                    txbLegal2.Enabled = false;
                    txbLegal3.Enabled = false;
                    txbLegal4.Enabled = false;
                    ddlServiceGen1.Enabled = false;
                    ddlServiceGen2.Enabled = false;
                    txbServiceSpe.Enabled = false;
                    cblCity.Enabled = false;
                    txbBank1.Enabled = false;
                    txbBank2.Enabled = false;
                    txbBank3.Enabled = false;
                    ddlBank4.Enabled = false;
                    checkdoc1.Disabled = true;
                    checkdoc2.Disabled = true;
                    checkdoc3.Disabled = true;
                    checkdoc4.Disabled = true;
                    checkdoc5.Disabled = true;

                    if (ddlType.SelectedItem.Value == "PN")
                    {
                        checkdoc1_span.Visible = false;
                        checkdoc2_span.Visible = false;
                        checkdoc3_span.Visible = false;
                        file1_span.Visible = false;
                        file2_span.Visible = false;
                        file3_span.Visible = false;

                        if (!checkdoc4.Checked)
                            file4_span.Visible = false;
                        else
                            rfvFile4.Enabled = true;
                        /*if (!checkdoc5.Checked)
                            file5_span.Visible = false;*/
                    }
                    else if (ddlType.SelectedItem.Value == "EU")
                    {
                        checkdoc1_span.Visible = false;
                        checkdoc2_span.Visible = false;
                        file1_span.Visible = false;
                        file2_span.Visible = false;

                        if (!checkdoc3.Checked)
                            file3_span.Visible = false;
                        else
                            rfvFile3.Enabled = true;

                        if (!checkdoc4.Checked)
                            file4_span.Visible = false;
                        else
                            rfvFile4.Enabled = true;
                        /*if (!checkdoc5.Checked)
                            file5_span.Visible = false;*/
                    }
                    else
                    {
                        if (!checkdoc1.Checked)
                            file1_span.Visible = false;
                        else
                            rfvFile1.Enabled = true;

                        if (!checkdoc2.Checked)
                            file2_span.Visible = false;
                        else
                            rfvFile2.Enabled = true;

                        if (!checkdoc3.Checked)
                            file3_span.Visible = false;
                        else
                            rfvFile3.Enabled = true;

                        if (!checkdoc4.Checked)
                            file4_span.Visible = false;
                        else
                            rfvFile4.Enabled = true;
                        /*if (!checkdoc5.Checked)
                            file5_span.Visible = false;*/
                    }
                    #endregion

                    #region Show and hide controls
                    btnPrint.Visible = false;
                    btnConfirm.Visible = true;
                    btnPrintAgain.Visible = true;
                    divAttach.Visible = true;

                    if (!WPRegistrationForm.spCaptchaEnabled)
                        divCaptcha.Visible = false;
                    else
                        divCaptcha.Visible = true;
                    #endregion

                    #region Print the form
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "PrintOperation", "window.print();", true);
                    #endregion
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        protected void cuvFile1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (file1.HasFile && file1.PostedFile.ContentLength < 1050000)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void cuvFile2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (file2.HasFile && file2.PostedFile.ContentLength < 1050000)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void cuvFile3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (file3.HasFile && file3.PostedFile.ContentLength < 1050000)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void cuvFile4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (file4.PostedFile.ContentLength < 1050000)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void cuvFile5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (file5.PostedFile.ContentLength < 1050000)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void cuvFile6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (file6.PostedFile.ContentLength < 1050000)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        private List<Business> GetSupplierBusiness()
        {
            List<Business> businessList = new List<Business>();

            using (SPSite sps = new SPSite(SPContext.Current.Web.Url))
            using (SPWeb spw = sps.OpenWeb())
            {
                SPListItemCollection queriedBusiness = spw.Lists[LIST_BUSINESS].Items;

                foreach (SPListItem item in queriedBusiness)
                {
                    businessList.Add(new Business(item.ID, item.Title));
                }
            }

            return businessList;
        }

        private string[] HasPreviousRegistration(string nit)
        {
            string[] result = new string[3];

            using (SPSite sps = new SPSite(SPContext.Current.Web.Url))
            using (SPWeb spw = sps.OpenWeb())
            {
                SPQuery querySupplier = new SPQuery();
                querySupplier.Query = string.Format(
                    "<Where><Eq><FieldRef Name='NIT' /><Value Type='Text'>{0}</Value></Eq></Where>",
                    nit);

                SPListItemCollection queriedSuppliers = spw.Lists[LIST_SUPPLIERS].GetItems(querySupplier);

                if (queriedSuppliers.Count != 0)
                {
                    foreach (SPListItem item in queriedSuppliers)
                    {
                        result[0] = "true";
                        result[1] = item["Created"].ToString();
                        result[2] = item["ESTADO"].ToString();

                        break;
                    }
                }
                else
                {
                    result[0] = "false";
                    result[1] = "";
                    result[2] = "";
                }
            }

            return result;
        }

        #region reCAPTCHA
        private bool IsCaptchaValid()
        {
            if (!WPRegistrationForm.spCaptchaEnabled)
                return true;

            string Response = this.Page.Request["g-recaptcha-response"];//Getting Response String Appned to Post Method
            bool Valid = false;

            string SecretKey = System.Configuration.ConfigurationManager.AppSettings["SecretKey"];
            System.Net.HttpWebRequest req = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(
                string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}",
                SecretKey, Response));

            try
            {
                using (System.Net.WebResponse wResponse = req.GetResponse())
                {
                    using (System.IO.StreamReader readStream = new System.IO.StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();
                        System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                        MyObject data = js.Deserialize<MyObject>(jsonResponse);// Deserialize Json 
                        Valid = Convert.ToBoolean(data.success);
                    }
                }

                return Valid;
            }
            catch (System.Net.WebException ex)
            {
                throw ex;
            }
        }

        private class MyObject { public string success { get; set; } }
        #endregion
    }

    public class Business
    {
        int id;
        string name;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public Business(int id, string name)
        {
            this.Id = id;
            this.Name = name;
        }
    }
}
