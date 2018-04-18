using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Diagnostics;
using System.Configuration;

namespace Project1
{
    public partial class Technician : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                LoadTechnicians();
                Session["NewTech"] = "False";   //***Session Variable used to determine if a new Technician is being entered. Effects btnTechAccept behavior***
            }
        }

        protected void btnTechReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Main.aspx");
        }

        //***Procedure that populates Drop Down List with Technicians from Database***
        private void LoadTechnicians()
        {
            DataSet dsData;

            dsData = clsDatabase.GetTechnicianList();
            if (dsData == null)
            {
                lblError.Text = "Error retrieving Technicians";
            }
            else if (dsData.Tables.Count < 1)
            {
                lblError.Text = "Error retrieving Technicians";
                dsData.Dispose();
            }
            else if (dsData.Tables[0].Rows.Count < 1)
            {
                lblError.Text = "Error retrieving Technicians";
                dsData.Dispose();
            }
            else
            {
                ddlTechnician.DataSource = dsData.Tables[0];
                ddlTechnician.Items.Clear();
                ddlTechnician.AppendDataBoundItems = true;
                ddlTechnician.Items.Insert(0, new ListItem("--SELECT TECHNICIAN--", "0"));
                ddlTechnician.DataTextField = "TechName";
                ddlTechnician.DataValueField = "TechnicianID";
                ddlTechnician.DataBind();

                dsData.Dispose();
            }
        }

        //***Procedure that populates textboxes with information retrieved from Database***
        private void DisplayTechnician(string strTechID)
        {
            DataSet dsData;

            dsData = clsDatabase.GetTechnicianByID(strTechID);
            if (dsData == null)
            {
                lblError.Text = "Error retrieving Technician";
            }
            else if (dsData.Tables.Count < 1)
            {
                lblError.Text = "Error retrieving Technician";
                dsData.Dispose();
            }
            else
            {
                //Retrieve First Name
                if (dsData.Tables[0].Rows[0]["FName"] == DBNull.Value)
                {
                    txtFirstName.Text = "";
                }
                else
                {
                    txtFirstName.Text = dsData.Tables[0].Rows[0]["FName"].ToString();
                }

                //Retrieve Middle Initial
                if (dsData.Tables[0].Rows[0]["MInit"] == DBNull.Value)
                {
                    txtMiddleInitial.Text = "";
                }
                else
                {
                    txtMiddleInitial.Text = dsData.Tables[0].Rows[0]["MInit"].ToString();
                }

                //Retrieve Last Name
                if (dsData.Tables[0].Rows[0]["LName"] == DBNull.Value)
                {
                    txtLastName.Text = "";
                }
                else
                {
                    txtLastName.Text = dsData.Tables[0].Rows[0]["LName"].ToString();
                }

                //Retrieve E-mail
                if (dsData.Tables[0].Rows[0]["EMail"] == DBNull.Value)
                {
                    txtEMail.Text = "";
                }
                else
                {
                    txtEMail.Text = dsData.Tables[0].Rows[0]["EMail"].ToString();
                }

                //Retrieve Department
                if (dsData.Tables[0].Rows[0]["Dept"] == DBNull.Value)
                {
                    txtDepartment.Text = "";
                }
                else
                {
                    txtDepartment.Text = dsData.Tables[0].Rows[0]["Dept"].ToString();
                }

                //Retrieve Phone Number
                if (dsData.Tables[0].Rows[0]["Phone"] == DBNull.Value)
                {
                    txtPhone.Text = "";
                }
                else
                {
                    txtPhone.Text = dsData.Tables[0].Rows[0]["Phone"].ToString();
                }

                //Retrieve Hourly Rate
                if (dsData.Tables[0].Rows[0]["HRate"] == DBNull.Value)
                {
                    txtHourlyRate.Text = "";
                }
                else
                {
                    txtHourlyRate.Text = String.Format("{0:F2}", dsData.Tables[0].Rows[0]["HRate"]);
                }

                dsData.Dispose();
            }
        }

        //***Event Procedure that calls DisplayTechnician() if selecting a Technician
        //Or clear text fields if selecting placeholder***
        protected void ddlTechnician_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTechnician.SelectedIndex != 0)
            {
                DisplayTechnician(ddlTechnician.SelectedValue.ToString());
                btnTechRemove.Enabled = true;
                btnTechAccept.Enabled = true;
                btnTechAccept.Text = "Update";
                btnTechCancel.Enabled = true;
                btnTechClear.Enabled = true;
                btnNewTechnician.Enabled = false;
                ddlTechnician.Enabled = false;
                lblError.Text = "Updating Technician";
            }
            else
            {
                txtFirstName.Text = "";
                txtMiddleInitial.Text = "";
                txtLastName.Text = "";
                txtEMail.Text = "";
                txtDepartment.Text = "";
                txtPhone.Text = "";
                txtHourlyRate.Text = "";
                btnTechRemove.Enabled = false;
                btnTechAccept.Enabled = false;
                btnTechClear.Enabled = false;
                btnTechCancel.Enabled = false;
                btnNewTechnician.Enabled = true;
                lblError.Text = "";
            }
        }

        //***Button to add a new Technician
        //Sets "NewTech" Session Variable to "True" to change btnTechAccept behavior***
        protected void btnNewTechnician_Click(object sender, EventArgs e)
        {
            Session["NewTech"] = "True";

            ddlTechnician.Enabled = false;
            ddlTechnician.SelectedIndex = 0;
            btnTechRemove.Enabled = false;
            btnTechAccept.Enabled = true;
            btnTechCancel.Enabled = true;
            btnTechClear.Enabled = true;
            btnNewTechnician.Enabled = false;
            btnTechAccept.Text = "Accept";
            txtFirstName.Text = "";
            txtMiddleInitial.Text = "";
            txtLastName.Text = "";
            txtEMail.Text = "";
            txtDepartment.Text = "";
            txtPhone.Text = "";
            txtHourlyRate.Text = "";
            lblError.Text = "Adding New Technician";
        }

        //***Button that resets form back to original state***
        protected void btnTechCancel_Click(object sender, EventArgs e)
        {
            Session["NewTech"] = "False";

            ddlTechnician.Enabled = true;
            ddlTechnician.SelectedIndex = 0;
            btnTechRemove.Enabled = false;
            btnTechAccept.Enabled = false;
            btnTechClear.Enabled = false;
            btnTechCancel.Enabled = false;
            btnNewTechnician.Enabled = true;
            ddlTechnician.Enabled = true;
            txtFirstName.Text = "";
            txtMiddleInitial.Text = "";
            txtLastName.Text = "";
            txtEMail.Text = "";
            txtDepartment.Text = "";
            txtPhone.Text = "";
            txtHourlyRate.Text = "";
            lblError.Text = "";
        }

        //***Button that reloads selected Employees information or clears form***
        protected void btnTechClear_Click(object sender, EventArgs e)
        {
            if (ddlTechnician.SelectedIndex != 0)
            {
                DisplayTechnician(ddlTechnician.SelectedValue.ToString());
                lblError.Text = "Updating Technician";
            }
            else
            {
                txtFirstName.Text = "";
                txtMiddleInitial.Text = "";
                txtLastName.Text = "";
                txtEMail.Text = "";
                txtDepartment.Text = "";
                txtPhone.Text = "";
                txtHourlyRate.Text = "";
                lblError.Text = "Adding New Technician";
                btnTechRemove.Enabled = false;
            }
        }

        //***Button that calls either the uspUpdateTechnician or uspInsertTechnician Stored Procedures depending on if btnNewTechnician has been clicked or not***
        protected void btnTechAccept_Click(object sender, EventArgs e)
        {
            Int32 intRetValue;
            Int32 intSelected;

            lblError.Text = "";

            if (ValidateFields())
            {

                //Adding New Technician
                if (Session["NewTech"].ToString() == "True")
                {
                    intRetValue = clsDatabase.InsertTechnician(txtFirstName.Text.Trim(), txtMiddleInitial.Text.Trim(), txtLastName.Text.Trim(),
                        txtEMail.Text.Trim(), txtDepartment.Text.Trim(), txtPhone.Text.Trim(), txtHourlyRate.Text.Trim());

                    if (intRetValue != -1)
                    {
                        lblError.Text = "Technician Added";
                        ddlTechnician.Enabled = true;
                        btnNewTechnician.Enabled = true;
                        btnTechRemove.Enabled = true;
                        btnTechAccept.Text = "Update";
                        Session["NewTech"] = "False";
                        LoadTechnicians();
                        ddlTechnician.SelectedValue = intRetValue.ToString();
                    }
                    else
                    {
                        lblError.Text = "Error adding new Technician";
                    }
                }

                //Updating Exisiting Technician
                else
                {
                    intRetValue = clsDatabase.UpdateTechnician(ddlTechnician.SelectedValue.ToString(), txtFirstName.Text.Trim(), txtMiddleInitial.Text.Trim(), 
                        txtLastName.Text.Trim(), txtEMail.Text.Trim(), txtDepartment.Text.Trim(), txtPhone.Text.Trim(), txtHourlyRate.Text.Trim());

                    if (intRetValue == 0)
                    {
                        intSelected = Convert.ToInt32(ddlTechnician.SelectedValue);

                        lblError.Text = "Technician Updated";
                        ddlTechnician.Enabled = true;
                        btnNewTechnician.Enabled = true;
                        btnTechAccept.Text = "Update";
                        LoadTechnicians();
                        ddlTechnician.SelectedValue = intSelected.ToString();
                    }
                    else
                    {
                        lblError.Text = "Error updating Technician";
                    }
                }

            }
        }

        //***Calls uspDeleteTechnician Stored Procedure to delete Database entry based on selected index of Drop Down List***
        protected void btnTechRemove_Click(object sender, EventArgs e)
        {
            Int32 intRetValue;


            lblError.Text = "";

            intRetValue = clsDatabase.DeleteTechnician(ddlTechnician.SelectedValue.ToString());

            if (intRetValue == 0)
            {
                lblError.Text = "Technician Deleted";
                ddlTechnician.Enabled = true;
                btnNewTechnician.Enabled = true;
                txtFirstName.Text = "";
                txtMiddleInitial.Text = "";
                txtLastName.Text = "";
                txtEMail.Text = "";
                txtDepartment.Text = "";
                txtPhone.Text = "";
                txtHourlyRate.Text = "";
                btnTechRemove.Enabled = false;
                btnTechAccept.Enabled = false;
                btnTechClear.Enabled = false;
                btnTechCancel.Enabled = false;
                btnNewTechnician.Enabled = true;
                LoadTechnicians();
            }
            else
            {
                lblError.Text = "Error deleting Technician";
            }

        }

        //***Procedure to ensure required text boxes contain valid information***
        private Boolean ValidateFields()
        {
            Boolean blnOk = true;
            String strMessage = "";
            Int64 intTestPhoneNumeric;      //Variable to check if inputted Phone Number is numeric
            decimal decTestHRNumeric;       //Variable to check if inputted Hourly Rate is numeric
            decimal decTestZero = 0;        //Variable to check if inputted Hourly Rate is greater than zero
            decimal decTestPlaces = 0;      //Variable used to check if Hourly Rate has more than 2 decimal places
            Int32 intTestPlaces = 0;        //Variable used to check if Hourly Rate has more than 2 decimal places

            lblError.Text = "";

            //First Name
            if (txtFirstName.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "First Name is required. <br>";
            }

            //Last Name
            if (txtLastName.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "Last Name is required. <br>";
            }

            //**************Phone**************
            if (txtPhone.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "Phone Number is required. <br>";
            }

            else
            {

                if (txtPhone.Text.Trim().Length != 10)
                {
                    blnOk = false;
                    strMessage += "Phone Number must be 10 numbers in length. <br>";
                }

                if (Int64.TryParse(txtPhone.Text.Trim(), out intTestPhoneNumeric) == false)
                {
                    blnOk = false;
                    strMessage += "Phone Number must be numeric only. <br>";
                }

                if (txtPhone.Text.StartsWith("0"))
                {
                    blnOk = false;
                    strMessage += "Phone Number cannot start with zero. <br>";
                }
            }
            //**************Phone**************


            //**************Hourly Rate**************
            if (txtHourlyRate.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "Hourly Rate is required. <br>";
            }

            else if (decimal.TryParse(txtHourlyRate.Text.Trim(), out decTestHRNumeric) == false)
            {
                blnOk = false;
                strMessage += "Hourly Rate must be numeric only. <br>";
            }
            
            else

            {
                decTestZero = Convert.ToDecimal(txtHourlyRate.Text.Trim());
                decTestPlaces = decTestZero * 100;
                intTestPlaces = Convert.ToInt32(decTestPlaces);

                if (decTestZero <= 0)
                {
                    blnOk = false;
                    strMessage += "Hourly Rate must be greater than 0. <br>";
                }

                if (decTestPlaces != intTestPlaces)
                {
                    blnOk = false;
                    strMessage += "Hourly Rate cannot have more than two decimal places. <br>";
                }
            }
            //**************Hourly Rate**************


            lblError.Text = strMessage;
            return blnOk;
        }
    }
}