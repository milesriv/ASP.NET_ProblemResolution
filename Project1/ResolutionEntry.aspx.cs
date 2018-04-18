using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project1
{
    public partial class ResolutionEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                LoadTechnicians();

                //***ViewState variable used to determine if user has selected a Technician***
                ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;

                //***ViewState variable used to increment Resolution #***
                ViewState["ResolutionNumber"] = 1;
                lblResolutionNoActual.Text = ViewState["ResolutionNumber"].ToString();

                //***Set Ticket # to Session Variable set in OpenProblemList.aspx***
                if (Session.Contents["TicketID"] != null)
                {
                    lblTicketActual.Text = Session.Contents["TicketID"].ToString();
                }

                //***Set Problem # to Session Variable set in OpenProblemList.aspx***
                if (Session.Contents["IncidentNo"] != null)
                {
                    lblProblemNoActual.Text = Session.Contents["IncidentNo"].ToString();
                }

                //***Set Problem Description to Session Variable set in OpenProblemList.aspx***
                if (Session.Contents["ProblemDesc"] != null)
                {
                    lblProblemDesc.Text = Session.Contents["ProblemDesc"].ToString();
                }
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("OpenProblemList.aspx");
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

        //***Submit Button Event***
        //***Checks if Fields are valid first, if so, some information needs to be converted to be passed into clsDatabase.InsertResolution()***
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateFields())
            {
                Int32 intRetCode;

                DateTime datDateFixed;
                DateTime datDateOnSite;
                Decimal decHours;
                Decimal decMileage;
                Decimal decCostMiles;
                Decimal decSupplies;
                Decimal decMisc;

                //**********Date Fixed**********
                if (txtDateFixed.Text.Length > 0 )
                {
                    datDateFixed = Convert.ToDateTime(Convert.ToDateTime(txtDateFixed.Text));
                }
                else
                {
                    datDateFixed = DateTime.MinValue;
                }
                //**********Date Fixed**********


                //**********Date On Site**********
                if (txtDateOnsite.Text.Length > 0)
                {
                    datDateOnSite = Convert.ToDateTime(Convert.ToDateTime(txtDateOnsite.Text));
                }
                else
                {
                    datDateOnSite = DateTime.MinValue;
                }
                //**********Date On Site**********


                //**********Hours**********
                if (txtHours.Text.Length > 0)
                {
                    decHours = Convert.ToDecimal(Convert.ToDecimal(txtHours.Text));
                }
                else
                {
                    decHours = -1.00M;
                }
                //**********Hours**********


                //**********Mileage**********
                if (txtMileage.Text.Length > 0)
                {
                    decMileage = Convert.ToDecimal(Convert.ToDecimal(txtMileage.Text));
                }
                else
                {
                    decMileage = -1.00M;
                }
                //**********Mileage**********


                //**********Cost Miles**********
                if (txtCostMiles.Text.Length > 0)
                {
                    decCostMiles = Convert.ToDecimal(Convert.ToDecimal(txtCostMiles.Text));
                }
                else
                {
                    decCostMiles = -1.00M;
                }
                //**********Cost Miles**********


                //**********Supplies**********
                if (txtSupplies.Text.Length > 0)
                {
                    decSupplies = Convert.ToDecimal(Convert.ToDecimal(txtSupplies.Text));
                }
                else
                {
                    decSupplies = -1.00M;
                }
                //**********Supplies**********


                //**********Misc**********
                if (txtMisc.Text.Length > 0)
                {
                    decMisc = Convert.ToDecimal(Convert.ToDecimal(txtMisc.Text));
                }
                else
                {
                    decMisc = -1.00M;
                }
                //**********Misc**********


                //***Insert into Database***
                intRetCode = clsDatabase.InsertResolution(
                    Convert.ToInt32(lblTicketActual.Text),          //@TicketID
                    Convert.ToInt32(lblProblemNoActual.Text),       //@IncidentNo
                    Convert.ToInt32(lblResolutionNoActual.Text),    //@ResNo
                    txtResolutionDesc.Text,                         //@ResDesc
                    datDateFixed,                                   //@DateFix
                    datDateOnSite,                                  //@DateOnsite
                    Convert.ToInt32(ddlTechnician.SelectedValue),   //@TechID
                    decHours,                                       //@Hours
                    decMileage,                                     //@Mileage
                    decCostMiles,                                   //@CostMiles
                    decSupplies,                                    //@Supplies
                    decMisc,                                        //@Misc
                    Convert.ToInt32(chkNoCharge.Checked));          //@NoCharge


                if (intRetCode == 0)
                {
                    lblError.Text = "Resolution recieved. Ready for next Resolution.";

                    txtResolutionDesc.Text = "";
                    txtHours.Text = "";
                    txtMileage.Text = "";
                    txtCostMiles.Text = "";
                    txtSupplies.Text = "";
                    txtMisc.Text = "";
                    txtDateFixed.Text = "";
                    txtDateOnsite.Text = "";

                    chkNoCharge.Checked = false;

                    ddlTechnician.SelectedIndex = 0;
                    ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;

                    //***Incrementing Resolution #***
                    Int32 intResoNo = Convert.ToInt32(ViewState["ResolutionNumber"]);
                    intResoNo++;
                    ViewState["ResolutionNumber"] = intResoNo;
                    lblResolutionNoActual.Text = ViewState["ResolutionNumber"].ToString();
                }

                else
                {
                    lblError.Text = "Error adding Resolution";
                }
            }
        }

        //***Validate Data including unrequired text fields for proper Database entry***
        private Boolean ValidateFields()
        {
            Boolean blnOk = true;
            String strMessage = "";
            Decimal decTestNumeric;
            DateTime datParse;

            //***Check a Technician is selected***
            if (ViewState["SelectedTech"].ToString() == "0")
            {
                blnOk = false;
                strMessage += "Please Select a Technician. <br>";
            }

            //***Check Problem Description text box is populated***
            if (txtResolutionDesc.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "Resolution Description is required. <br>";
            }

            //**********Hours Checks**********
            if (txtHours.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "Hours is required. <br>";
            }

            else if (decimal.TryParse(txtHours.Text.Trim(), out decTestNumeric) == false)
            {
                blnOk = false;
                strMessage += "Hours must be numeric. <br>";
            }

            else
            {
                if (Convert.ToDecimal(txtHours.Text.Trim()) < 0)
                {
                    blnOk = false;
                    strMessage += "Hours must be greater than zero. <br>";
                }
            }
            //**********Hours Checks**********


            //**********Mileage Checks**********
            if (txtMileage.Text.Trim().Length != 0)
            {
                if (decimal.TryParse(txtMileage.Text.Trim(), out decTestNumeric) == false)
                {
                    blnOk = false;
                    strMessage += "Mileage must be numeric. <br>";
                }

                else
                {
                    if (Convert.ToDecimal(txtMileage.Text.Trim()) < 0)
                    {
                        blnOk = false;
                        strMessage += "Mileage must be greater than zero. <br>";
                    }
                }
            }
            //**********Mileage Checks**********


            //**********Supplies Checks**********
            if (txtSupplies.Text.Trim().Length != 0)
            {
                if (decimal.TryParse(txtSupplies.Text.Trim(), out decTestNumeric) == false)
                {
                    blnOk = false;
                    strMessage += "Supplies must be numeric. <br>";
                }

                else
                {
                    if (Convert.ToDecimal(txtSupplies.Text.Trim()) < 0)
                    {
                        blnOk = false;
                        strMessage += "Supplies must be greater than zero. <br>";
                    }
                }
            }
            //**********Supplies Checks**********


            //**********Misc Checks**********
            if (txtMisc.Text.Trim().Length != 0)
            {
                if (decimal.TryParse(txtMisc.Text.Trim(), out decTestNumeric) == false)
                {
                    blnOk = false;
                    strMessage += "Misc must be numeric. <br>";
                }

                else
                {
                    if (Convert.ToDecimal(txtMisc.Text.Trim()) < 0)
                    {
                        blnOk = false;
                        strMessage += "Misc must be greater than zero. <br>";
                    }
                }
            }
            //**********Misc Checks**********


            //**********Date Fixed Checks**********
            if (txtDateFixed.Text.Trim().Length != 0)
            {
                if (txtDateFixed.Text.Trim().Length != 10)
                {
                    blnOk = false;
                    strMessage += "Date Fixed must be in correct format MM/DD/YYYY <br>";
                }
                else
                {
                    if (DateTime.TryParse(txtDateFixed.Text.Trim(), out datParse) == false)
                    {
                        blnOk = false;
                        strMessage += "Date Fixed must be in correct format MM/DD/YYYY <br>";
                    }

                    else
                    {
                        String strDateTest = Convert.ToDateTime(txtDateFixed.Text.Trim()).ToString("MM/dd/yyyy");

                        if (txtDateFixed.Text.Trim() != strDateTest)
                        {
                            blnOk = false;
                            strMessage += "Date Fixed must be in correct format MM/DD/YYYY <br>";
                        }

                        else
                        {
                            if (Convert.ToDateTime(txtDateFixed.Text.Trim()) >= DateTime.Now)
                            {
                                blnOk = false;
                                strMessage += "Date Fixed must be less than or equal to current date. <br>";
                            }
                        }
                    }
                }
            }
            //**********Date Fixed Checks**********


            //**********Date Onsite Checks**********
            if (txtDateOnsite.Text.Trim().Length != 0)
            {
                if (txtDateOnsite.Text.Trim().Length != 10)
                {
                    blnOk = false;
                    strMessage += "Date Onsite must be in correct format MM/DD/YYYY <br>";
                }
                else
                {
                    if (DateTime.TryParse(txtDateOnsite.Text.Trim(), out datParse) == false)
                    {
                        blnOk = false;
                        strMessage += "Date Onsite must be in correct format MM/DD/YYYY <br>";
                    }

                    else
                    {
                        String strDateTest = Convert.ToDateTime(txtDateOnsite.Text.Trim()).ToString("MM/dd/yyyy");

                        if (txtDateOnsite.Text.Trim() != strDateTest)
                        {
                            blnOk = false;
                            strMessage += "Date Onsite must be in correct format MM/DD/YYYY <br>";
                        }

                        else
                        {
                            if (Convert.ToDateTime(txtDateOnsite.Text.Trim()) >= DateTime.Now)
                            {
                                blnOk = false;
                                strMessage += "Date Onsite must be less than or equal to current date. <br>";
                            }
                        }
                    }
                }
            }
            //**********Date Onsite Checks**********

            lblError.Text = strMessage;
            return blnOk;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            txtResolutionDesc.Text = "";
            txtHours.Text = "";
            txtMileage.Text = "";
            txtCostMiles.Text = "";
            txtSupplies.Text = "";
            txtMisc.Text = "";
            txtDateFixed.Text = "";
            txtDateOnsite.Text = "";

            chkNoCharge.Checked = false;

            ddlTechnician.SelectedIndex = 0;
            ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;
        }

        //***Change ViewState variable to selected Technician for ValidateFields() check***
        protected void ddlTechnician_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;
        }
    }
}