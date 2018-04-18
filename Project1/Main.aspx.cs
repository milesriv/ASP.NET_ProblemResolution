using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project1
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnService_Click(object sender, EventArgs e)
        {
            Response.Redirect("ServiceEvent.aspx");
        }

        protected void btnManage_Click(object sender, EventArgs e)
        {
            Response.Redirect("TechnicianInformation.aspx");
        }

        protected void btnProblem_Click(object sender, EventArgs e)
        {
            Response.Redirect("OpenProblemList.aspx");
        }

        protected void btnReports_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReportSelection.aspx");
        }
    }
}