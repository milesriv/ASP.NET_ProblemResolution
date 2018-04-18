using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project1
{
    public partial class ProblemList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                LoadProblems();
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Main.aspx");
        }

        //***Obtain a DataSet of Problems without a resolution from Database, then set said DataSet as gvProblems DataSource***
        private void LoadProblems()
        {
            DataSet dsData;

            lblError.Text = "";

            dsData = clsDatabase.GetOpenProblems();
            if (dsData == null)
            {
                lblError.Text = "Error retrieving Open Problems list";
            }
            else if (dsData.Tables.Count < 1)
            {
                lblError.Text = "Error retrieving Open Problems list";
                dsData.Dispose();
            }
            else
            {
                gvProblems.DataSource = dsData.Tables[0];
                gvProblems.DataBind();

                dsData.Dispose();
            }
        }

        //***Row Command event that determines which row has been selected when "Select" button is clicked. Takes User to ResolutionEntry.aspx***
        //***Stores Ticket ID, Problem #, and Problem Description in Session Variables for use in ResolutionEntry.aspx depending on row clicked***
        protected void gvProblems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Boolean blnOK = true;
            String strTicketID = "";
            String strIncidentNo = "";
            String strProblemDesc = "";

            lblError.Text = "";

            if (e.CommandName.Trim().ToUpper() == "SELECT")
            {
                try
                {
                    strTicketID = gvProblems.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text.ToString();
                }
                catch (Exception ex)
                {
                    blnOK = false;
                    lblError.Text = "Unable to find TicketID";
                }

                try
                {
                    strIncidentNo = gvProblems.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text.ToString();
                }
                catch (Exception ex)
                {
                    blnOK = false;
                    lblError.Text = "Unable to find Incident Number";
                }

                try
                {
                    strProblemDesc = gvProblems.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text.ToString();
                }
                catch (Exception ex)
                {
                    blnOK = false;
                    lblError.Text = "Unable to find Problem Description";
                }

                if (blnOK)
                {
                    Session.Contents["TicketID"] = strTicketID;
                    Session.Contents["IncidentNo"] = strIncidentNo;
                    Session.Contents["ProblemDesc"] = strProblemDesc;

                    Response.Redirect("ResolutionEntry.aspx");
                }
            }
        }
    }
}