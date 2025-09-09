using System;
using System.Web.UI;
using System.Collections.Generic;
using GadgetHubClient.App_Code.Models;

namespace GadgetHubClient.Customer
{
    public partial class MyOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!AuthHelper.IsLoggedIn())
            {
                Response.Redirect("~/Account/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                RegisterAsyncTask(new PageAsyncTask(async () =>
                {
                    var orders = await ApiClient.GetAsync<List<OrderDto>>("orders/myorders");
                    OrdersGridView.DataSource = orders;
                    OrdersGridView.DataBind();
                }));
            }
        }
    }
}