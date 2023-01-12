using IT_BLL.DBInfo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UI.ClassFiles;

namespace UI.Asset
{
    public partial class AssetAdminReturn : System.Web.UI.Page
    {
        AssetReturnBLL bll = new AssetReturnBLL();
        private DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                assetData();
            }
        }

        private void assetData()
        {
            dt = bll.GetAssetDataTable(6, 0, 0, 0, 0, 0, ToString());
            dgvlist.DataSource = dt;
            dgvlist.DataBind();
        }
        [Obsolete]
        protected void apprvBtnClick(object sender, EventArgs e)
        {
            try
            {
                string clickHist = ((Button)sender).ClientID.ToString();
                string[] chars;
                chars = clickHist.Split('_');
                int clickedRow = int.Parse(chars[2]);
                int srid = int.Parse(((Button)sender).CommandArgument.ToString());
                int actionBy = int.Parse(HttpContext.Current.Session[SessionParams.USER_ID].ToString());

                dt = bll.GetAssetDataTable(7, srid, actionBy, 0, 0, 0, ToString());
                assetData();
            }
            catch
            {
                Page.RegisterStartupScript("captcha",
                        "<script language='javascript'>" +
                            "function disableSubmitButton() {" +
                                "document.getElementById('***submitButtonID***').onclick = function(){return false;}" +
                            "}" +
                            "if(window.addEventListener) {" +
                            "    window.addEventListener('load',disableSubmitButton,false);" +
                            "} else {" +
                            "    window.attachEvent('onload',disableSubmitButton);" +
                            "}" +
                            "alert('Something wrong! Please try again');" +
                        "</script>");
            }
        }

        [Obsolete]
        protected void rejectBtnClick(object sender, EventArgs e)
        {
            try
            {
                string clickHist = ((Button)sender).ClientID.ToString();
                string[] chars;
                chars = clickHist.Split('_');
                int clickedRow = int.Parse(chars[2]);
                int srid = int.Parse(((Button)sender).CommandArgument.ToString());
                int actionBy = int.Parse(HttpContext.Current.Session[SessionParams.USER_ID].ToString());

                TextBox reasonText = (TextBox)dgvlist.Rows[clickedRow].FindControl("ReasonTextID");
                string textLabel = reasonText.Text.Trim();
                dt = bll.GetAssetDataTable(8, srid, actionBy, 0, 0, 0, textLabel);
                assetData();
            }
            catch
            {
                Page.RegisterStartupScript("captcha",
                        "<script language='javascript'>" +
                            "function disableSubmitButton() {" +
                                "document.getElementById('***submitButtonID***').onclick = function(){return false;}" +
                            "}" +
                            "if(window.addEventListener) {" +
                            "    window.addEventListener('load',disableSubmitButton,false);" +
                            "} else {" +
                            "    window.attachEvent('onload',disableSubmitButton);" +
                            "}" +
                            "alert('Something wrong! Please try again');" +
                        "</script>");
            }
        }

    }
}