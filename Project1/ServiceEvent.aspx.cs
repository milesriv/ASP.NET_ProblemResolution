using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project1
{
    public partial class ServiceEvent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                lblEventDateActual.Text = DateTime.Now.ToShortDateString();
                LoadClients();
                ViewState["Selected"] = ddlClient.SelectedIndex;    //***ViewState Variable to ensure user has selected a Technician***
            }
        }

        protected void btnServiceReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Main.aspx");
        }

        //***Procedure that populates Drop Down List with Technicians from Database***
        private void LoadClients()
        {
            DataSet dsData;

            dsData = clsDatabase.GetClientList();
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
                ddlClient.DataSource = dsData.Tables[0];
                ddlClient.Items.Clear();
                ddlClient.AppendDataBoundItems = true;
                ddlClient.Items.Insert(0, new ListItem("--SELECT CLIENT--", "0"));
                ddlClient.DataTextField = "ClientName";
                ddlClient.DataValueField = "ClientID";
                ddlClient.DataBind();

                dsData.Dispose();
            }
        }

        //***Submit button Event***
        //***Calls ValidateFields(), if all fields are ok, Inserts information into ServiceEvents Table and retrieves a new Ticket ID for ProblemEntry.aspx using uspInsertServiceEvent Stored Procedure***
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateFields())
            {
                Session.Contents["NewTicketID"] = clsDatabase.InsertServiceEvent(Convert.ToInt32(ddlClient.SelectedValue), DateTime.Now, txtPhone.Text, txtContact.Text);

                if (Convert.ToInt32(Session.Contents["NewTicketID"].ToString()) == -1)
                {
                    lblError.Text = "Unable to Insert Service Event";
                }

                else
                {
                    Response.Redirect("ProblemEntry.aspx");
                }
            }
        }

        //***Procedure to ensure required text boxes contain valid information and drop down list has a selection***
        private Boolean ValidateFields()
        {
            Boolean blnOk = true;
            String strMessage = "";
            Int64 intTestPhoneNumeric;

            //***Check a Client is selected***
            if (ViewState["Selected"].ToString() == "0")
            {
                blnOk = false;
                strMessage += "Please Select a Client. <br>";
            }


            //***********Phone Checks***********
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
            //***********Phone Checks***********


            //***Check Contact text box is populated***
            if (txtContact.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "Contact is required. <br>";
            }

            lblError.Text = strMessage;
            return blnOk;
        }

        protected void ddlClient_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["Selected"] = ddlClient.SelectedIndex;
        }
    }
}