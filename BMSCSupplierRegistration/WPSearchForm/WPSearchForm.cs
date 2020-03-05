using System;
using System.ComponentModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;

namespace BMSCSupplierRegistration.WPSearchForm
{
    [ToolboxItemAttribute(false)]
    public class WPSearchForm : WebPart
    {
        // Visual Studio might automatically update this path when you change the Visual Web Part project item.
        private const string _ascxPath = @"~/_CONTROLTEMPLATES/15/BMSCSupplierRegistration/WPSearchForm/WPSearchFormUserControl.ascx";

        #region Web part parameters
        public static bool spCaptchaEnabled;
        [Personalizable(PersonalizationScope.Shared),
        WebBrowsable(true),
        WebDisplayName("Captcha"),
        WebDescription("Habilita el control captcha en el formulario."),
        Category("Configuración")]
        public bool SpCaptchaEnabled
        {
            get { return spCaptchaEnabled; }
            set { spCaptchaEnabled = value; }
        }
        #endregion

        protected override void CreateChildControls()
        {
            Control control = Page.LoadControl(_ascxPath);
            Controls.Add(control);
        }
    }
}
