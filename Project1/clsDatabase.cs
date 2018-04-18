using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

namespace Project1
{
    public class clsDatabase
    {
        private static SqlConnection AcquireConnection()
        {
            SqlConnection cnSQL = null;
            Boolean blnErrorOccurred = false;

            if (ConfigurationManager.ConnectionStrings["ServiceCenter"] != null)
            {
                cnSQL = new SqlConnection();
                cnSQL.ConnectionString = ConfigurationManager.ConnectionStrings["ServiceCenter"].ToString();

                try
                {
                    cnSQL.Open();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return null;
            }
            else
            {
                return cnSQL;
            }
        }

        //Uses upsGetTechnicianList stored procedure to fill Data Set with Technicians for Drop Down List
        public static DataSet GetTechnicianList()
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            SqlDataAdapter daSQL;
            DataSet dsSQL = null;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                return null;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspGetTechnicianList";

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                dsSQL = new DataSet();
                try
                {
                    daSQL = new SqlDataAdapter(cmdSQL);
                    intRetCode = daSQL.Fill(dsSQL);
                    daSQL.Dispose();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                    dsSQL.Dispose();
                }
                finally
                {
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return null;
            }
            else
            {
                return dsSQL;
            }
        }

        //Uses upsGetTechnicianByID stored procedure to fill Data Set with Technician information for text boxes
        public static DataSet GetTechnicianByID(string strTechID)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            SqlDataAdapter daSQL;
            DataSet dsSQL = null;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode;

            if (strTechID.Trim().Length > 0)
            {
                cnSQL = AcquireConnection();
                if (cnSQL == null)
                {
                    blnErrorOccurred = true;
                }
                else
                {
                    cmdSQL = new SqlCommand();
                    cmdSQL.Connection = cnSQL;
                    cmdSQL.CommandType = CommandType.StoredProcedure;
                    cmdSQL.CommandText = "uspGetTechnicianByID";

                    cmdSQL.Parameters.Add(new SqlParameter("@TechnicianID", SqlDbType.NVarChar, 10));
                    cmdSQL.Parameters["@TechnicianID"].Direction = ParameterDirection.Input;
                    cmdSQL.Parameters["@TechnicianID"].Value = strTechID;

                    cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                    cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                    dsSQL = new DataSet();
                    try
                    {
                        daSQL = new SqlDataAdapter(cmdSQL);
                        intRetCode = daSQL.Fill(dsSQL);
                        daSQL.Dispose();
                    }
                    catch (Exception ex)
                    {
                        blnErrorOccurred = true;
                        dsSQL.Dispose();
                    }
                    finally
                    {
                        cmdSQL.Parameters.Clear();
                        cmdSQL.Dispose();
                        cnSQL.Close();
                        cnSQL.Dispose();
                    }
                }
            }

            if (blnErrorOccurred)
            {
                return null;
            }
            else
            {
                return dsSQL;
            }
        }

        //Uses uspInsertTechnician stored procedure to take text from text boxes and insert them to correct Database columns
        public static Int32 InsertTechnician(String strFName, String strMInit, String strLName, String strEMail, String strDept, String strPhone, String strHRate)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode = 0;
            Int32 intNewTechID = 0;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                blnErrorOccurred = true;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspInsertTechnician";

                //First Name
                cmdSQL.Parameters.Add(new SqlParameter("@FName", SqlDbType.NVarChar, 20));
                cmdSQL.Parameters["@FName"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@FName"].Value = strFName;

                //Middle Initial
                cmdSQL.Parameters.Add(new SqlParameter("@MInit", SqlDbType.NChar, 1));
                cmdSQL.Parameters["@MInit"].Direction = ParameterDirection.Input;
                if (strMInit.Length > 0)
                {
                    cmdSQL.Parameters["@MInit"].Value = strMInit;
                }

                else
                {
                    cmdSQL.Parameters["@MInit"].Value = DBNull.Value;
                }

                //Last Name
                cmdSQL.Parameters.Add(new SqlParameter("@LName", SqlDbType.NVarChar, 30));
                cmdSQL.Parameters["@LName"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@LName"].Value = strLName;

                //E-Mail
                cmdSQL.Parameters.Add(new SqlParameter("@EMail", SqlDbType.NVarChar, 50));
                cmdSQL.Parameters["@EMail"].Direction = ParameterDirection.Input;
                if (strEMail.Length > 0)
                {
                    cmdSQL.Parameters["@EMail"].Value = strEMail;
                }

                else
                {
                    cmdSQL.Parameters["@EMail"].Value = DBNull.Value;
                }

                //Department
                cmdSQL.Parameters.Add(new SqlParameter("@Dept", SqlDbType.NVarChar, 25));
                cmdSQL.Parameters["@Dept"].Direction = ParameterDirection.Input;
                if (strDept.Length > 0)
                {
                    cmdSQL.Parameters["@Dept"].Value = strDept;
                }

                else
                {
                    cmdSQL.Parameters["@Dept"].Value = DBNull.Value;
                }

                //Phone
                cmdSQL.Parameters.Add(new SqlParameter("@Phone", SqlDbType.NChar, 10));
                cmdSQL.Parameters["@Phone"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@Phone"].Value = strPhone;

                //Hourly Rate
                cmdSQL.Parameters.Add(new SqlParameter("@HRate", SqlDbType.Money));
                cmdSQL.Parameters["@HRate"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@HRate"].Value = strHRate;

                //Tech ID
                cmdSQL.Parameters.Add(new SqlParameter("@NewTechnicianID", SqlDbType.Int));
                cmdSQL.Parameters["@NewTechnicianID"].Direction = ParameterDirection.Output;

                //Error Code
                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                

                try
                {
                    intRetCode = cmdSQL.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                }
                finally
                {
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
                if (!blnErrorOccurred)
                {
                    try
                    {
                        intNewTechID = Convert.ToInt32(cmdSQL.Parameters["@NewTechnicianID"].Value);
                    }
                    catch (Exception ex)
                    {
                        blnErrorOccurred = true;
                    }
                }

                cmdSQL.Parameters.Clear();
                cmdSQL.Dispose();
            }

            if (blnErrorOccurred)
            {
                return -1;
            }
            else
            {
                return intNewTechID;
            }
        }

        public static Int32 UpdateTechnician(String strTechID, String strFName, String strMInit, String strLName, String strEMail, String strDept, String strPhone, String strHRate)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode = 0;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                blnErrorOccurred = true;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.Parameters.Clear();
                cmdSQL.CommandText = "uspUpdateTechnician";

                //Technician ID
                cmdSQL.Parameters.Add(new SqlParameter("@TechnicianID", SqlDbType.Int));
                cmdSQL.Parameters["@TechnicianID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@TechnicianID"].Value = strTechID;

                //First Name
                cmdSQL.Parameters.Add(new SqlParameter("@FName", SqlDbType.NVarChar, 20));
                cmdSQL.Parameters["@FName"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@FName"].Value = strFName;


                //Middle Initial
                cmdSQL.Parameters.Add(new SqlParameter("@MInit", SqlDbType.NChar, 1));
                cmdSQL.Parameters["@MInit"].Direction = ParameterDirection.Input;
                if (strMInit.Length > 0)
                {
                    cmdSQL.Parameters["@MInit"].Value = strMInit;
                }

                else
                {
                    cmdSQL.Parameters["@MInit"].Value = DBNull.Value;
                }


                //Last Name
                cmdSQL.Parameters.Add(new SqlParameter("@LName", SqlDbType.NVarChar, 30));
                cmdSQL.Parameters["@LName"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@LName"].Value = strLName;


                //E-Mail
                cmdSQL.Parameters.Add(new SqlParameter("@EMail", SqlDbType.NVarChar, 50));
                cmdSQL.Parameters["@EMail"].Direction = ParameterDirection.Input;
                if (strEMail.Length > 0)
                {
                    cmdSQL.Parameters["@EMail"].Value = strEMail;
                }

                else
                {
                    cmdSQL.Parameters["@EMail"].Value = DBNull.Value;
                }


                //Department
                cmdSQL.Parameters.Add(new SqlParameter("@Dept", SqlDbType.NVarChar, 25));
                cmdSQL.Parameters["@Dept"].Direction = ParameterDirection.Input;
                if (strDept.Length > 0)
                {
                    cmdSQL.Parameters["@Dept"].Value = strDept;
                }

                else
                {
                    cmdSQL.Parameters["@Dept"].Value = DBNull.Value;
                }


                //Phone
                cmdSQL.Parameters.Add(new SqlParameter("@Phone", SqlDbType.NChar, 10));
                cmdSQL.Parameters["@Phone"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@Phone"].Value = strPhone;

                //Hourly Rate
                cmdSQL.Parameters.Add(new SqlParameter("@HRate", SqlDbType.Money));
                cmdSQL.Parameters["@HRate"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@HRate"].Value = strHRate;

                //Error Code
                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                try
                {
                    intRetCode = cmdSQL.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                }
                finally
                {
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return -1;
            }
            else
            {
                return 0;
            }
        }

        //Deletes Technician based on Drop Down List value passed in
        public static Int32 DeleteTechnician(String strTechID)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode = 0;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                blnErrorOccurred = true;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspDeleteTechnician";

                cmdSQL.Parameters.Add(new SqlParameter("@TechnicianID", SqlDbType.Int));
                cmdSQL.Parameters["@TechnicianID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@TechnicianID"].Value = strTechID;

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                try
                {
                    intRetCode = cmdSQL.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                }
                finally
                {
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return -1;
            }
            else
            {
                return 0;
            }
        }




        //***Uses upsGetClientList stored procedure to fill Data Set with Clients for Drop Down List***
        public static DataSet GetClientList()
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            SqlDataAdapter daSQL;
            DataSet dsSQL = null;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                return null;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspGetClientList";

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                dsSQL = new DataSet();
                try
                {
                    daSQL = new SqlDataAdapter(cmdSQL);
                    intRetCode = daSQL.Fill(dsSQL);
                    daSQL.Dispose();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                    dsSQL.Dispose();
                }
                finally
                {
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return null;
            }
            else
            {
                return dsSQL;
            }
        }

        //***Uses upsGetClientList stored procedure to fill Data Set with Clients for Drop Down List***
        public static DataSet GetProductList()
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            SqlDataAdapter daSQL;
            DataSet dsSQL = null;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                return null;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspGetProductList";

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                dsSQL = new DataSet();
                try
                {
                    daSQL = new SqlDataAdapter(cmdSQL);
                    intRetCode = daSQL.Fill(dsSQL);
                    daSQL.Dispose();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                    dsSQL.Dispose();
                }
                finally
                {
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return null;
            }
            else
            {
                return dsSQL;
            }
        }

        //***Uses uspGetOpenProblems stored procedure to fill datagrid with any open problems***
        public static DataSet GetOpenProblems()
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            SqlDataAdapter daSQL;
            DataSet dsSQL = null;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                return null;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspGetOpenProblems";

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                dsSQL = new DataSet();
                try
                {
                    daSQL = new SqlDataAdapter(cmdSQL);
                    intRetCode = daSQL.Fill(dsSQL);
                    daSQL.Dispose();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                    dsSQL.Dispose();
                }
                finally
                {
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return null;
            }
            else
            {
                return dsSQL;
            }
        }

        //***Uses uspInsertServiceEvent stored procedure to pass data from the SerivceEvent page into the Database***
        public static Int32 InsertServiceEvent(Int32 intClientID, DateTime datEventDate, String strPhone, String strContact)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            Boolean blnOk = true;
            Int32 intRetCode;
            Int32 intNewTicket = 0;

            cnSQL = AcquireConnection();

            if (cnSQL == null)
            {
                blnOk = false;
            }

            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspInsertServiceEvent";

                cmdSQL.Parameters.Add(new SqlParameter("@ClientID", SqlDbType.Int));
                cmdSQL.Parameters["@ClientID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@ClientID"].Value = intClientID;

                cmdSQL.Parameters.Add(new SqlParameter("@EventDate", SqlDbType.DateTime));
                cmdSQL.Parameters["@EventDate"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@EventDate"].Value = datEventDate;

                cmdSQL.Parameters.Add(new SqlParameter("@Phone", SqlDbType.NChar, 10));
                cmdSQL.Parameters["@Phone"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@Phone"].Value = strPhone;

                cmdSQL.Parameters.Add(new SqlParameter("@Contact", SqlDbType.NVarChar, 30));
                cmdSQL.Parameters["@Contact"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@Contact"].Value = strContact;

                cmdSQL.Parameters.Add(new SqlParameter("@NewTicketID", SqlDbType.Int));
                cmdSQL.Parameters["@NewTicketID"].Direction = ParameterDirection.Output;

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                try
                {
                    intRetCode = cmdSQL.ExecuteNonQuery();
                }

                catch (Exception ex)
                {
                    blnOk = false;
                }

                finally
                {
                    cnSQL.Close();
                    cnSQL.Dispose();
                }

                if (blnOk)
                {
                    try
                    {
                        intNewTicket = Convert.ToInt32(cmdSQL.Parameters["@NewTicketID"].Value);
                    }

                    catch (Exception ex)
                    {
                        blnOk = false;
                    }
                }

                cmdSQL.Parameters.Clear();
                cmdSQL.Dispose();
            }

            if (blnOk == false)
            {
                return -1;
            }

            else
            {
                return intNewTicket;
            }
        }

        //***Uses uspInsertServiceEvent stored procedure to pass data from the SerivceEvent page into the Database***
        public static Int32 InsertProblem(Int32 intTicketID, Int32 intIncidentNo, String strProbDesc, Int32 intTechID, String strProductID)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            Boolean blnOk = true;
            Int32 intRetCode;

            cnSQL = AcquireConnection();

            if (cnSQL == null)
            {
                blnOk = false;
            }

            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspInsertProblem";

                cmdSQL.Parameters.Add(new SqlParameter("@TicketID", SqlDbType.Int));
                cmdSQL.Parameters["@TicketID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@TicketID"].Value = intTicketID;

                cmdSQL.Parameters.Add(new SqlParameter("@IncidentNo", SqlDbType.Int));
                cmdSQL.Parameters["@IncidentNo"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@IncidentNo"].Value = intIncidentNo;

                cmdSQL.Parameters.Add(new SqlParameter("@ProbDesc", SqlDbType.NVarChar, 500));
                cmdSQL.Parameters["@ProbDesc"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@ProbDesc"].Value = strProbDesc;

                cmdSQL.Parameters.Add(new SqlParameter("@TechID", SqlDbType.Int));
                cmdSQL.Parameters["@TechID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@TechID"].Value = intTechID;

                cmdSQL.Parameters.Add(new SqlParameter("@ProductID", SqlDbType.NVarChar, 10));
                cmdSQL.Parameters["@ProductID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@ProductID"].Value = strProductID;

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                try
                {
                    intRetCode = cmdSQL.ExecuteNonQuery();
                }

                catch (Exception ex)
                {
                    blnOk = false;
                }

                finally
                {
                    cnSQL.Close();
                    cnSQL.Dispose();
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                }       
            }

            if (blnOk == false)
            {
                return -1;
            }

            else
            {
                return 0;
            }
        }

        //***Uses uspInsertResolution stored procedure to pass data from the ResolutionEntry page into the Database***
        public static Int32 InsertResolution(Int32 intTicketID, Int32 intIncidentNo, Int32 intResNo, String strResDesc, DateTime datDateFix, DateTime datDateOnSite,
            Int32 intTechID, Decimal decHours, Decimal decMileage, Decimal decMileageCost, Decimal decSupplies, Decimal decMisc, Int32 intNoCharge)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            Boolean blnOk = true;
            Int32 intRetCode;

            cnSQL = AcquireConnection();

            if (cnSQL == null)
            {
                blnOk = false;
            }

            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = "uspInsertResolution";

                cmdSQL.Parameters.Add(new SqlParameter("@TicketID", SqlDbType.Int));
                cmdSQL.Parameters["@TicketID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@TicketID"].Value = intTicketID;

                cmdSQL.Parameters.Add(new SqlParameter("@IncidentNo", SqlDbType.Int));
                cmdSQL.Parameters["@IncidentNo"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@IncidentNo"].Value = intIncidentNo;

                cmdSQL.Parameters.Add(new SqlParameter("@ResNo", SqlDbType.Int));
                cmdSQL.Parameters["@ResNo"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@ResNo"].Value = intResNo;

                cmdSQL.Parameters.Add(new SqlParameter("@ResDesc", SqlDbType.NVarChar, 500));
                cmdSQL.Parameters["@ResDesc"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@ResDesc"].Value = strResDesc;


                cmdSQL.Parameters.Add(new SqlParameter("@DateFix", SqlDbType.DateTime));
                cmdSQL.Parameters["@DateFix"].Direction = ParameterDirection.Input;
                if (datDateFix != DateTime.MinValue)
                {
                    cmdSQL.Parameters["@DateFix"].Value = datDateFix;
                }
                else
                {
                    cmdSQL.Parameters["@DateFix"].Value = DBNull.Value;
                }


                cmdSQL.Parameters.Add(new SqlParameter("@DateOnsite", SqlDbType.DateTime));
                cmdSQL.Parameters["@DateOnsite"].Direction = ParameterDirection.Input;
                if(datDateFix != DateTime.MinValue)
                {
                    cmdSQL.Parameters["@DateOnsite"].Value = datDateOnSite;
                }
                else
                {
                    cmdSQL.Parameters["@DateOnsite"].Value = DBNull.Value;
                }


                cmdSQL.Parameters.Add(new SqlParameter("@TechID", SqlDbType.Int));
                cmdSQL.Parameters["@TechID"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@TechID"].Value = intTechID;

                cmdSQL.Parameters.Add(new SqlParameter("@Hours", SqlDbType.Decimal));
                cmdSQL.Parameters["@Hours"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@Hours"].Value = decHours;


                cmdSQL.Parameters.Add(new SqlParameter("@Mileage", SqlDbType.Decimal));
                cmdSQL.Parameters["@Mileage"].Direction = ParameterDirection.Input;
                if(decMileage != -1.00M)
                {
                    cmdSQL.Parameters["@Mileage"].Value = decMileage;
                }
                else
                {
                    cmdSQL.Parameters["@Mileage"].Value = DBNull.Value;
                }


                cmdSQL.Parameters.Add(new SqlParameter("@CostMiles", SqlDbType.Money));
                cmdSQL.Parameters["@CostMiles"].Direction = ParameterDirection.Input;
                if (decMileageCost != -1.00M)
                {
                    cmdSQL.Parameters["@CostMiles"].Value = decMileageCost;
                }
                else
                {
                    cmdSQL.Parameters["@CostMiles"].Value = DBNull.Value;
                }


                cmdSQL.Parameters.Add(new SqlParameter("@Supplies", SqlDbType.Money));
                cmdSQL.Parameters["@Supplies"].Direction = ParameterDirection.Input;
                if (decSupplies != -1.00M)
                {
                    cmdSQL.Parameters["@Supplies"].Value = decSupplies;
                }
                else
                {
                    cmdSQL.Parameters["@Supplies"].Value = DBNull.Value;
                }


                cmdSQL.Parameters.Add(new SqlParameter("@Misc", SqlDbType.Money));
                cmdSQL.Parameters["@Misc"].Direction = ParameterDirection.Input;
                if (decMisc != -1.00M)
                {
                    cmdSQL.Parameters["@Misc"].Value = decMisc;
                }
                else
                {
                    cmdSQL.Parameters["@Misc"].Value = DBNull.Value;
                }


                cmdSQL.Parameters.Add(new SqlParameter("@NoCharge", SqlDbType.Int));
                cmdSQL.Parameters["@NoCharge"].Direction = ParameterDirection.Input;
                cmdSQL.Parameters["@NoCharge"].Value = intNoCharge;

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                try
                {
                    intRetCode = cmdSQL.ExecuteNonQuery();
                }

                catch (Exception ex)
                {
                    blnOk = false;
                }

                finally
                {
                    cnSQL.Close();
                    cnSQL.Dispose();
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                }
            }

            if (blnOk == false)
            {
                return -1;
            }

            else
            {
                return 0;
            }
        }

        //***Uses uspGetOpenProblems stored procedure to fill datagrid with any open problems***
        public static DataSet GetReport(String strReport)
        {
            SqlConnection cnSQL;
            SqlCommand cmdSQL;
            SqlDataAdapter daSQL;
            DataSet dsSQL = null;
            Boolean blnErrorOccurred = false;
            Int32 intRetCode;

            cnSQL = AcquireConnection();
            if (cnSQL == null)
            {
                return null;
            }
            else
            {
                cmdSQL = new SqlCommand();
                cmdSQL.Connection = cnSQL;
                cmdSQL.CommandType = CommandType.StoredProcedure;
                cmdSQL.CommandText = strReport;

                cmdSQL.Parameters.Add(new SqlParameter("@ErrCode", SqlDbType.Int));
                cmdSQL.Parameters["@ErrCode"].Direction = ParameterDirection.ReturnValue;

                dsSQL = new DataSet();
                try
                {
                    daSQL = new SqlDataAdapter(cmdSQL);
                    intRetCode = daSQL.Fill(dsSQL);
                    daSQL.Dispose();
                }
                catch (Exception ex)
                {
                    blnErrorOccurred = true;
                    dsSQL.Dispose();
                }
                finally
                {
                    cmdSQL.Parameters.Clear();
                    cmdSQL.Dispose();
                    cnSQL.Close();
                    cnSQL.Dispose();
                }
            }

            if (blnErrorOccurred)
            {
                return null;
            }
            else
            {
                return dsSQL;
            }
        }
    }
}