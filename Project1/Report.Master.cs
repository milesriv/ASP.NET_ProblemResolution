using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project1
{
    public partial class Report : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblHeading.Text = "CCIS 2645 Page Heading " + DateTime.Now;
            }
        }
    }
}