using Microsoft.SharePoint;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace BMSCSupplierRegistration.WPSearchForm
{
    public partial class WPSearchFormUserControl : UserControl
    {
        private const string LIST_HIRING = "Convocatorias";
        private const string LIST_SUPPLIERS = "Proveedores";
        private const string LIST_APPLICANTS = "Solicitantes";

        protected void Page_Load(object sender, EventArgs e)
        {
            string hid = string.IsNullOrEmpty(Page.Request.QueryString["cid"]) ? "0" : Page.Request.QueryString["cid"];
            int number;
            int hiringId = Int32.TryParse(hid, out number) ? number : 0;

            txbHiring.Text = this.ValidateHiringId(hiringId);

            if (!WPSearchForm.spCaptchaEnabled)
                divCaptcha.Visible = false;
            else
                divCaptcha.Visible = true;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid && this.IsCaptchaValid())
                {
                    string hiringId = string.IsNullOrEmpty(Page.Request.QueryString["cid"]) ? "0" : Page.Request.QueryString["cid"];

                    lblError.Text = "";
                    this.ProcessRequest(hiringId);
                }
                else
                {
                    lblError.Text = "al parecer eres un robot, ya que no pasaste la prueba.";
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        private void ProcessRequest(string hid)
        {
            int number;
            int hiringId = Int32.TryParse(hid, out number) ? number : 0;
            string supplierCode = txbCode.Text.Trim();
            
            #region SharePoint query
            using (SPSite sps = new SPSite(SPContext.Current.Web.Url))
            using (SPWeb spw = sps.OpenWeb())
            {
                SPQuery querySupplier = new SPQuery();
                querySupplier.Query = string.Format(
                    "<Where><Eq><FieldRef Name='NIT' /><Value Type='Text'>{0}</Value></Eq></Where>",
                    supplierCode);

                SPListItemCollection queriedSuppliers = spw.Lists[LIST_SUPPLIERS].GetItems(querySupplier);

                if (queriedSuppliers.Count != 0)
                {
                    foreach (SPListItem item in queriedSuppliers)
                    {
                        switch (item["_ModerationStatus"].ToString())
                        {
                            case "0"://A
                                bool success = this.SaveRequest(hiringId, item.ID);

                                if (success)
                                {
                                    ltrMessage.Text = "<p>Gracias por contactarse con nosotros.</p>" +
                                        "<p>Se le enviará la información solicitada a los correos electrónicos " +
                                        "indicados en su <b>Formulario de Registro</b>. " +
                                        "(Correo Electrónico y/o Correo Electrónico del Contacto Comercial)</p>";
                                }
                                else
                                {
                                    ltrMessage.Text = "<p>Gracias por contactarse con nosotros.</p>" +
                                        "<p>Su solicitud de participación del proceso ya fue ingresada, y se le enviará la información solicitada " +
                                        "a los correos electrónicos indicados en su <b>Formulario de Registro</b>. " +
                                        "(Correo Electrónico y/o Correo Electrónico del Contacto Comercial)</p>";
                                }
                                break;
                            case "1"://R
                                ltrMessage.Text = "<p>Gracias por contactarse con nosotros.</p>" +
                                    "<p>Le informamos que su <b>Formulario de Registro</b> actualmente se encuentra <b>OBSERVADO</b>, " +
                                    "por lo que su código de proveedor podrá ser nuevamente usado una vez regularizado su registro.</p>";
                                if (item["MOTIVO_x0020_SUSP_x002e_"] != null && !string.IsNullOrWhiteSpace(item["MOTIVO_x0020_SUSP_x002e_"].ToString()))
                                    ltrMessage.Text += "<p>La(s) observación(es) es(son):</p>" +
                                        "<p><i>" + item["MOTIVO_x0020_SUSP_x002e_"].ToString() + "</i></p>";
                                break;
                            case "2"://W
                                ltrMessage.Text = "<p>Gracias por contactarse con nosotros.</p>" +
                                    "<p>Le informamos que su <b>Formulario de Registro</b> actualmente se encuentra <b>PENDIENTE</b> de aprobación, " +
                                    "por lo que su código de proveedor podrá ser nuevamente usado una vez regularizado su registro.</p>";
                                break;
                        }
                        break;
                    }
                }
                else
                {
                    ltrMessage.Text = "<p>El código ingresado no es válido.</p>" +
                        "<p>Recuerde que este código le es entregado en respuesta al 'Formulario de Registro', " +
                        "una vez verificado y aprobado por el área del Banco responsable.</p>";
                }
            }
            #endregion

            divFieldsgroup.Visible = false;
            divCaptcha.Visible = false;
            btnConfirm.Visible = false;
        }

        private bool SaveRequest(int hiringId, int supplierId)
        {
            bool requestResult = true;

            SPSecurity.RunWithElevatedPrivileges(delegate()
            {
                using (SPSite sps = new SPSite(SPContext.Current.Web.Url))
                using (SPWeb spw = sps.OpenWeb())
                {
                    #region Validate previous entry
                    SPListItemCollection itemsList = spw.Lists[LIST_APPLICANTS].Items;

                    foreach (SPListItem item in itemsList)
                    {
                        int itemHiringId = Convert.ToInt32(item["Convocatoria"].ToString().Remove(item["Convocatoria"].ToString().IndexOf(";#")));
                        int itemSupplierId = Convert.ToInt32(item["Proveedor"].ToString().Remove(item["Proveedor"].ToString().IndexOf(";#")));

                        if (itemHiringId == hiringId && itemSupplierId == supplierId)
                        {
                            requestResult = false;
                            break;
                        }
                    }
                    #endregion

                    #region Save the request
                    if (requestResult == true)
                    {
                        SPListItem newItem = itemsList.Add();

                        newItem["Proveedor"] = supplierId;
                        newItem["Convocatoria"] = hiringId;

                        try
                        {
                            newItem.Web.AllowUnsafeUpdates = true;
                            newItem.Update();
                        }
                        catch
                        {
                            requestResult = false;
                        }
                        finally
                        {
                            newItem.Web.AllowUnsafeUpdates = false;
                        }
                    }
                    #endregion
                }
            });

            return requestResult;
        }

        private string ValidateHiringId(int hiringId)
        {
            string result = "";

            using (SPSite sps = new SPSite(SPContext.Current.Web.Url))
            using (SPWeb spw = sps.OpenWeb())
            {
                //SPListItemCollection itemsList = spw.Lists[LIST_HIRING].Items;
                SPQuery query = new SPQuery();
                query.Query = string.Format(
                    "<Where><And>" +
                    "<Eq><FieldRef Name='ID' /><Value Type='Counter'>{0}</Value></Eq>" +
                    "<Eq><FieldRef Name='_ModerationStatus' /><Value Type='ModStat'>0</Value></Eq>" +
                    "</And></Where>",
                    hiringId);

                SPListItemCollection queriedItems = spw.Lists[LIST_HIRING].GetItems(query);

                if (queriedItems.Count > 0)
                    result = queriedItems[0].Title + "\r\n" + queriedItems[0]["Detalle"].ToString();
            }

            return result;
        }

        #region reCAPTCHA
        private bool IsCaptchaValid()
        {
            if (!WPSearchForm.spCaptchaEnabled)
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
}
