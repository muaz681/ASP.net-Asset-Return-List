using IT_DAL.IPMailADTdsTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IT_BLL
{
    public class IPMailADBLL
    {
        DataTable dt = new DataTable();

        public DataTable GetEmployee(int intType, int intEnroll, string xmlData)
        {
            EmployeeTableAdapter adapter = new EmployeeTableAdapter();
            string strMessage = string.Empty;
            try
            {
                dt = adapter.GetEmployeeData(intType, intEnroll, xmlData, 0, 0,null, ref strMessage);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }

            return dt;
        }

        public string CRUDEmployeeDataForITDept(int intType,int intEnroll,string xmlData, int intInsertBy,int intRequestId)
        {
            EmployeeTableAdapter adapter = new EmployeeTableAdapter();
            string strMessage = string.Empty;
            try
            {
               adapter.GetEmployeeData(intType, intEnroll, xmlData, intInsertBy, intRequestId,null,ref strMessage);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }

            return strMessage;
        }

        public DataTable GetCSVITDept()
        {
            tblITActiveDirectoryRecordTableAdapter adapter = new tblITActiveDirectoryRecordTableAdapter();
            DataTable dt = new DataTable();
            try
            {
                dt = adapter.GetCSVDataData();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }

            return dt;
        }

        public DataTable GetAssetsType()
        {
            try
            {
                AssetListTableAdapter ta = new AssetListTableAdapter();
                return ta.GetAssetsListData();
            }
            catch { return new DataTable(); }
        }

        public DataTable insertITAssetTransferData(int type, int actionBy, string xml, ref string msg, int intUserType, int intJobStation, string storeAssetID)
        {
            try
            {
                sprITAssetEntryTableAdapter sprrrr = new sprITAssetEntryTableAdapter();
                return sprrrr.GetITAssetsData(type, actionBy, xml, intUserType, intJobStation, storeAssetID, ref msg);

            }
            catch (Exception ex)
            {
                return new DataTable();
            }

        }

        public DataTable GetUserInfo(int intEnroll, string strEmail)
        {
            try
            {
                GetUserInfoTA adp = new GetUserInfoTA();
                if (intEnroll != 0)
                {
                    return adp.GetUserInfoByEnroll(intEnroll);
                }
                else
                {
                    return adp.GetUserInfoByEmail(strEmail);
                }
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        public DataTable InsertSeviceData(int intEnroll, int intAssetID, string strVendorName, int intReqID, string strServiceDescription, DateTime dteSendingDate, int intActionBy)
        {
            try
            {
                sprITAssetServicesEntryTableAdapter adp = new sprITAssetServicesEntryTableAdapter();
                return adp.InsertServiceData( 1, intEnroll, intAssetID, strVendorName, intReqID, strServiceDescription, dteSendingDate, null, null, intActionBy);
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        public DataTable AssetRecieveData(int intType, string fDate, string tDate)
        {
            try
            {
                sprITAssetServicesReportTableAdapter adp = new sprITAssetServicesReportTableAdapter();
                return adp.GetAssetsRecieveData(intType, DateTime.Parse(fDate), DateTime.Parse(tDate));
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        public DataTable UpdateSeviceData(int intType, int intServiceID, string strDeclineReason, int intActionBy, string dteReturnDate, string intBill, string dteWarrentyDate, string dteRWarrentyDate)
        {
            try
            {
                sprITAssetServicesEntryTableAdapter adp = new sprITAssetServicesEntryTableAdapter();
                return adp.InsertServiceData(intType, null, intServiceID, intBill, null, strDeclineReason, DateTime.Parse(dteReturnDate), DateTime.Parse(dteWarrentyDate), DateTime.Parse(dteRWarrentyDate), intActionBy);
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        public DataTable GetAssetsData(int intEnroll)
        {
            tblITAssetsListTableAdapter adp = new tblITAssetsListTableAdapter();
            try
            {
                return adp.GetAssetsData(intEnroll);
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        public DataTable GetParentAssetsData(int intEnroll, int intAssetType)
        {
            tblITAssetAssignToEmployeeTableAdapter adp = new tblITAssetAssignToEmployeeTableAdapter();
            try
            {
                return adp.GetParentAsset(intEnroll, intAssetType);
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        public DataTable GetUserPermissionForAssets(int intEnroll)
        {
            tblITAssetUserConfigTableAdapter adp = new tblITAssetUserConfigTableAdapter();
            try
            {
                return adp.GetUserPermission(intEnroll);
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }

        public int CheckEmployeeExist(string Enroll)
        {
            DataTable2TableAdapter adp = new DataTable2TableAdapter();
            try
            {
                DataTable dt = adp.CheckEmployeEexistence(int.Parse(Enroll));

                if (dt.Rows[0]["intCountEnroll"].ToString() == "0") return 0;
                else return 1;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }



        public DataTable ITAssetParking()
        {
            DataTable3TableAdapter adp = new DataTable3TableAdapter();
            try
            {
                DataTable dt = adp.GetData();
                return dt;
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }


        public DataTable ITAssetTransfer(int type, int transferType, int itAssetID, int fromEnroll, int toEnroll, string remarks, int insertBy, int fromJS, int toJS)
        {
            sprITAssetTransferTableAdapter adp = new sprITAssetTransferTableAdapter();
            try
            {
                DataTable dt = adp.TransferITAsset(type, transferType, itAssetID, fromEnroll, toEnroll, DateTime.Now, remarks, insertBy, fromJS, toJS);
                return dt;
            }
            catch (Exception ex)
            {
                return new DataTable();
            }
        }





    }
}
