using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project1
{
    public partial class ReportSelection1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                Session.Contents["Report"] = ddlReports.SelectedValue;
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Main.aspx");
        }

        protected void btnDisplayReport_Click(object sender, EventArgs e)
        {
            if (Session.Contents["Report"].ToString() != "SELECT")
            {
                Response.Redirect("ReportDisplay.aspx");
            }

            else
            {
                lblError.Text = "Please Select a Report";
            }
        }

        protected void ddlReports_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session.Contents["Report"] = ddlReports.SelectedValue;
        }
    }
}