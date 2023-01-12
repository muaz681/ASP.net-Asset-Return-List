using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IT_DAL.DBInfoDAL;
using IT_DAL.DBInfoDAL.DBInfoTDSTableAdapters;

namespace IT_BLL.DBInfo
{
    public class DatabaseInfoBLL
    {
        DataTable dt = new DataTable();

        public void SaveDatabaseUsrInfo(string emailAdrs, int? enroll, int mailBoxType, int insertBy, string dName)
        {
            sprDatabaseUserInfoCollectTableAdapter obj = new sprDatabaseUserInfoCollectTableAdapter();            
            try
            {
                obj.CRUDDatabaseInfo(emailAdrs, enroll, dName, mailBoxType, insertBy);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataTable GetEmpName(int empID)
        {
            dt = new DataTable();
            DataTable1TableAdapter obj = new DataTable1TableAdapter();
            try
            {
                dt = obj.GetEmpName(empID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public DataTable GetInsertPerTable(string category, string remark)
        {
            tblInternetPermissionCategoryTableAdapter obj = new tblInternetPermissionCategoryTableAdapter();
            DataTable dt = obj.GetPerInsertData(category, remark);
            return dt;
        }
        public DataTable GetShowPerTable()
        {
            tblInternetPermissionCategory1TableAdapter obj = new tblInternetPermissionCategory1TableAdapter();
            DataTable dt = obj.GetPerShowData();
            return dt;
        }
        public DataTable GetUpDctTable(int id)
        {
            tblInternetPermissionCategory2TableAdapter obj = new tblInternetPermissionCategory2TableAdapter();
            DataTable dt = obj.GetYsnDctData(id);
            return dt;
        }
        public DataTable GetUpActTable(int id)
        {
            tblInternetPermissionCategory3TableAdapter obj = new tblInternetPermissionCategory3TableAdapter();
            DataTable dt = obj.GetYsnActData(id);
            return dt;
        }

        public DataTable GetUpdtPermisTable(string category, string remark, int id)
        {
            tblInternetPermissionCategory4TableAdapter obj = new tblInternetPermissionCategory4TableAdapter();
            DataTable dt = obj.GetUpdPermisTblData(category, remark, id);
            return dt;
        }

        public DataTable GetDataTestTable(string name, int enroll, int type)
        {
           
            tblTestMuazTableAdapter obj = new tblTestMuazTableAdapter();
            DataTable dt = obj.GetData(name, enroll, type);
            return dt;
        }
        public DataTable GetReadDataTestTable()
        {
            tblTestMuaz1TableAdapter readObj = new tblTestMuaz1TableAdapter();
            DataTable result = readObj.ReadData();
            return result;
        }
        public DataTable GetTypeDataTestTable()
        {
            DataTable5TableAdapter typeObj = new DataTable5TableAdapter();
            DataTable result = typeObj.GetTypeData();
            return result;
        }
        public DataTable GetEditDataTestTable(int id)
        {
            DataTable6TableAdapter editObj = new DataTable6TableAdapter();
            DataTable result = editObj.GetEditData(id);
            return result;
        }
        public DataTable GetUpdateDataTestTable(string name, int enrollID, int typeValue, int primary)
        {

            DataTable7TableAdapter updateObj = new DataTable7TableAdapter();
            DataTable result = updateObj.GetUpdateData(name, enrollID, typeValue,primary);
            return result;
        }

        public DataTable GetDatabaseUserList()
        {
            dt = new DataTable();
            try
            {
                DataTable2TableAdapter obj = new DataTable2TableAdapter();
                dt = obj.GetDataBaseUserInfo();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public string ModifyDatabaseUserInfo(int modifyType,int dbUserInfoTblId, int modifyby)
        {
            sprDatabaseUserInfoCollectModifyTableAdapter obj = new sprDatabaseUserInfoCollectModifyTableAdapter();
            try
            {               
               obj.ModifyDbInfo(modifyType, dbUserInfoTblId,modifyby);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return "DB User Information Close Successfully.";
        }

        public string SaveDBInfo(string dbName, int maxUsr, int insertby)
        {
            tblDatabaseInfoTableAdapter obj = new tblDatabaseInfoTableAdapter();
            try
            {
                obj.SaveDBInfo(dbName, maxUsr, insertby);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return "Save Successfully.";
        }

        public DataTable GetDBInfoList()
        {
            dt = new DataTable();
            tblDatabaseInfo1TableAdapter obj = new tblDatabaseInfo1TableAdapter();
            try
            {
                dt = obj.GetDBInfoList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public int GetTotalExistingDB(int dbID)
        {
            int count = 0;
            dt = new DataTable();
            DataTable3TableAdapter obj = new DataTable3TableAdapter();
            try
            {
                dt = obj.CheckExistingDB(dbID);
                if(dt.Rows.Count> 0)
                {
                    if (dt.Rows[0]["totalId"] != DBNull.Value)
                        count = int.Parse(dt.Rows[0]["totalId"].ToString());
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return count;
        }

        public string CancelDBStatus(int dbID, int insertBy)
        {
            string Msg = "";
            tblDatabaseInfo2TableAdapter obj = new tblDatabaseInfo2TableAdapter();
            try
            {
                int flag = GetTotalExistingDB(dbID);

                if (flag == 0)
                    obj.ModifyDBStatus(insertBy, dbID);
                else
                    Msg = "Cancel Existing DB User First.";                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return Msg;
        }

        

        public string SaveArchiveDBInfo(string archvName, int maxUsr, int insertby)
        {
            tblDatabaseArchiveInfoTableAdapter obj = new tblDatabaseArchiveInfoTableAdapter();
            try
            {
                obj.SaveArchiveDBInfo(archvName, maxUsr, insertby);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return "Save Successfully.";
        }

        public DataTable GetArchiveDBInfoList()
        {
            dt = new DataTable();
            tblDatabaseArchiveInfo1TableAdapter obj = new tblDatabaseArchiveInfo1TableAdapter();
            try
            {
                dt = obj.GetArchieveDBList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        public int GetTotalExistingArchvDB(int dbArchID)
        {
            int count = 0;
            dt = new DataTable();
            DataTable4TableAdapter obj = new DataTable4TableAdapter();
            try
            {
                dt = obj.CheckExistArchvDB(dbArchID);
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["totalId"] != DBNull.Value)
                        count = int.Parse(dt.Rows[0]["totalId"].ToString());
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return count;
        }

        public string CancelArchiveDBStatus(int dbArchiveID, int insertBy)
        {
            string Msg = "";
            tblDatabaseArchiveInfo2TableAdapter obj = new tblDatabaseArchiveInfo2TableAdapter();
            try
            {
                int flag = GetTotalExistingArchvDB(dbArchiveID);

                if (flag == 0)
                    obj.ModifyArchiveDBStatus(insertBy, dbArchiveID);
                else
                    Msg = "Cancel Existing Archive User First.";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return Msg;
        }

        public DataTable GetReadShowTable(int typeInt)
        {
            throw new NotImplementedException();
        }
    }
}
