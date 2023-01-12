using BLL.IT;
using IT_BLL.DBInfo;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UI.ClassFiles;
using UI.SAD.Sales;
using Utility;
using DataTable = System.Data.DataTable;
using Label = System.Web.UI.WebControls.Label;
using Page = System.Web.UI.Page;

namespace UI.Asset
{
    public partial class AssetsReturn : System.Web.UI.Page
    {
        AssetReturnBLL bll = new AssetReturnBLL();
        private DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                strName.Text = Session[SessionParams.USER_NAME].ToString();
                strEmail.Text = Session[SessionParams.EMAIL].ToString();
                intEnroll.Text = Session[SessionParams.USER_ID].ToString();
                loadGrid();
                assetData();

            }
        }

        private void loadGrid()
        {
            int actionBy = int.Parse(HttpContext.Current.Session[SessionParams.USER_ID].ToString());
            dt = bll.GetAssetDataTable(2, 0, actionBy, 0, 0, 0, ToString());
            assetList.LoadWithSelect(dt, "intAssetID", "strDetails");
        }

        private void assetData()
        {
            int actionBy = int.Parse(HttpContext.Current.Session[SessionParams.USER_ID].ToString());
            dt = bll.GetAssetDataTable(14, 0, actionBy, 0, 0, 0, ToString());
            dgvlist.DataSource = dt;
            dgvlist.DataBind();
        }

        [Obsolete]
        protected void submitBtnClick(object sender, EventArgs e)
        {
            

            try
            {
                
                int actionBy = int.Parse(HttpContext.Current.Session[SessionParams.USER_ID].ToString());
                int assetType = int.Parse(assetList.SelectedValue.Trim());
                string strReason = ReasonID.Text.Trim();
                
                    dt = bll.GetAssetDataTable(1, 0, actionBy, assetType, 0, actionBy, strReason);
                    string msg = dt.Rows[0]["strMsg"].ToString();
                    nullData();
                    assetData();

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
                            "alert('"+msg+"');" +
                        "</script>");

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
        private void nullData()
        {
            assetList.SelectedIndex = 0;
            ReasonID.Text = "";
        }
    }
}