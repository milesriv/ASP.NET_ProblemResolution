using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Project1
{
    public partial class ReportDisplay1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session.Contents["Report"] == null)
                {
                    lblError.Text = "Unable to Retrieve Report";
                    lblTitle.Text = "Error Retrieving Report";
                    Page.Title = "Error Retrieving Report";
                }

                else
                {
                    LoadReport();
                }
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReportSelection.aspx");
        }

        private void LoadReport()
        {
            DataSet dsData = null;

            lblError.Text = "";

            switch (Session.Contents["Report"].ToString())
            {
                case "Institution":
                    dsData = clsDatabase.GetReport("uspProblemsByInstitution");
                    lblTitle.Text = "Problems By Institution";
                    Page.Title = "Problems By Institution";
                    break;

                case "Client":
                    dsData = clsDatabase.GetReport("uspProblemsByClient");
                    lblTitle.Text = "Problems By Client";
                    Page.Title = "Problems By Client";
                    break;

                case "Product":
                    dsData = clsDatabase.GetReport("uspProblemsByProduct");
                    lblTitle.Text = "Problems By Product";
                    Page.Title = "Problems By Product";
                    break;

                case "Technician":
                    dsData = clsDatabase.GetReport("uspProblemsByTechnician");
                    lblTitle.Text = "Problems By Technician";
                    Page.Title = "Problems By Technician";
                    break;
            }

            if (dsData == null)
            {
                lblError.Text = "No Reports to Display";
            }
            else if (dsData.Tables.Count < 1)
            {
                lblError.Text = "No Reports to Display";
                dsData.Dispose();
            }
            else
            {
                gvReport.DataSource = dsData.Tables[0];
                gvReport.DataBind();

                dsData.Dispose();
            }
        }
    }
}