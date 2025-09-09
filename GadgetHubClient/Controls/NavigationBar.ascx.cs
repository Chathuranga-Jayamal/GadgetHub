using GadgetHubClient.App_Code;
using System;
using System.Web.UI;

namespace GadgetHubClient.Controls
{
    public partial class NavigationBar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (AuthHelper.IsLoggedIn())
                {
                    // User is logged in, show logout button
                    pnlLogout.Visible = true;
                    pnlGuest.Visible = false;

                    // Show panels based on user type
                    var userType = AuthHelper.GetUserType();
                    switch (userType)
                    {
                        case "Admin":
                            pnlAdmin.Visible = true;
                            break;
                        case "Distributor":
                            pnlDistributor.Visible = true;
                            break;
                        case "Customer":
                            pnlCustomer.Visible = true;
                            break;
                    }
                }
                else
                {
                    // User is not logged in (is a guest)
                    pnlGuest.Visible = true;
                    pnlLogout.Visible = false;
                }
            }
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            AuthHelper.ClearAuthCookies();
            Response.Redirect("~/Default.aspx");
        }
    }
}
