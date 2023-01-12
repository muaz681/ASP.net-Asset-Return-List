using IT_DAL.DBInfoDAL.DBAssetTDSTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IT_BLL.DBInfo
{
    public class AssetReturnBLL
    {
        DataTable dt = new DataTable();

        public DataTable GetAssetDataTable(int intType, int intID, int intEmpID, int intAsstID, int ysnAction, int intActionBy, string strReason)
        {
            sprAssetsReturnTableAdapter obj = new sprAssetsReturnTableAdapter();
            try
            {
                dt = obj.GetData(intType, intID, intEmpID, intAsstID, ysnAction, intActionBy, strReason);
            }
            catch (Exception ex)
            {   
                throw ex;
            }
            return dt;
        }
    }
}
