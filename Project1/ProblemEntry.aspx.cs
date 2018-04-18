using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project1
{
    public partial class ProblemEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                LoadTechnicians();
                LoadProducts();

                ViewState["SelectedProduct"] = ddlProducts.SelectedIndex;
                ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;

                //***ViewState variable used to increment Problem #***
                ViewState["ProblemNumber"] = 1;
                lblProblemNoActual.Text = ViewState["ProblemNumber"].ToString();

                if (Session.Contents["NewTicketID"] != null)
                {
                    lblTicketActual.Text = Session.Contents["NewTicketID"].ToString();
                }
            }
        }

        protected void btnReturnService_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceEvent.aspx");
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

        //***Procedure that populates Drop Down List with Products from Database***
        private void LoadProducts()
        {
            DataSet dsData;

            dsData = clsDatabase.GetProductList();
            if (dsData == null)
            {
                lblError.Text = "Error retrieving Products";
            }
            else if (dsData.Tables.Count < 1)
            {
                lblError.Text = "Error retrieving Products";
                dsData.Dispose();
            }
            else if (dsData.Tables[0].Rows.Count < 1)
            {
                lblError.Text = "Error retrieving Products";
                dsData.Dispose();
            }
            else
            {
                ddlProducts.DataSource = dsData.Tables[0];
                ddlProducts.Items.Clear();
                ddlProducts.AppendDataBoundItems = true;
                ddlProducts.Items.Insert(0, new ListItem("--SELECT PRODUCT--", "0"));
                ddlProducts.DataTextField = "ProductDesc";
                ddlProducts.DataValueField = "ProductID";
                ddlProducts.DataBind();

                dsData.Dispose();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateFields())
            {
                Int32 intRetCode = clsDatabase.InsertProblem(
                    Convert.ToInt32(lblTicketActual.Text),          //@TicketID
                    Convert.ToInt32(lblProblemNoActual.Text),       //@IncidentNo
                    txtProblem.Text,                                //@ProbDesc
                    Convert.ToInt32(ddlTechnician.SelectedValue),   //@TechID
                    ddlProducts.SelectedValue);                     //@ProductID

                if (intRetCode == -1)
                {
                    lblError.Text = "Error Inserting Problem into Database.";
                }

                else
                {
                    lblError.Text = "Problem recieved. Ready for next problem.";

                    ddlProducts.SelectedIndex = 0;
                    ddlTechnician.SelectedIndex = 0;
                    ViewState["SelectedProduct"] = ddlProducts.SelectedIndex;
                    ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;

                    //***Increment Problem #***
                    Int32 intProblemNumber = Convert.ToInt32(ViewState["ProblemNumber"]);
                    intProblemNumber++;
                    ViewState["ProblemNumber"] = intProblemNumber;
                    lblProblemNoActual.Text = ViewState["ProblemNumber"].ToString();

                    txtProblem.Text = "";
                }
            }
        }

        private Boolean ValidateFields()
        {
            Boolean blnOk = true;
            String strMessage = "";

            //***Check a Product is selected***
            if (ViewState["SelectedProduct"].ToString() == "0")
            {
                blnOk = false;
                strMessage += "Please Select a Product. <br>";
            }

            //***Check a Technician is selected***
            if (ViewState["SelectedTech"].ToString() == "0")
            {
                blnOk = false;
                strMessage += "Please Select a Technician. <br>";
            }

            //***Check Problem Description text box is populated***
            if (txtProblem.Text.Trim().Length < 1)
            {
                blnOk = false;
                strMessage += "Problem Description is required. <br>";
            }

            lblError.Text = strMessage;
            return blnOk;
        }

        //***Change ViewState variable to selected Product for ValidateFields() check***
        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["SelectedProduct"] = ddlProducts.SelectedIndex;
        }

        //***Change ViewState variable to selected Technician for ValidateFields() check***
        protected void ddlTechnician_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            ddlProducts.SelectedIndex = 0;
            ddlTechnician.SelectedIndex = 0;
            ViewState["SelectedProduct"] = ddlProducts.SelectedIndex;
            ViewState["SelectedTech"] = ddlTechnician.SelectedIndex;

            txtProblem.Text = "";
        }
    }
}